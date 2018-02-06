{$R-,C-,Q-,O+,H+}

unit gpprofWriter;

interface

uses
  System.classes,
  System.SysUtils,
  system.Syncobjs;

var
  profCompressTicks     : boolean;
  profProcSize          : integer;
  profCompressThreads   : boolean;
  prfFreq        : Int64;

type

  // a record describing a proc enter/leave call
  TProcInfoRec = record
  public
    Tag : byte;
    Counter : Int64;
    ThreadId : Cardinal;
    procId : Integer;
    Ticks : Int64;
  end;

  TOnRemapThreads = function(thread: integer): integer;

  TSimpleBlockWriter = class
  private
    fFilename    : string;
    fBuf         : TBytes;
    fBufOffs     : integer;
    fFile        : TFileStream;
    fLock        : TCriticalSection;
    prfLastTick    : int64;
    fOnRemapThreads : tOnRemapThreads;

    function OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
    procedure WriteToFile(const buf; count: Cardinal);
    procedure Flush();
    procedure WriteTicks(ticks: int64);
    procedure WriteThread(thread: cardinal);

  public
    constructor Create(const aFilename : string);
    destructor Destroy; override;

    procedure WriteBuffer(const buffer; const aBufferSizeInBytes: cardinal);
    procedure WriteInt   (const int: integer);
    procedure WriteInt64 (const int: int64);
    procedure WriteCardinal   (const value: Cardinal);
    procedure WriteTag   (const tag: byte);
    procedure WriteID    (const id: integer; const aProcSize: byte);
    procedure WriteBool  (const bool: boolean);
    procedure WriteAnsiString  (const value: ansistring);


    procedure WriteHeader;
    procedure WriteProcInfoRec(const aProcInfoRec : TProcInfoRec);

    procedure EnterCriticalSection();
    procedure LeaveCriticalSection();

    property OnRemapThreads : TOnRemapThreads read fOnRemapThreads write fOnRemapThreads;

  end;


implementation

uses
  WinApi.Windows,
  GpProfH;

const
  BUFFER_SIZE = 64 * 1024;


{ TSimpleBlockWriter }


constructor TSimpleBlockWriter.Create(const aFilename: string);
begin
  fFilename := aFilename;
  SetLength(fBuf, BUFFER_SIZE);
  fBufOffs          := 0;
  fLock := TCriticalSection.Create();
  fFile := TFileStream.Create(fFilename, fmCreate,fmShareExclusive);
  prfLastTick         := -1;

end;

destructor TSimpleBlockWriter.Destroy;
begin
  Flush;
  fFile.free;
  SetLength(fBuf, 0);
  fLock.Free;
  inherited;
end;

procedure TSimpleBlockWriter.EnterCriticalSection;
begin
  fLock.Enter();
end;

procedure TSimpleBlockWriter.LeaveCriticalSection;
begin
  fLock.Leave;
end;

function TSimpleBlockWriter.OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
begin
  Result := pointer(Cardinal(ptr)+offset);
end;


procedure TSimpleBlockWriter.WriteHeader;
begin
  WriteTag(PR_PRFVERSION);
  WriteInt(PRF_VERSION);
  WriteTag(PR_COMPTICKS);
  WriteBool(profCompressTicks);
  WriteTag(PR_COMPTHREADS);
  WriteBool(profCompressThreads);
  WriteTag(PR_FREQUENCY);
  WriteTicks(prfFreq);
  WriteTag(PR_PROCSIZE);
  WriteInt(profProcSize);
  WriteTag(PR_ENDHEADER);
end; { WriteHeader }

procedure TSimpleBlockWriter.WriteTicks(ticks: int64);
type
  TTick = array [1..8] of Byte;
var
  diff: integer;
begin
  if not profCompressTicks then
    WriteInt64(ticks)
  else begin
    if prfLastTick = -1 then diff := 8
    else begin
      diff := 8;
      while (diff > 0) and (TTick(ticks)[diff] = TTick(prfLastTick)[diff]) do
        Dec(diff);
      Inc(diff);
    end;
    WriteBuffer(diff, 1);
    WriteBuffer(ticks, diff);
    prfLastTick := ticks;
  end;
