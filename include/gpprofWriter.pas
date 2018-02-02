{$R-,C-,Q-,O+,H+}

unit gpprofWriter;

interface

uses
  System.classes,
  System.SysUtils,
  system.Syncobjs;

type
  TSimpleBlockWriter = class
  private
    fFilename    : string;
    fBuf         : pointer;
    fBufOffs     : integer;
    fFile        : THandle;
    fLock        : TCriticalSection;

    function OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
    procedure WriteToFile(const buf; count: Cardinal);
    procedure Flush();
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

    procedure EnterCriticalSection();
    procedure LeaveCriticalSection();

  end;


implementation

uses WinApi.Windows;

const
  BUFFER_SIZE = 64 * 1024;


{ TSimpleBlockWriter }


constructor TSimpleBlockWriter.Create(const aFilename: string);
begin
  fFilename := aFilename;
  fBuf              := VirtualAlloc(nil, BUFFER_SIZE, MEM_RESERVE + MEM_COMMIT, PAGE_READWRITE);
  fBufOffs          := 0;
  Win32Check(VirtualLock(fBuf, BUFFER_SIZE));
  Win32Check(fBuf <> nil);
  FillChar(fBuf^, BUFFER_SIZE, 0);
  fLock := TCriticalSection.Create();
  fFile := CreateFile(PChar(fFilename), GENERIC_WRITE, 0, nil, CREATE_ALWAYS,
                        FILE_ATTRIBUTE_NORMAL + FILE_FLAG_WRITE_THROUGH +
                        FILE_FLAG_NO_BUFFERING, 0);
  Win32Check(fFile <> INVALID_HANDLE_VALUE);
end;

destructor TSimpleBlockWriter.Destroy;
begin
  Flush;
  Win32Check(CloseHandle(fFile));
  Win32Check(VirtualUnlock(fBuf, BUFFER_SIZE));
  Win32Check(VirtualFree(fBuf, 0, MEM_RELEASE));
  fLock.Free;
  inherited;
end;

procedure TSimpleBlockWriter.EnterCriticalSection;
begin
  fLock.Enter();
end;

function TSimpleBlockWriter.OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
begin
  Result := pointer(Cardinal(ptr)+offset);
end;


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
  if place <= count then begin
    Move(buf,OffsetPtr(fBuf,fBufOffs)^,place); // fill the buffer
    fBufOffs := BUFFER_SIZE;
    Flush;
    Dec(count,place);
    bufp := OffsetPtr(@buf,place);
    while count >= BUFFER_SIZE do begin
      Move(bufp^,fBuf^,BUFFER_SIZE);
      res := WriteFile(fFile,fBuf^,BUFFER_SIZE,written,nil);
      if not res then RaiseLastWin32Error;
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
  Win32Check(WriteFile(fFile, fBuf^, BUFFER_SIZE, written, nil));
  fBufOffs := 0;
  FillChar(fBuf^, BUFFER_SIZE, 0);
end;

procedure TSimpleBlockWriter.LeaveCriticalSection;
begin
  fLock.Leave;
end;

end.
