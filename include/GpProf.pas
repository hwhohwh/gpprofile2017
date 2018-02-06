{$R-,C-,Q-,O+,H+}

(*
  1.11: 1999-08-12
    - Added support for Delphi 5.
  1.1: 1999-08-10
    - Fixed long-standing bug that caused corrupted profile file when profiling
      large projects.
  1.0.1: 1999-05-12
    - Support for DLL and package profiling (GetModuleName is used instead of
      ParamStr(0)).
    - Error is reported if <module>.gpi or <module>.gpd file is not found.
*)

unit gpprof;

interface

{$WARN SYMBOL_PLATFORM OFF}
{$WARN SYMBOL_DEPRECATED OFF}

uses System.Classes;

procedure ProfilerStart;
procedure ProfilerStop;
procedure ProfilerStartThread;
procedure ProfilerEnterProc(procID: integer);
procedure ProfilerExitProc(procID: integer);
procedure ProfilerTerminate;
procedure NameThreadForDebugging(AThreadName: AnsiString; AThreadID: TThreadID = TThreadID(-1)); overload;
procedure NameThreadForDebugging(AThreadName: string; AThreadID: TThreadID = TThreadID(-1)); overload;

implementation

uses
  System.Generics.Collections,
  Windows,
  SysUtils,
  IniFiles,
  GpProfWriter,
  GpProfH,
  GpProfCommon;


type
  TInt64 = TLargeInteger;

  TTLEl = record
    tleThread: integer;
    tleRemap : integer;
  end;

  PTLElements = ^TTLElements;
  TTLElements = array [0..0] of TTLEl;

  TThreadList = class
  private
    tlItems: PTLElements;
    tlCount: integer;
    tlRemap: integer;
    tlLast : integer;
    tlLastR: integer;
    function Search(thread: integer; var remap, insertIdx: integer): boolean;
  public
    constructor Create;
    destructor  Destroy; override;
    function    Remap(thread: integer): integer;
    property    Count: integer read tlCount;
  end;

  TThreadInformation = class
    ID : cardinal;
    Name : ansistring;
  end;

  TThreadInformationList = TObjectList<TThreadInformation>;

var
  prfWriter      : TSimpleBlockWriter;
  prfCounter     : int64;
  prfDoneMsg     : integer;
  prfModuleName  : string;
  prfName        : string;
  prfRunning     : boolean;

  prfOnlyThread  : Cardinal;
  prfThreads     : TThreadList;
  prfThreadsInfo : TThreadInformationList;
  prfThreadBytes : integer;
  prfMaxThreadNum: integer;
  prfInitialized : boolean;
  prfDisabled    : boolean;



  profProfilingAutostart: boolean;
  profPrfOutputFile     : string;
  profTableName         : string;




procedure profilerEnterProc(procID : integer);
var
  ct : Cardinal;
  cnt: int64;
  LProcInfoRec : TProcInfoRec:
begin
  QueryPerformanceCounter(cnt);
  ct := GetCurrentThreadID;
{$B+}
  if prfRunning and ((prfOnlyThread = 0) or (prfOnlyThread = ct)) then begin
{$B-}
    prfWriter.EnterCriticalSection();
    try
      LProcInfoRec := Default(TProcInfoRec);
      LProcInfoRec.Tag := PR_ENTERPROC;
      LProcInfoRec.Counter := prfCounter;
      LProcInfoRec.ThreadId := ct;
      LProcInfoRec.procId := procID;
      LProcInfoRec.Ticks := Cnt;
      QueryPerformanceCounter(prfCounter);
    finally
      prfWriter.LeaveCriticalSection();
    end;
  end;
end; { ProfilerEnterProc }

procedure ProfilerExitProc(procID : integer);
var
  ct : integer;
  cnt: TLargeinteger;
begin
  QueryPerformanceCounter(Cnt);
  ct := GetCurrentThreadID;
{$B+}
  if prfRunning and ((prfOnlyThread = 0) or (prfOnlyThread = ct)) then begin
{$B-}
    prfWriter.EnterCriticalSection();
    try
      LProcInfoRec := Default(TProcInfoRec);
      LProcInfoRec.Tag := PR_EXITPROC;
      LProcInfoRec.Counter := prfCounter;
      LProcInfoRec.ThreadId := ct;
      LProcInfoRec.procId := procID;
      LProcInfoRec.Ticks := Cnt;
      QueryPerformanceCounter(prfCounter);
    finally
      prfWriter.LeaveCriticalSection();
    end;
  end;