end; { WriteTicks }

procedure TSimpleBlockWriter.WriteAnsiString(const value: ansistring);
begin
  WriteCardinal(Length(value));
  if Length(Value)>0 then
    WriteToFile(value[1], Length(value));
end;

procedure TSimpleBlockWriter.WriteBool(const bool: boolean);
begin
  WriteToFile(bool, 1);
end;

procedure TSimpleBlockWriter.WriteBuffer(const buffer;
  const aBufferSizeInBytes: cardinal);
begin
  WriteToFile(buffer, aBufferSizeInBytes);
end;

procedure TSimpleBlockWriter.WriteCardinal(const value: Cardinal);
begin
  WriteToFile(value, SizeOf(Cardinal));
end;

procedure TSimpleBlockWriter.WriteID(const id: integer; const aProcSize: byte);
begin
  WriteToFile(id, aProcSize);
end;

procedure TSimpleBlockWriter.WriteInt(const int: integer);
begin
  WriteToFile(int, SizeOf(integer));
end;


procedure TSimpleBlockWriter.WriteInt64(const int: int64);
begin
  WriteToFile(int, SizeOf(int64));
end;

procedure TSimpleBlockWriter.WriteProcInfoRec(const aProcInfoRec: TProcInfoRec);
begin
  if aProcInfoRec.Counter <> 0 then
    WriteTicks(aProcInfoRec.Counter);
  WriteTag(aProcInfoRec.Tag);
  WriteThread(aProcInfoRec.ThreadId);
  WriteID(aProcInfoRec.procId,profProcSize);
  WriteTicks(aProcInfoRec.Ticks);
end;

procedure TSimpleBlockWriter.WriteThread(thread: cardinal);
const
  marker: integer = 0;
var
  remap: integer;
begin
  if not profCompressThreads then
    WriteBuffer(thread, Sizeof(integer))
  else
  begin
    if not Assigned(fOnRemapThreads) then
      raise Exception.create('OnRemapThreads is not valid');
    remap := fOnRemapThreads(thread);
    //remap := prfThreads.Remap(thread);
    if prfThreads.Count >= prfMaxThreadNum then begin
      WriteBuffer(marker, prfThreadBytes);
      prfMaxThreadNum := 2 * prfMaxThreadNum;
      prfThreadBytes := prfThreadBytes + 1;
    end;
    WriteBuffer(remap, prfThreadBytes);
  end;
end; { WriteThread }



procedure TSimpleBlockWriter.WriteTag(const tag: byte);
begin
  WriteToFile(tag, SizeOf(byte));
end;

procedure TSimpleBlockWriter.WriteToFile(const buf; count: Cardinal);
var
  res    : boolean;
  place  : Cardinal;
  bufp   : pointer;
  written: Cardinal;
begin
  place := BUFFER_SIZE-fBufOffs;
  if place <= count then
  begin
    Move(buf,OffsetPtr(fBuf,fBufOffs)^,place); // fill the buffer
    fBufOffs := BUFFER_SIZE;
    Flush;
    Dec(count,place);
    bufp := OffsetPtr(@buf,place);
    while count >= BUFFER_SIZE do
    begin
      Move(bufp^,fBuf[0],BUFFER_SIZE);
      written := fFile.Write(fBuf[0],BUFFER_SIZE);
      Dec(count,BUFFER_SIZE);
      bufp := OffsetPtr(bufp,BUFFER_SIZE);
    end; //while
  end
  else bufp := @buf;
  if count > 0 then begin // store leftovers
    Move(bufp^,OffsetPtr(fBuf,fBufOffs)^,count);
    Inc(fBufOffs,count);
  end;
end;


procedure TSimpleBlockWriter.Flush;
var
  written: Cardinal;
begin
  written := fFile.Write(fBuf[0], BUFFER_SIZE);
  fBufOffs := 0;
  FillChar(fBuf[0], BUFFER_SIZE, 0);
end;

end.
