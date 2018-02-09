{$R-,C-,Q-,O+,H+}

unit gpprofWriter;

interface

uses
  System.classes,
  System.SysUtils,
  system.Syncobjs,
  System.Generics.Collections;

var
  profCompressTicks     : boolean;
  profProcSize          : integer;
  profCompressThreads   : boolean;
  prfFreq        : Int64;
  prfRunning     : boolean;

type
  TAsyncJob = class
  public
    Buffer : Pointer;
    Length : Integer;
    constructor Create(const aSize : Integer);
    destructor Destroy;override;
  end;

  TSimpleBlockWriter = class(TThread)
  private
    fFilename    : string;
    fBuf         : pointer;
    fBufOffs     : integer;
    fFile        : THandle;
    fLock        : TCriticalSection;
    fLastTick    : int64;
    fThreadBytes : integer;
    fMaxThreadNum: integer;
    fAsyncQueue  : TThreadedQueue<TAsyncJob>;
    fShutdown : Boolean;
    function OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
    procedure WriteToFileImpl(const buf; count: Cardinal);
    procedure Flush();
  protected
    procedure Execute; override;
  public
    constructor Create(const aFilename : string);
    destructor Destroy; override;
    procedure WriteToFile(const buf; count: Cardinal);
    procedure ForceFlush();
    procedure ShutDown;
  end;


implementation

{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}


uses
  WinApi.Windows,
  GpProfH;

const
  BUF_SIZE = 64 * 1024;


{ TSimpleBlockWriter }


constructor TSimpleBlockWriter.Create(const aFilename: string);
begin
  inherited Create(True);
  fFilename := aFilename;
  fBuf              := VirtualAlloc(nil, BUF_SIZE, MEM_RESERVE + MEM_COMMIT, PAGE_READWRITE);
  fBufOffs          := 0;
  Win32Check(VirtualLock(fBuf, BUF_SIZE));
  Win32Check(fBuf <> nil);
  FillChar(fBuf^, BUF_SIZE, 0);
  fLock := TCriticalSection.Create();
  fFile := CreateFile(PChar(fFileName), GENERIC_WRITE, 0, nil, CREATE_ALWAYS,
                          FILE_ATTRIBUTE_NORMAL + FILE_FLAG_WRITE_THROUGH +
                          FILE_FLAG_NO_BUFFERING, 0);
  Win32Check(fFile <> INVALID_HANDLE_VALUE);
  fLastTick         := -1;
  fThreadBytes      := 1;
  fMaxThreadNum     := 256;
  fAsyncQueue := TThreadedQueue<TAsyncJob>.Create();
end;

destructor TSimpleBlockWriter.Destroy;
begin
  Flush;
  fAsyncQueue.free;
  Win32Check(CloseHandle(fFile));
  Win32Check(VirtualUnlock(fBuf, BUF_SIZE));
  Win32Check(VirtualFree(fBuf, 0, MEM_RELEASE));
  fLock.Free;
  inherited;
end;

procedure TSimpleBlockWriter.Execute;
var
  LJob : TAsyncJob;
  LKeepRunning : Boolean;
begin
  try
    NameThreadForDebugging('GPProf writer thread');
    LKeepRunning := true;
    while (LKeepRunning) do
    begin
      LKeepRunning := True;
      if fAsyncQueue.QueueSize = 0 then
        LJob := nil
      else
        LJob := fAsyncQueue.PopItem();
      // go back to sleep until next package arrives
      if not Assigned(LJob) then
      begin
        if fShutdown then
          LKeepRunning := False;
      end
      else
      begin
        WriteToFileImpl(LJob.Buffer^, LJob.Length);
        LJob.Free;
      end;
    end;
  except
  end;
end;

function TSimpleBlockWriter.OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
begin
  Result := pointer(Cardinal(ptr)+offset);
end;


procedure TSimpleBlockWriter.ShutDown;
begin
  fShutdown := true;
end;

procedure TSimpleBlockWriter.WriteToFile(const buf; count: Cardinal);
var LJob : TAsyncJob;
begin
  if count = 0 then
    Exit;
  if not Self.Started then
  begin
    WriteToFileImpl(buf,count);
  end
  else
  begin
    // create job for async execution; wake up thread
    LJob := TAsyncJob.Create(count);
    move(buf,LJob.Buffer^,count);
    fAsyncQueue.PushItem(LJob);
  end;
end;

procedure TSimpleBlockWriter.WriteToFileImpl(const buf; count: Cardinal);
var
  res    : boolean;
  place  : Cardinal;
  bufp   : pointer;
  written: Cardinal;
begin
  place := BUF_SIZE-fBufOffs;
  if place <= count then
  begin
    Move(buf,OffsetPtr(fBuf,fBufOffs)^,place); // fill the buffer
    fBufOffs := BUF_SIZE;
    Flush;
    Dec(count,place);
    bufp := OffsetPtr(@buf,place);
    while count >= BUF_SIZE do
    begin
      Move(bufp^,fBuf^,BUF_SIZE);
      res := WriteFile(fFile,fBuf^,BUF_SIZE,written,nil);
      if not res then RaiseLastWin32Error;
      Dec(count,BUF_SIZE);
      bufp := OffsetPtr(bufp,BUF_SIZE);
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
  Win32Check(WriteFile(fFile, fBuf^, BUF_SIZE, written, nil));
  fBufOffs := 0;
  FillChar(fBuf^, BUF_SIZE, 0);
end;

procedure TSimpleBlockWriter.ForceFlush;
begin
  if not Started then
    Flush;
end;

{ TAsyncJob }

constructor TAsyncJob.Create(const aSize : Integer);
begin
  GetMem(Buffer,aSize);
  Length := aSize;
end;

destructor TAsyncJob.Destroy;
begin
  if Assigned(Buffer) then
    FreeMem(Buffer, Length);
  inherited;
end;

end.