end; { ProfilerExitProc }

procedure ProfilerStart;
begin
  if not prfDisabled then begin
    prfWriter.EnterCriticalSection();
    try
      prfRunning := true;
    finally
      prfWriter.LeaveCriticalSection();
    end;
  end;
end; { ProfilerStart }

procedure ProfilerStop;
begin
  if not prfDisabled then begin
    prfWriter.EnterCriticalSection();
    try
      prfRunning := false;
    finally
      prfWriter.LeaveCriticalSection();
    end;
  end;
end; { ProfilerStop }

procedure ProfilerStartThread;
begin
  prfWriter.EnterCriticalSection();
  try
    prfRunning := true;
    prfOnlyThread := GetCurrentThreadID;
  finally
    prfWriter.LeaveCriticalSection();
  end;
end; { ProfilerStartThread }

function CombineNames(fName, newExt: string): string;
begin
  Result := Copy(fName,1,Length(fName)-Length(ExtractFileExt(fName)))+'.'+newExt;
end; { CombineNames }

procedure NameThreadForDebugging(AThreadName: AnsiString; AThreadID: TThreadID = TThreadID(-1)); overload;
begin
  NameThreadForDebugging(string(aThreadName), aThreadID);
end; { NameThreadForDebugging }


procedure NameThreadForDebugging(AThreadName: string; AThreadID: TThreadID = TThreadID(-1)); overload;
var LEntry : TThreadInformation;
begin
  TThread.NameThreadForDebugging(aThreadName, aThreadId);
  if not prfDisabled then
  begin
    LEntry := TThreadInformation.Create;
    LEntry.ID := AThreadId;
    LEntry.Name := AThreadName;
    prfThreadsInfo.Add(LEntry);
  end;
end; { NameThreadForDebugging }


{ TThreadList }

constructor TThreadList.Create;
begin
  inherited Create;
  tlCount := 0;
  tlRemap := 0;
  tlItems := nil;
  tlLast := 0;
  tlLastR := 0;
end; { TThreadList.Create }

destructor TThreadList.Destroy;
begin
  if tlItems <> nil then Dispose(tlItems);
  inherited Destroy;
end; { TThreadList.Destroy }

function TThreadList.Remap(thread: integer): integer;
var
  remap   : integer;
  insert  : integer;
  tmpItems: PTLElements;
begin
  if thread = tlLast then Result := tlLastR
  else if not Search(thread, remap, insert) then begin
    // reallocate tlItems
    GetMem(tmpItems, SizeOf(TTLEl)*(tlCount+1));
    if tlItems <> nil then begin
      Move(tlItems^, tmpItems^, Sizeof(TTLEl)*tlCount);
      FreeMem(tlItems);
    end;
    tlItems := tmpItems;
    // get new remap number
    Inc(tlRemap);
    if byte(tlRemap) = 0 then Inc(tlRemap);
    // insert new element
    if insert < tlCount then
      Move(tlItems^[insert], tlItems^[insert + 1], (tlCount-insert)*SizeOf(TTLEl));
    with tlItems^[Insert] do begin
      tleThread := thread;
      tleRemap  := tlRemap;
    end;
    Inc(tlCount);
    tlLast  := thread;
    tlLastR := tlRemap;
    Result  := tlRemap;
  end
  else begin
    tlLast  := thread;
    tlLastR := remap;
    Result  := remap;
  end;
end; { TThreadList.Remap }

function TThreadList.Search(thread: integer; var remap, insertIdx: integer): boolean;
var
  l, m, h: integer;
  mid    : integer;
begin
  if tlCount = 0 then begin
    insertIdx := 0;
    Result := False;
  end
  else begin
    L := 0;
    H := tlCount - 1;
    repeat
      m := L + (H - L) div 2;
      mid := tlItems^[m].tleThread;
      if thread = mid then begin
        remap := tlItems^[m].tleRemap;
        Result := True;
        Exit;
      end else if thread < mid then H := m - 1
      else L := m + 1;
    until L > H;
    Result := False;
    if thread > mid then insertIdx := m + 1
                    else insertIdx := m;
  end;
end; { TThreadList.Search }

procedure ReadIncSettings;
var
  buf: array [0..256] of char;
  ini: string;
