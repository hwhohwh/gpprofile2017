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
  prfRunning     : boolean;

type

  TSimpleBlockWriter = class
  private
    fFilename    : string;
    fBuf         : pointer;
    fBufOffs     : integer;
    fFile        : THandle;
    fLock        : TCriticalSection;
    fLastTick    : int64;
    fThreadBytes : integer;
    fMaxThreadNum: integer;

    function OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
  public
    constructor Create(const aFilename : string);
    destructor Destroy; override;


    procedure WriteToFile(const buf; count: Cardinal);
    procedure Flush();
  end;


implementation

uses
  WinApi.Windows,
  GpProfH;

const
  BUF_SIZE = 64 * 1024;


{ TSimpleBlockWriter }


constructor TSimpleBlockWriter.Create(const aFilename: string);
begin
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

end;

destructor TSimpleBlockWriter.Destroy;
begin
  Flush;
  Win32Check(CloseHandle(fFile));
  Win32Check(VirtualUnlock(fBuf, BUF_SIZE));
  Win32Check(VirtualFree(fBuf, 0, MEM_RELEASE));
  fLock.Free;
  inherited;
end;

function TSimpleBlockWriter.OffsetPtr(ptr: pointer; offset: Cardinal): pointer;
begin
  Result := pointer(Cardinal(ptr)+offset);
end;


procedure TSimpleBlockWriter.WriteToFile(const buf; count: Cardinal);
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

end.