begin
  GetModuleFileName(HInstance,buf,256);
  prfModuleName := string(buf);
  prfDisabled := true;
  profProfilingAutostart := false;
  ini := Copy(prfModuleName,1,Length(prfModuleName)-Length(ExtractFileExt(prfModuleName)))+'.GPI';
  if not FileExists(ini) then
    MessageBox(0, PChar(Format('Cannot find initialization file %s! '+
      'Profiling will be disabled.', [ini])), 'GpProfile', MB_OK + MB_ICONERROR)
  else begin
    with TIniFile.Create(ini) do begin
      profTableName := ReadString('IDTables','TableName','');
      if profTableName <> '' then begin
        if not FileExists(profTableName) then
          MessageBox(0, PChar(Format('Cannot find data file %s! '+
            'Profiling will be disabled.', [profTableName])), 'GpProfile',
            MB_OK + MB_ICONERROR)
        else begin
          profProcSize           := ReadInteger('Procedures','ProcSize',4);
          profCompressTicks      := ReadBool('Performance','CompressTicks',false);
          profCompressThreads    := ReadBool('Performance','CompressThreads',false);
          profProfilingAutostart := ReadBool('Performance','ProfilingAutostart',true);
          profPrfOutputFile := ReadString('Output','PrfOutputFilename','$(ModulePath)');
          profPrfOutputFile := ResolvePrfRuntimePlaceholders(profPrfOutputFile);
          prfDisabled            := false;
        end;
      end;
      Free;
    end;
  end;
end; { ReadIncSettings }

procedure Initialize;
begin
  ReadIncSettings;
  if not prfDisabled then begin
    prfRunning          := profProfilingAutostart;
    prfCounter          := 0;
    prfOnlyThread       := 0;
    prfThreads          := TThreadList.Create;
    prfThreadsInfo      := TThreadInformationList.Create();
    prfMaxThreadNum     := 256;
    prfThreadBytes      := 1;
    prfDoneMsg          := RegisterWindowMessage(CMD_MESSAGE);
    prfName             := CombineNames(prfModuleName, 'prf');
    if profPrfOutputFile <> '' then
      prfName := profPrfOutputFile + '.prf';
    prfWriter := TSimpleBlockWriter.Create(prfName);
    prfWriter.OnRemapThreads := prfThreads.Remap;
    QueryPerformanceFrequency(prfFreq);
  end;
end; { Initialize }


procedure CopyTables;
var
  p: pointer;
  f: file;
begin
  if not FileExists(profTableName) then prfDisabled := true
  else begin
    Assign(f,profTableName);
    Reset(f,1);
    try
      GetMem(p,FileSize(f));
      try
        BlockRead(f,p^,FileSize(f));
        prfWriter.WriteBuffer(p^,FileSize(f));
      finally FreeMem(p); end;
    finally Close(f); end;
  end;
end; { CopyTables }

procedure WriteCalibration;
var
  i  : integer;
  run: boolean;
begin
  run := prfRunning;
  prfRunning := True;
  prfWriter.WriteTag(PR_STARTCALIB);
  prfWriter.WriteInt(CALIB_CNT);
  for i := 1 to CALIB_CNT + 1 do begin
    ProfilerEnterProc(0);
    ProfilerExitProc(0);
  end;
  FlushCounter;
  prfWriter.WriteTag(PR_ENDCALIB);
  prfRunning := run;
end; { WriteCalibration }

procedure Finalize;
begin
  prfWriter.Free;
  prfThreads.Free;
  prfThreadsInfo.free;
  PostMessage(HWND_BROADCAST, prfDoneMsg, CMD_DONE, 0);
end; { Finalize }

procedure ProfilerTerminate;
var i : integer;
begin
  if not prfInitialized then Exit;
  ProfilerStop;
  prfInitialized := False;
  FlushCounter;
  prfWriter.WriteTag(PR_ENDDATA);

  prfWriter.WriteTag(PR_START_THREADINFO);
  prfWriter.WriteCardinal(prfThreadsInfo.count);
  for i := 0 to prfThreadsInfo.count-1 do
  begin
    prfWriter.WriteCardinal(prfThreadsInfo[i].ID);
    prfWriter.WriteAnsiString(prfThreadsInfo[i].Name);
  end;
  prfWriter.WriteInt(PR_END_THREADINFO);
  Finalize;

end; { ProfilerTerminate }


initialization
  prfInitialized := false;
  Initialize;
  if not prfDisabled then begin
    prfWriter.WriteHeader;
    CopyTables;
    WriteCalibration;
    prfWriter.WriteTag(PR_STARTDATA);
    prfInitialized := true;
    gpprof.NameThreadForDebugging('Main Application Thread', MainThreadID);
  end;
finalization
  ProfilerTerminate;
end.

