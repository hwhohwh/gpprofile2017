{$I OPTIONS.INC}

unit gppmain;

interface

uses
  Registry, Messages, Classes, Forms, Windows, SysUtils, Graphics, Controls,
  Dialogs, StdCtrls, Menus, ComCtrls, GpParser, ExtCtrls, GpCheckLst, gpMRU,
  ActnList, ImgList, Buttons, ToolWin, gppResults, Grids,
  gpArrowListView, DProjUnit, SynEdit,
  SynEditHighlighter, SynEditCodeFolding, SynHighlighterPas, System.ImageList,
  System.Actions,gppCurrentPrefs, VirtualTrees,
  gppmain.tree;

const
  WM_ReloadProfile = WM_USER;
  WM_FormShow      = WM_USER+1;

type

  TfrmMain = class(TForm)
    Project1: TMenuItem;
    OpenDialog: TOpenDialog;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    actInstrument: TAction;
    actOpen: TAction;
    actExit: TAction;
    actPreferences: TAction;
    Instrument1: TMenuItem;
    Open2: TMenuItem;
    Exit1: TMenuItem;
    Preferences1: TMenuItem;
    imglButtons: TImageList;
    actRemoveInstrumentation: TAction;
    RemoveInstrumentation1: TMenuItem;
    actRun: TAction;
    Run1: TMenuItem;
    popRecent: TPopupMenu;
    Reopen1: TMenuItem;
    actRescanProject: TAction;
    Rescan1: TMenuItem;
    MRU: TGPMRUFiles;
    MainMenu1: TMainMenu;
    popDelphiVer: TPopupMenu;
    OpenProfilingData1: TMenuItem;
    actOpenProfile: TAction;
    popRecentPrf: TPopupMenu;
    ReopenProfilingData1: TMenuItem;
    MRUPrf: TGPMRUFiles;
    actInstrumentRun: TAction;
    Help1: TMenuItem;
    About1: TMenuItem;
    popAnalysisListview: TPopupMenu;
    mnuHideNotExecuted: TMenuItem;
    actHideNotExecuted: TAction;
    actProjectOptions: TAction;
    Options1: TMenuItem;
    actProfileOptions: TAction;
    Profile1: TMenuItem;
    ProfileOptions1: TMenuItem;
    InstrumentandRun1: TMenuItem;
    actRescanProfile: TAction;
    Rescan2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Export1: TMenuItem;
    actExportProfile: TAction;
    mnuExportProfile: TMenuItem;
    GpProfile1: TMenuItem;
    N1: TMenuItem;
    actMakeCopyProfile: TAction;
    N2: TMenuItem;
    SaveAs1: TMenuItem;
    actRenameMoveProfile: TAction;
    RenameMove1: TMenuItem;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    tbrProject: TToolBar;
    BtnOpenProject: TToolButton;
    btnRescanProject: TToolButton;
    BtnInstrumentAndRun: TToolButton;
    btnInstrument: TToolButton;
    btnRemoveInstrumentation: TToolButton;
    tbtnRun: TToolButton;
    btnProjectOptions: TToolButton;
    ToolBar2: TToolBar;
    btnOpenProfile: TToolButton;
    btnRescanProfile: TToolButton;
    btnExportProfile: TToolButton;
    btnProfileOptions: TToolButton;
    btnRenameMoveProfile: TToolButton;
    btnMakeCopyProfile: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton11: TToolButton;
    actDelUndelProfile: TAction;
    btnDelUndelProfile: TToolButton;
    Delete1: TMenuItem;
    pnlToolbarMain: TPanel;
    tbrMain: TToolBar;
    btnPreferences: TToolButton;
    SaveDialog1: TSaveDialog;
    Panel0: TPanel;
    Panel1: TPanel;
    PageControl1: TPageControl;
    tabInstrumentation: TTabSheet;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    pnlTop: TPanel;
    chkShowAll: TCheckBox;
    pnlUnits: TPanel;
    clbUnits: TGpCheckListBox;
    lblUnits: TStaticText;
    pnlClasses: TPanel;
    clbClasses: TGpCheckListBox;
    lblClasses: TStaticText;
    pnlProcs: TPanel;
    clbProcs: TGpCheckListBox;
    lblProcs: TStaticText;
    tabAnalysis: TTabSheet;
    PageControl2: TPageControl;
    tabProcedures: TTabSheet;
    tabClasses: TTabSheet;
    tabUnits: TTabSheet;
    tabThreads: TTabSheet;
    pnlSourcePreview: TPanel;
    splitSourcePreview: TSplitter;
    actRescanChanged: TAction;
    actChangeLayout: TAction;
    actAddLayout: TAction;
    actDelLayout: TAction;
    actRenameLayout: TAction;
    actLayoutManager: TAction;
    popLayout: TPopupMenu;
    pnlLayout: TPanel;
    inpLayoutName: TEdit;
    BtnDeleteLayout: TButton;
    btnActivateLayout: TButton;
    btnRenameLayout: TButton;
    btnAddLayout: TButton;
    SpeedButton1: TSpeedButton;
    Contents1: TMenuItem;
    N3: TMenuItem;
    Shortcutkeys1: TMenuItem;
    actHelpContents: TAction;
    actHelpShortcutKeys: TAction;
    actHelpAbout: TAction;
    btnHelpContents: TToolButton;
    imglListViews: TImageList;
    lvLayouts: TListView;
    actHelpQuickStart: TAction;
    QuickStart1: TMenuItem;
    Layout1: TMenuItem;
    LayoutManager1: TMenuItem;
    N7: TMenuItem;
    actShowHideSourcePreview: TAction;
    ShowSourcePreview1: TMenuItem;
    pnlToolbarLayout: TPanel;
    tbrLayout: TToolBar;
    btnLayoutManager: TToolButton;
    btnShowHideSourcePreview: TToolButton;
    actShowHideCallers: TAction;
    actShowHideCallees: TAction;
    HideCallers1: TMenuItem;
    HideCalled1: TMenuItem;
    btnShowHideCallers: TToolButton;
    btnShowHideCallees: TToolButton;
    pnThreadProcs: TPanel;
    pnlTopTwo: TPanel;
    pnlCallers: TPanel;
    splitCallers: TSplitter;
    pnlCurrent: TPanel;
    splitCallees: TSplitter;
    pnlCallees: TPanel;
    pnlBottom: TPanel;
    sourceCodeEdit: TSynEdit;
    pnlBrowser: TPanel;
    ToolBar3: TToolBar;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    actBrowsePrevious: TAction;
    actBrowseNext: TAction;
    popBrowsePrevious: TPopupMenu;
    popBrowseNext: TPopupMenu;
    actOpenCallGraph: TAction;
    N8: TMenuItem;
    actJumpToCallGraph: TAction;
    ToolButton21: TToolButton;
    actHelpOpenHome: TAction;
    actHelpWriteMail: TAction;
    N4: TMenuItem;
    GpProfileHomePage1: TMenuItem;
    WriteMailtoAuthor1: TMenuItem;
    Mailinglist1: TMenuItem;
    Forum1: TMenuItem;
    actHelpVisitForum: TAction;
    actHelpJoinMailingList: TAction;
    OpenDialog1: TOpenDialog;
    SynPasSyn: TSynPasSyn;
    vstClasses: TVirtualStringTree;
    pnThreadClass: TPanel;
    Label1: TLabel;
    cbxSelectThreadClass: TComboBox;
    lblSelectThreadProc: TLabel;
    cbxSelectThreadProc: TComboBox;
    vstThreads: TVirtualStringTree;
    pnThreadUnits: TPanel;
    Label2: TLabel;
    cbxSelectThreadUnit: TComboBox;
    vstUnits: TVirtualStringTree;
    vstProcs: TVirtualStringTree;
    vstCallers: TVirtualStringTree;
    vstCallees: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure MRUClick(Sender: TObject; LatestFile: String);
    procedure FormDestroy(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actPreferencesExecute(Sender: TObject);
    procedure cbProfileChange(Sender: TObject);
    procedure clbUnitsClick(Sender: TObject);
    procedure clbUnitsClickCheck(Sender: TObject; index: Integer);
    procedure clbProcsClickCheck(Sender: TObject; index: Integer);
    procedure actInstrumentExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actRescanProjectExecute(Sender: TObject);
    procedure clbClassesClick(Sender: TObject);
    procedure clbClassesClickCheck(Sender: TObject; index: Integer);
    procedure actRemoveInstrumentationExecute(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure WMReLoadProfile(var msg: TMessage); message WM_ReloadProfile;
    procedure actOpenProfileExecute(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure MRUPrfClick(Sender: TObject; LatestFile: String);
    procedure actInstrumentRunExecute(Sender: TObject);
    procedure btnCancelLoadClick(Sender: TObject);
    procedure cbxSelectThreadProcChange(Sender: TObject);
    procedure cbxSelectThreadClassChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StatusBarResize(Sender: TObject);
    procedure actHideNotExecutedExecute(Sender: TObject);
    procedure actProjectOptionsExecute(Sender: TObject);
    procedure actProfileOptionsExecute(Sender: TObject);
    procedure actRescanProfileExecute(Sender: TObject);
    procedure clbProcsClick(Sender: TObject);
    procedure lvProcsClick(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure actExportProfileExecute(Sender: TObject);
    procedure mnuExportProfileClick(Sender: TObject);
    procedure actMakeCopyProfileExecute(Sender: TObject);
    procedure actDelUndelProfileExecute(Sender: TObject);
    procedure actRenameMoveProfileExecute(Sender: TObject);
    procedure actRescanChangedExecute(Sender: TObject);
    procedure AppActivate(Sender: TObject);
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure AppShortcut(var Msg: TWMKey; var Handled: boolean);
    procedure actChangeLayoutExecute(Sender: TObject);
    procedure actLayoutManagerExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lbLayoutsClick(Sender: TObject);
    procedure actAddLayoutUpdate(Sender: TObject);
    procedure actRenameLayoutUpdate(Sender: TObject);
    procedure actChangeLayoutUpdate(Sender: TObject);
    procedure actDelLayoutUpdate(Sender: TObject);
    procedure inpLayoutNameKeyPress(Sender: TObject; var Key: Char);
    procedure actDelLayoutExecute(Sender: TObject);
    procedure actAddLayoutExecute(Sender: TObject);
    procedure lbLayoutsDblClick(Sender: TObject);
    procedure lbLayoutsKeyPress(Sender: TObject; var Key: Char);
    procedure actRenameLayoutExecute(Sender: TObject);
    procedure actHelpAboutExecute(Sender: TObject);
    procedure actHelpShortcutKeysExecute(Sender: TObject);
    procedure lvLayoutsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure actHelpContentsExecute(Sender: TObject);
    procedure CMDialogKey( Var msg: TCMDialogKey ); message CM_DIALOGKEY;
    procedure actHelpQuickStartExecute(Sender: TObject);
    procedure actShowHideSourcePreviewExecute(Sender: TObject);
    procedure actShowHideCallersExecute(Sender: TObject);
    procedure actShowHideCallersUpdate(Sender: TObject);
    procedure actShowHideCalleesExecute(Sender: TObject);
    procedure actShowHideCalleesUpdate(Sender: TObject);
    procedure actBrowsePreviousExecute(Sender: TObject);
    procedure actBrowseNextExecute(Sender: TObject);
    procedure actBrowseNextUpdate(Sender: TObject);
    procedure actBrowsePreviousUpdate(Sender: TObject);
    procedure actOpenCallGraphExecute(Sender: TObject);
    procedure actOpenCallGraphUpdate(Sender: TObject);
    procedure actJumpToCallGraphExecute(Sender: TObject);
    procedure actJumpToCallGraphUpdate(Sender: TObject);
    procedure splitCallersMoved(Sender: TObject);
    procedure clbUnitsKeyPress(Sender: TObject; var Key: Char);
    procedure clbClassesKeyPress(Sender: TObject; var Key: Char);
    procedure cbxSelectThreadUnitChange(Sender: TObject);
    procedure vstProcsNodeClick(Sender: TBaseVirtualTree;
      const HitInfo: THitInfo);
    procedure vstCalleesNodeClick(Sender: TBaseVirtualTree;
      const HitInfo: THitInfo);
    procedure vstCalleesNodeDblClick(Sender: TBaseVirtualTree;
      const HitInfo: THitInfo);
  private
    openProject               : TProject;
    openProfile               : TResults;
    currentProject            : string;               
    currentProfile            : string;
    cmdMsg                    : cardinal;
    cancelLoading             : boolean;
    loadCanceled              : boolean;
    storedPanel1Width         : integer;
    delphiProcessInfo         : TProcessInformation;
    delphiAppWindow           : HWND;
    delphiEditWindow          : HWND;
    delphiThreadID            : DWORD;
    loadedSource              : string;
    wasSourcePos              : boolean;
    undelProject              : string;
    activeLayout              : string;
    previewVisibleInstr       : boolean;
    previewVisibleAnalysis    : boolean;
    inLVResize                : boolean;
    selectedProc              : pointer;
    callersPerc               : real;
    calleesPerc               : real;
    fvstUnitsTools            : TSimpleStatsListTools;
    fvstClassesTools          : TSimpleStatsListTools;
    fvstProcsTools             : TSimpleStatsListTools;
    fvstProcsCallersTools     : TSimpleStatsListTools;
    fvstProcsCalleesTools     : TSimpleStatsListTools;

    fvstThreadsTools          : TSimpleStatsListTools;

    procedure ParseProject(const aProject: string; aJustRescan: boolean);
    procedure LoadProject(fileName: string; defaultDelphi: string = '');
    procedure NotifyParse(const aUnitName: string);
    procedure NotifyInstrument(const aFullName, aUnitName: string; aParse: Boolean);
    procedure FillUnitTree(projectDirOnly: boolean);
    procedure RecreateClasses(recheck: boolean);
    procedure RecheckTopClass;
    procedure RecreateProcs;
    procedure ClickProcs(index: integer; recreateCl: boolean);
    procedure DelphiVerClick(Sender: TObject);
    procedure LayoutClick(Sender: TObject);
    procedure BrowserClick(Sender: TObject);
    procedure RebuildDelphiVer;
    procedure DisablePC;
    procedure EnablePC;
    procedure DisablePC2;
    procedure EnablePC2;
    function  ParseProfile(profile: string): boolean;
    procedure LoadProfile(fileName: string);
    procedure SetCaption;
    procedure SetSource;
    function  ParseProfileCallback(percent: integer): boolean;
    procedure FillThreadCombos;
    procedure FillViews(resortOn: integer = -1);
    procedure FillProcView(resortOn: integer = -1);
    procedure FillClassView(resortOn: integer = -1);
    procedure FillUnitView(resortOn: integer = -1);
    procedure FillThreadView(resortOn: integer = -1);

    procedure EnumUserSettings(settings: TStrings);
    procedure FillDelphiVer;
    function  GetSearchPath(const aProject: string): string;
    function  GetOutputDir(const aProject: string): string;
    procedure FindMyDelphi;
    procedure CloseDelphiHandles;
    procedure LoadSource(fileName: AnsiString; focusOn: integer);
    procedure ClearSource;
    procedure ReloadSource;
    procedure ExportTo(fileName: string; exportProcs, exportClasses, exportUnits, exportThreads, exportCSV: boolean);
    procedure QueryExport;
    procedure StatusPanel0(msg: string; isSourcePos: boolean; beep: boolean = false);
    procedure ShowError(const Msg : string);
    function  ShowErrorYesNo(const Msg : string): integer;

    procedure SwitchDelMode(delete: boolean);
    procedure NoProfile;
    procedure DoOnUnitCheck(index: integer; instrument: boolean);
    procedure DoInstrument;
    procedure RescanProject;
    procedure LoadMetrics(layoutName: string);
    procedure SaveMetrics(layoutName: string);
    procedure RepositionLayout;
    procedure RebuildLayoutPopup(changeActive: boolean);
    function  IsLayout(layout: string): boolean;
    procedure SetChangeLayout(setRestore: boolean);
    function  CountLiveLayouts: integer;
    procedure ResetSourcePreview(reposition: boolean);
    procedure ResetCallers;
    procedure ResetCallees;
    procedure RedisplayCallers(resortOn: integer = -1);
    procedure RedisplayCallees(resortOn: integer = -1);
    procedure SelectProcs(pid: integer);
    procedure ClearBrowser(popBrowser: TPopupMenu);
    procedure PushBrowser(popBrowser: TPopupMenu; description: string; procID: integer);
    procedure PopBrowser(popBrowser: TPopupMenu; var description: string; var procID: integer);
    procedure ClearBreakdown;
    procedure Restack(fromPop, toPop: TPopupMenu; menuItem: TMenuItem);
    procedure RestackOne(fromPop, toPop: TPopupMenu);
    procedure LoadLayouts;
    procedure UseDelphiSettings(delphiVer: integer);
    function  GetPrefDelphiName: string;
    procedure RebuildDefines;
    procedure RepositionSliders;
    procedure SlidersMoved;
    function  IsProjectConsole: boolean;
    function  ReplaceMacros(s: string): string;
 public
    procedure ZoomOnProcedure(procedureID, threadID: integer);
    function  GetDOFSetting(section,key,defval: string): string;
 end;

var
  frmMain: TfrmMain;

implementation

uses
{$IFDEF DebugParser}
  uDbg,
  uDbgIntf,
{$ENDIF}
  BdsProjUnit,
  BdsVersions,
  IniFiles,
  gppmain.tree.types,
  GpString,
  GpProfH,
  GpIFF,
  GpRegistry,
  gppCommon,
  gpPreferencesDlg,
  gppLoadProgress,
  gppAbout,
  gppExport,
  gppCallGraph,
  gpPrfPlaceholders,
  UITypes,
  StrUtils,
  ioUtils;

{$R *.DFM}

{$I HELP.INC}

type
  PMap = ^TMap;
  TMap = record
    mapAppWindow : HWND;
    mapEditWindow: HWND;
  end;

function EnumMapThreadToWindows(window: HWND; lParam: PMap): boolean; stdcall;
var
  name: array [0..256] of char;
begin
  GetClassName(window,name,255);
  if name = 'TApplication' then lParam^.mapAppWindow := window
  else if name = 'TEditWindow' then lParam^.mapEditWindow := window;
  Result := true;
end; { EnumMapThreadToWindows }

procedure MapThreadToWindows(threadid: DWORD; var appWindow, editWindow: HWND);
var
  map: PMap;
begin
  New(map);
  try
    with map^ do begin
      mapAppWindow  := 0;
      mapEditWindow := 0;
      EnumThreadWindows(threadid,@EnumMapThreadToWindows,integer(map));
      appWindow  := mapAppWindow;
      editWindow := mapEditWindow;
    end;
  finally Dispose(map); end;
end; { MapThreadToWindow }

type
  PFind = ^TFind;
  TFind = record
    findTitle : shortstring;
    findProcID: DWORD;
  end;

function EnumFindMyDelphi(window: HWND; lParam: PFind): boolean; stdcall;
var
  name : array [0..256] of char;
  title: array [0..256] of char;
begin
  GetClassName(window,name,255);
  GetWindowText(window,title,255);
  if (name = 'TAppBuilder') and (Pos(lParam^.findTitle,UpperCase(title)) > 0) then begin
    lParam^.findProcID := GetWindowThreadProcessID(window,nil);
    Result := false;
  end
  else Result := true;
end; { EnumFindMyDelphi }

{========================= TfrmMain =========================}

procedure TfrmMain.CMDialogKey(var msg: TCMDialogKey);
var
  control: TWinControl;
begin
  with Msg do begin
    if (charcode = VK_TAB) and (GetKeyState(VK_CONTROL) < 0) then begin
      control:= ActiveControl;
      while Assigned(control) do begin
        if control is TPageControl then begin
          control.Perform(CM_DIALOGKEY, charcode, keydata);
          Exit;
        end
        else control := Control.Parent;
      end;
    end;
  end;
  inherited;
end; { TfrmMain.CMDialogKey }

procedure TfrmMain.FindMyDelphi;
var
  find: PFind;
begin
  delphiThreadID := 0;
  if ParamCount > 0 then begin
    New(find);
    try
      find^.findProcID := 0;
      find^.findTitle := ' - '+UpperCase(FirstEl(ExtractFileName(ParamStr(1)),'.',-1));
      EnumWindows(@EnumFindMyDelphi,integer(find));
      if find^.findProcID <> 0 then begin
        delphiThreadID := find^.findProcID;
        MapThreadToWindows(delphiThreadID,delphiAppWindow,delphiEditWindow);
      end;
    finally Dispose(find); end;
  end;
end; { TfrmMain.FindMyDelphi }


procedure TfrmMain.NotifyParse(const aUnitName: string);
begin
  StatusPanel0('Parsing ' + aUnitName, False);
  Application.ProcessMessages;
end; { TfrmMain.NotifyParse }

procedure TfrmMain.NotifyInstrument(const aFullName, aUnitName: string; aParse: Boolean);
begin
  if aParse then
    StatusPanel0('Parsing ' + aUnitName, False)
  else begin
    StatusPanel0('Instrumenting ' + aUnitName, False);
    if AnsiSameText(aFullName, LoadedSource) then
      LoadedSource := ''; // force preview window reload
  end;
  Application.ProcessMessages;
end; { TfrmMain.NotifyInstrument }

procedure TfrmMain.FillUnitTree(projectDirOnly: boolean);
var
  s    : TStringList;
  i    : integer;
  alli : boolean;
  nonei: boolean;
  allu : boolean;
  noneu: boolean;
begin                         
  s := TStringList.Create;
  try
    clbUnits.Perform(WM_SETREDRAW,0,0);
    try
      clbUnits.Items.BeginUpdate;
      clbUnits.Items.Clear;
      try
        if openProject <> nil then begin
          openProject.GetUnitList(s, projectDirOnly, true);
          s.Sorted := true;
          alli := true;
          nonei := true;
          clbUnits.Items.Add('<all units>');
          for i := 0 to s.Count-1 do
          begin
            // Two last chars in each element of the list, returned by GetUnitList, are the two flags,
            // ("0" and "1"): first indicates "All Instrumented", second - "None instrumented" state 
            clbUnits.Items.Add(ButLast(s[i], 2));
            allu  := (s[i][Length(s[i])-1] = '1');
            noneu := (s[i][Length(s[i])] = '1');
            if allu then
            begin
              clbUnits.State[i+1] := cbChecked;
              nonei := false;
            end
            else if noneu then
            begin
              clbUnits.State[i+1] := cbUnchecked;
              alli := false;
            end
            else begin
              clbUnits.State[i+1] := cbGrayed;
              alli := false;
              nonei:= false;
            end;
          end;
          if      nonei then clbUnits.State[0] := cbUnchecked
          else if alli  then clbUnits.State[0] := cbChecked
                        else clbUnits.State[0] := cbGrayed;
        end;
      finally
        clbUnits.Items.EndUpdate;
      end;
    finally
      clbUnits.Perform(WM_SETREDRAW, 1, 0);
    end;
  finally
    s.Destroy;
  end;
  clbUnits.ItemIndex := 0;
  clbUnitsClick(self);
end; { TfrmMain.FillUnitTree }

procedure TfrmMain.DisablePC;
begin
  PageControl1.Font.Color            := clBtnShadow;
  chkShowAll.Enabled                 := false;
  lblUnits.Enabled                   := false;
  lblClasses.Enabled                 := false;
  lblProcs.Enabled                   := false;
  clbUnits.Color                     := clBtnFace;
  clbUnits.Enabled                   := false;
  clbClasses.Color                   := clBtnFace;
  clbClasses.Enabled                 := false;
  clbProcs.Color                     := clBtnFace;
  clbProcs.Enabled                   := false;
  if PageControl1.ActivePage = tabInstrumentation then
    sourceCodeEdit.Color := clBtnFace;
end; { TfrmMain.DisablePC }

procedure TfrmMain.EnablePC;
begin
  PageControl1.Font.Color            := clWindowText;
  chkShowAll.Enabled                 := true;
  lblUnits.Enabled                   := true;
  lblClasses.Enabled                 := true;
  lblProcs.Enabled                   := true;
  clbUnits.Color                     := clWindow;
  clbUnits.Enabled                   := true;
  clbClasses.Color                   := clWindow;
  clbClasses.Enabled                 := true;
  clbProcs.Color                     := clWindow;
  clbProcs.Enabled                   := true;
  if PageControl1.ActivePage = tabInstrumentation then
    sourceCodeEdit.Color := SynPasSyn.SpaceAttri.Background;
  SetSource;
end; { TfrmMain.EnablePC }

procedure TfrmMain.ParseProject(const aProject: string; aJustRescan: boolean);
begin
  Enabled := False;
  try
    DisablePC;
    try
      if not aJustRescan then begin
        FreeAndNil(openProject);
        FillUnitTree(true); // clear all listboxes
        openProject := TProject.Create(aProject);
        CurrentProjectName := aProject;
        RebuildDefines;
        openProject.Parse(GetProjectPref('ExcludedUnits',prefExcludedUnits),
                          GetSearchPath(aProject),
                          frmPreferences.ExtractDefines, NotifyParse,
                          GetProjectPref('MarkerStyle', prefMarkerStyle),
                          GetProjectPref('InstrumentAssembler', prefInstrumentAssembler));
      end
      else begin
        RebuildDefines;
        openProject.Rescan(GetProjectPref('ExcludedUnits', prefExcludedUnits),
                           GetSearchPath(aProject),
                           frmPreferences.ExtractDefines,NotifyParse,
                           GetProjectPref('MarkerStyle', prefMarkerStyle),
                           GetProjectPref('UseFileDate', prefUseFileDate),
                           GetProjectPref('InstrumentAssembler', prefInstrumentAssembler));
      end;
      GetOutputDir(openProject.Name);
      StatusPanel0('Parsed', True);
    finally
      EnablePC;
    end;
  finally
    Enabled := true;
  end;
  
  actRescanProject.Enabled         := true;
  actRescanChanged.Enabled         := true;
  actInstrument.Enabled            := true;
  actInstrumentRun.Enabled         := true;
  actRemoveInstrumentation.Enabled := true;
  actRun.Enabled                   := true;
  actProjectOptions.Enabled        := true;
  FillUnitTree(not chkShowAll.Checked);
end; { TfrmMain.ParseProject }

function TfrmMain.GetPrefDelphiName: string;
begin
  Result := ButFirst(frmPreferences.cbxCompilerVersion.Items[prefCompilerVersion],Length('Delphi '));
end; { TfrmMain.GetPrefDelphiName }

function TfrmMain.IsProjectConsole: boolean;
begin
  Result := false;
  if assigned(openProject) then begin
    // Don't know why but ConsoleApp=1 means that app is NOT a console app!
    Result := not GetDOFSettingBool('Linker','ConsoleApp',true);
    // Also, CONSOLE is defined only if Linker option is set, not if
    // {$APPTYPE CONSOLE} is specified in main program!
    // Stupid, but that's how Delphi works.
  end;
end;

procedure TfrmMain.RebuildDefines;
begin
  with frmPreferences do begin
    ReselectCompilerVersion(selectedDelphi);
    cbStandardDefines.Checked    := GetProjectPref('StandardDefines',prefStandardDefines);
    cbConsoleDefines.Checked     := GetProjectPref('ConsoleDefines',IsProjectConsole);
    cbProjectDefines.Checked     := GetProjectPref('ProjectDefines',prefProjectDefines);
    cbDisableUserDefines.Checked := GetProjectPref('DisableUserDefines',prefDisableUserDefines);
    RebuildDefines(GetProjectPref('UserDefines',prefUserDefines));
  end;
end;

procedure TfrmMain.LoadProject(fileName: string; defaultDelphi: string = '');
begin
  if not FileExists(fileName) then
  begin
    StatusPanel0('File "'+fileName+'" does not exist!',false,true);
    raise Exception.Create('File "'+fileName+'" does not exist.');
  end
  else begin
    MRU.LatestFile := fileName;
    currentProject := ExtractFileName(fileName);
    ParseProject(fileName,false);
    if defaultDelphi = '' then
      defaultDelphi := GetPrefDelphiName;
    selectedDelphi := GetProjectPref('DelphiVersion',defaultDelphi);
    RebuildDelphiVer;
    chkShowAll.Checked := GetProjectPref('ShowAllFolders',prefShowAllFolders);
    PageControl1.ActivePage := tabInstrumentation;
    SetCaption;
    SetSource;
  end;
end; { TfrmMain.LoadProject }

procedure TfrmMain.RebuildDelphiVer;
var
  i    : integer;
  found: boolean;
begin
  found := false;
  with popDelphiVer do begin
    for i := 0 to Items.Count-2 do Items[i].Checked := false;
    if Items.Count >= 1 then 
      Items[Items.Count-1].Checked := true;
    for i := 0 to Items.Count-1 do begin
      if ButFirst(Items[i].Caption,Length('Delphi &')) = selectedDelphi then
      begin
        Items[Items.Count-1].Checked := false;
        Items[i].Checked := true;
        found := true;
        system.break;
      end;
    end;

    if (not found) and (Items.Count >= 1) then begin
      selectedDelphi := ButFirst(Items[Items.Count-1].Caption, Length('Delphi &'));
    end;
  end;
  tbtnRun.Hint := 'Run Delphi '+selectedDelphi;
  Run1.Caption := 'Run &Delphi '+selectedDelphi;
  Statusbar.Panels[1].Text := IFF(openProject = nil,'','Delphi '+selectedDelphi);
  if selectedDelphi <> '' then // <-- Added by Alisov A.
    UseDelphiSettings(Ord(selectedDelphi[1])-Ord(48));
end; { TfrmMain.RebuildDelphiVer }

procedure TfrmMain.DisablePC2;
begin
  tabAnalysis.Font.Color             := clBtnShadow;
  PageControl2.Font.Color            := clBtnShadow;
  cbxSelectThreadProc.Color          := clBtnFace;
  cbxSelectThreadClass.Color         := clBtnFace;
  cbxSelectThreadUnit.Color          := clBtnFace;
  if PageControl1.ActivePage = tabAnalysis then
    sourceCodeEdit.Color := clBtnFace;
end; { TfrmMain.DisablePC2 }

procedure TfrmMain.EnablePC2;
begin
  tabAnalysis.Font.Color             := clWindowText;
  PageControl2.Font.Color            := clWindowText;
  StatusPanel0('',false);
  if cbxSelectThreadProc.Items.Count > 2 then begin
    cbxSelectThreadProc.Color  := clWindow;
    cbxSelectThreadClass.Color := clWindow;
    cbxSelectThreadUnit.Color  := clWindow;
    if PageControl1.ActivePage = tabAnalysis then
      sourceCodeEdit.Color := SynPasSyn.SpaceAttri.Background;
    SetSource;
  end;
end;

procedure TfrmMain.EnumUserSettings(settings: TStrings);
var
  vTempSL: TStrings;
  i: Integer;
begin
  { returns the user settings that exist in the registry }
  with TRegistry.Create do  begin
  try

      // Enumerate Delphi 2009-XE3
      RootKey := HKEY_CURRENT_USER;
      if OpenKeyReadOnly('\SOFTWARE\Embarcadero\BDS') then
      begin
        try
          vTempSL := TStringList.Create;
          try
            GetKeyNames(vTempSL);
            for i := 0 to vTempSL.Count-1 do
            begin
              settings.Add(BdsVerToDephiVer(vTempSL[i]));
            end;
          finally
            vTempSL.Free;
          end;
        finally
          CloseKey;
        end;
      end;

      // Enumerate Delphi 2005-2007
      RootKey := HKEY_CURRENT_USER;
      if OpenKeyReadOnly('\SOFTWARE\Borland\BDS') then
      begin
        try
          vTempSL := TStringList.Create;
          try
            GetKeyNames(vTempSL);
            for i := 0 to vTempSL.Count-1 do
              if vTempSL[i] = '5.0' then
                settings.Add('2007')
              else if vTempSL[i] = '4.0' then
                settings.Add('2006')
              else if vTempSL[i] = '3.0' then
                settings.Add('2005')
              else
                settings.Add('Borland BDS ' + vTempSL[i]);
          finally
            vTempSL.Free;
          end;
        finally
          CloseKey;
        end;
      end;

      RootKey := HKEY_LOCAL_MACHINE;
      // Enumerate Delphi versions 2-5
      if OpenKeyReadOnly('\SOFTWARE\Borland\Delphi') then
      begin
        try
          vTempSL := TStringList.Create;
          try
            GetKeyNames(vTempSL);
            settings.AddStrings(vTempSL);
          finally
            vTempSL.Free;
          end;
        finally
          CloseKey;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

{ TfrmMain.EnablePC2 }

function TfrmMain.ParseProfileCallback(percent: integer): boolean;
begin
  frmLoadProgress.ProgressBar1.Position := percent;
  Application.ProcessMessages;
  Result := frmLoadProgress.Visible;
end; { TfrmMain.ParseProfileCallback }

procedure TfrmMain.FillThreadCombos;
var
  i: integer;
  LCaption : String;
begin
  with cbxSelectThreadProc do begin
    Items.BeginUpdate;
    try
      Items.Clear;
      if openProfile <> nil then begin
        Items.Add('All threads');
        with openProfile do begin
          for i := Low(resThreads)+1 to High(resThreads) do
          begin
            // first entries is handle 0 for unknown procs, skip it...
            LCaption := uintToStr(resThreads[i].teThread) + ' - ';
            if resThreads[i].teName = '' then
              LCaption := LCaption + 'Thread '+IntToStr(i)
            else
              LCaption := LCaption + resThreads[i].teName;
            Items.Add(LCaption)
          end;
        end;
      end;
      Enabled := (Items.Count > 2);
      ItemIndex := IFF(Enabled,0,1);
    finally Items.EndUpdate; end;
  end;
  cbxSelectThreadClass.Items.Assign(cbxSelectThreadProc.Items);
  cbxSelectThreadClass.Enabled   := cbxSelectThreadProc.Enabled;
  cbxSelectThreadClass.ItemIndex := cbxSelectThreadProc.ItemIndex;
  cbxSelectThreadUnit.Items.Assign(cbxSelectThreadProc.Items);
  cbxSelectThreadUnit.Enabled   := cbxSelectThreadProc.Enabled;
  cbxSelectThreadUnit.ItemIndex := cbxSelectThreadProc.ItemIndex;
  frmExport.expSelectThreadProc.Items.Assign(cbxSelectThreadProc.Items);
  frmExport.expSelectThreadProc.Items.Add('Summary');
  frmExport.expSelectThreadProc.Enabled := (frmExport.expSelectThreadProc.Items.Count > 3);
  frmExport.expSelectThreadProc.ItemIndex := cbxSelectThreadProc.ItemIndex;
  frmCallGraph.cbxSelectThreadCG.Items.Assign(cbxSelectThreadProc.Items);
  frmCallGraph.cbxSelectThreadCG.Enabled   := cbxSelectThreadProc.Enabled;
  frmCallGraph.cbxSelectThreadCG.ItemIndex := cbxSelectThreadProc.ItemIndex;
end; { TfrmMain.FillThreadCombos }

function TfrmMain.ParseProfile(profile: string): boolean;
begin
  Result := false;
  cancelLoading := false;
  Enabled := false;
  try
    DisablePC2;
    try
      FreeAndNil(openProfile);
      frmLoadProgress.Left := Left+((Width-frmLoadProgress.Width) div 2);
      frmLoadProgress.Top := Top+((Height-frmLoadProgress.Height) div 2);
      frmLoadProgress.Show;
      try
        StatusPanel0('Loading '+profile,false);
        openProfile := TResults.Create(profile,ParseProfileCallback);
        if openProfile = nil then begin
          NoProfile;
          actDelUndelProfile.Enabled := false;
          StatusPanel0('Load error',false,true);
        end
        else begin
          loadCanceled := not frmLoadProgress.Visible;
          if not loadCanceled then begin
            if not openProfile.IsDigest then begin
              StatusPanel0('Saving digest',false);
              openProfile.SaveDigest(profile);
            end;
          end;
          StatusPanel0('Loaded',true);
          Result := true;
        end;
      finally frmLoadProgress.Hide; end;
      if assigned(openProfile) then actProfileOptions.Enabled := true;
      Show;
      FillThreadCombos;
    finally if assigned(openProfile) then EnablePC2; end;
  finally Enabled := true; end;
end; { TfrmMain.ParseProfile }

procedure TfrmMain.FillProcView(resortOn: integer = -1);
var
  i        : integer;
  li       : TListItem;
begin
  fvstProcsTools.BeginUpdate;
  fvstProcsTools.Clear();
  fvstProcsTools.ThreadIndex := cbxSelectThreadClass.ItemIndex;
  fvstProcsTools.ProfileResults := openProfile;
  with openProfile do begin
    try
      if cbxSelectThreadProc.ItemIndex >= 0 then begin
        for i := Low(resProcedures)+1 to High(resProcedures) do begin
          with resProcedures[i] do begin
            if (not actHideNotExecuted.Checked) or (peProcCnt[cbxSelectThreadProc.ItemIndex] > 0) then begin
              fvstProcsTools.AddEntry(i);
            end;
          end;
        end;
      end;
    finally
      fvstProcsTools.EndUpdate;
    end;
  end;
end; { TfrmMain.FillProcView }

procedure TfrmMain.FillClassView(resortOn: integer = -1);
var
  i        : integer;
  li       : TListItem;
begin
  fvstClassesTools.BeginUpdate;
  fvstClassesTools.Clear();
  fvstClassesTools.ThreadIndex := cbxSelectThreadClass.ItemIndex;
  fvstClassesTools.ProfileResults := openProfile;
  with openProfile do begin
    try
      if cbxSelectThreadClass.ItemIndex >= 0 then begin
        for i := Low(resClasses)+1 to High(resClasses) do begin
          with resClasses[i] do begin
            if (not actHideNotExecuted.Checked) or (ceTotalCnt[cbxSelectThreadClass.ItemIndex] > 0) then
            begin
              fvstClassesTools.AddEntry(i);
            end;
          end;
        end;
      end;
    finally
      fvstClassesTools.EndUpdate;
    end;
  end;
end; { TfrmMain.FillClassView }



procedure TfrmMain.FillUnitView(resortOn: integer = -1);
var
  i        : integer;
  li       : TListItem;
begin
  fvstUnitsTools.BeginUpdate;
  fvstUnitsTools.Clear();
  fvstUnitsTools.ThreadIndex := cbxSelectThreadUnit.ItemIndex;
  fvstUnitsTools.ProfileResults := openProfile;
  with openProfile do begin
    try
      if cbxSelectThreadUnit.ItemIndex >= 0 then begin
        for i := Low(resUnits)+1 to High(resUnits) do begin
          with resUnits[i] do begin
            if (not actHideNotExecuted.Checked) or (ueTotalCnt[cbxSelectThreadUnit.ItemIndex] > 0) then begin
              fvstUnitsTools.AddEntry(i);
            end;
          end;
        end;
      end;
    finally
      fvstUnitsTools.EndUpdate;
    end;
  end;
end; { TfrmMain.FillUnitView }


procedure TfrmMain.FillThreadView(resortOn: integer = -1);
var
  i        : integer;
  li       : TListItem;
begin
  fvstThreadsTools.BeginUpdate;
  fvstThreadsTools.Clear();
  fvstThreadsTools.ThreadIndex := 0; // not needed

  fvstThreadsTools.ProfileResults := openProfile;
  with openProfile do begin
    try
      if openProfile <> nil then begin
        for i := Low(resThreads)+1 to High(resThreads) do begin
          with resThreads[i] do begin
            if (not actHideNotExecuted.Checked) or (teTotalCnt > 0) then begin
              fvstThreadsTools.AddEntry(i);
            end;
          end;
        end;
      end;
    finally
      fvstThreadsTools.EndUpdate;
    end;
  end;
end; { TfrmMain.FillThreadView }

procedure TfrmMain.FillViews(resortOn: integer = -1);
begin
  FillProcView(resortOn);
  FillClassView(resortOn);
  FillUnitView(resortOn);
  FillThreadView(resortOn);
end; { TfrmMain.FillViews }

procedure TfrmMain.LoadProfile(fileName: string);
begin 
  if not FileExists(fileName) then StatusPanel0('File '+fileName+' does not exist!',false,true)
  else begin
    MRUPrf.LatestFile := fileName;
    currentProfile := ExtractFileName(fileName);
    PageControl1.ActivePage := tabAnalysis;
    ClearSource;
    selectedProc := nil;
    if ParseProfile(fileName) then begin
      SetCaption;
      SetSource;
      actHideNotExecuted.Checked := GetProfilePref('HideNotExecuted', prefHideNotExecuted);
      FillViews(1);
      ClearBreakdown;
      actHideNotExecuted.Enabled   := true;
      actJumpToCallGraph.Enabled   := true;
      actRescanProfile.Enabled     := true;
      actExportProfile.Enabled     := true;
      mnuExportProfile.Enabled     := true;
      actRenameMoveProfile.Enabled := true;
      actMakeCopyProfile.Enabled   := true;
      actDelUndelProfile.Enabled   := true;
      SwitchDelMode(true);
      if openProfile.DigestVer > 2 then frmCallGraph.ReloadProfile(openProfile.Name,openProfile)
      else begin
        frmCallGraph.ClearProfile;
        frmCallGraph.Hide;
      end;
    end;
  end;
end; { TfrmMain.LoadProfile }

procedure TfrmMain.WMReLoadProfile(var msg: TMessage);
var
  outDir: string;
  vFName: String;
begin
  if assigned(openProject) then begin
    outDir := GetOutputDir(openProject.Name);
    vFName := MakeSmartBackslash(outDir)+ChangeFileExt(ExtractFileName(openProject.Name),'.prf');
    if not FileExists(vFName) then
    begin
      if MessageDlg('Profiling file not found: ' + vFName + #13#10 +
        'Choose file location manually?',
        mtWarning, [mbYes, mbCancel], -1) = mrYes then
        if OpenDialog1.Execute then
          vFName := OpenDialog1.FileName;
    end;

    LoadProfile(vFName);
  end;
end; { TfrmMain.WMReLoadProfile }


procedure TfrmMain.DelphiVerClick(Sender: TObject);
begin
  selectedDelphi := ButFirst(TMenuItem(Sender).Caption,Length('Delphi &'));
  RebuildDelphiVer;
  SetProjectPref('DelphiVersion',selectedDelphi);
end;

procedure TfrmMain.LayoutClick(Sender: TObject);
begin
  SaveMetrics(activeLayout);
  inpLayoutName.Text := TMenuItem(Sender).Caption;
  RebuildLayoutPopup(true);
  inpLayoutName.Text := lvLayouts.Selected.Caption;
  LoadMetrics(inpLayoutName.Text);
end;

procedure TfrmMain.FillDelphiVer;
var
  s : TStringList;
  mn: TMenuItem;
  i : integer;
begin
  s := TStringList.Create;
  try
    EnumUserSettings(s);
    for i := 0 to s.Count-1 do begin
      mn := TMenuItem.Create(self);
      mn.Caption := 'Delphi &'+s[i];
      mn.OnClick := DelphiVerClick;
      popDelphiVer.Items.Insert(popDelphiVer.Items.Count,mn);
      frmPreferences.cbxCompilerVersion.Items.Add('Delphi '+s[i]);
      frmPreferences.cbxDelphiDefines.Items.Add('Delphi '+s[i]);
    end;
    if s.Count = 0 then
      actRun.OnExecute := nil;
    if s.Count <= 1 then
    begin
      tBtnRun.Style := tbsButton;
      tBtnRun.Width := 23;
      tBtnRun.DropdownMenu := nil;
      tbrProject.Perform(CM_RECREATEWND, 0, 0);
    end;
    if s.Count >= 1 then
    begin
      if (prefCompilerVersion < 0) or (prefCompilerVersion >= s.Count) then
        prefCompilerVersion := s.Count-1;
      selectedDelphi := GetProjectPref('DelphiVersion', s[prefCompilerVersion]);
      RebuildDelphiVer;
    end;
  finally
    s.Free;
  end;
end; { TfrmMain.FillDelphiVer }

function TfrmMain.CountLiveLayouts: integer;
var
  i: integer;
begin
  Result := 0;
  with lvLayouts do
    for i := 0 to Items.Count-1 do
      if Items[i].ImageIndex <> 1 then Result := Result + 1;
end; { TfrmMain.CountLiveLayouts }

procedure TfrmMain.RebuildLayoutPopup(changeActive: boolean);
var
  mn      : TMenuItem;
  i       : integer;
  found   : boolean;
  ucLayout: string;
  lastName: string;
begin
  while popLayout.Items.Count > 0 do popLayout.Items.Remove(popLayout.Items[0]);
  if changeActive then begin
    with lvLayouts do for i := 0 to Items.Count-1 do
      with Items[i] do if ImageIndex = 2 then ImageIndex := 0;
    ucLayout := UpperCase(inpLayoutName.Text);
    found := false;
    lastName := '';
    for i := 0 to lvLayouts.Items.Count-1 do begin
      if lvLayouts.Items[i].ImageIndex <> 1 then begin
        if UpperCase(lvLayouts.Items[i].Caption) = ucLayout then begin
          found := true;
          break;
        end
        else lastName := lvLayouts.Items[i].Caption;
      end;
    end;
    if not found then inpLayoutName.Text := lastName;
  end;
  for i := 0 to lvLayouts.Items.Count-1 do begin
    if lvLayouts.Items[i].ImageIndex <> 1 then begin
      mn := TMenuItem.Create(self);
      mn.Caption := lvLayouts.Items[i].Caption;
      mn.OnClick := LayoutClick;
      if changeActive
        then mn.Checked := UpperCase(lvLayouts.Items[i].Caption) = ucLayout
        else mn.Checked := lvLayouts.Items[i].ImageIndex = 2;
      if mn.Checked then begin
        lvLayouts.Selected := lvLayouts.Items[i];
        lvLayouts.Selected.ImageIndex := 2;
      end;
      popLayout.Items.Insert(popLayout.Items.Count,mn);
    end;
  end;
  if inpLayoutName.Text = ''
    then BtnLayoutManager.Hint := actLayoutManager.Hint
    else BtnLayoutManager.Hint := actLayoutManager.Hint + ' (' + inpLayoutName.Text + ')';
  if CountLiveLayouts <= 1 then begin
    BtnLayoutManager.Style := tbsButton;
    BtnLayoutManager.Width := 23;
    BtnLayoutManager.DropdownMenu := nil;
    BtnLayoutManager.Perform(CM_RECREATEWND, 0, 0);
  end
  else begin
    BtnLayoutManager.Style := tbsDropDown;
    BtnLayoutManager.Width := 36;
    BtnLayoutManager.DropdownMenu := popLayout;
    BtnLayoutManager.Perform(CM_RECREATEWND, 0, 0);
  end;
end; { TfrmMain.RebuildLayoutPopup }

function TfrmMain.IsLayout(layout: string): boolean;
var
  i: integer;
begin
  IsLayout := true;
  layout := UpperCase(layout);
  for i := 0 to lvLayouts.Items.Count-1 do
    if UpperCase(lvLayouts.Items[i].Caption) = layout then Exit;
  IsLayout := false;
end; { TfrmMain.IsLayout }

procedure TfrmMain.LoadLayouts;
var
  layout: string;
  vSL   : TStringList;
  i     : integer;
begin
  with TGpRegistry.Create do begin
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKey(cRegistryUI,true) then
      begin
        vSL := TStringList.Create;
        try
          GetKeyNames(vSL);
          for i := 0 to vSL.Count-1 do
            with lvLayouts.Items.Add do Caption := vSL[i];
        finally
          vSL.Free;
        end;

        if lvLayouts.Items.Count = 0 then
          with lvLayouts.Items.Add do
            Caption := cDefLayout;

        layout := TGpRegistryTools.GetPref(cRegistryUIsub, 'Layout', cDefLayout);
        if IsLayout(layout) then
          inpLayoutName.Text := layout
        else
          inpLayoutName.Text := lvLayouts.Items[0].Caption;
      end;
      RebuildLayoutPopup(true);
    finally
      Free;
    end;
  end;
end; { TfrmMain.LoadLayouts }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF DebugParser}
  NxStartDebug;
{$ENDIF}
{$IFDEF DebugPanels}
  pnlCallers.Color := clGreen;
  pnlCurrent.Color := clOlive;
  pnlCallees.Color := clBlue;
  pnlTopTwo.Color  := clPurple;
  pnlBottom.Color  := clYellow;
  splitCallers.Color := clLime;
  splitCallees.Color := clRed; 
{$ENDIF}
  inLVResize := false;
  selectedProc := nil;
  Application.OnActivate := AppActivate;
  Application.OnMessage  := AppMessage;
  Application.OnShortCut := AppShortcut;
  Application.HelpFile := ChangeFileExt(ParamStr(0),'.Chm');
  if not FileExists(Application.HelpFile) then Application.HelpFile := '';
  LoadLayouts;
  StatusBar.Font.Size := 10;
  wasSourcePos := false;
  ClearSource;
  FindMyDelphi;
  with delphiProcessInfo do begin
    hProcess := 0;
    hThread  := 0;
  end;
  LoadPreferences;
  PageControl1.ActivePage := tabInstrumentation;
  PageControl2.ActivePage := tabProcedures;
  DisablePC2;
  DisablePC;
  loadCanceled := false;
  cmdMsg := RegisterWindowMessage(CMD_MESSAGE);
  openProject := nil;
  openProfile := nil;
  CurrentProjectName := '';

  MRU.RegistryKey := cRegistryRoot+'\MRU\DPR';
  MRU.LoadFromRegistry;
  MRUPrf.RegistryKey := cRegistryRoot+'\MRU\PRF';
  MRUPrf.LoadFromRegistry;
  undelProject := '';
  SlidersMoved;
  fvstUnitsTools   := TSimpleStatsListTools.Create(vstUnits,TProfilingInfoTypeEnum.pit_unit);
  fvstClassesTools := TSimpleStatsListTools.Create(vstClasses,TProfilingInfoTypeEnum.pit_class);
  fvstProcsTools   := TSimpleStatsListTools.Create(vstProcs,TProfilingInfoTypeEnum.pit_proc);
  fvstProcsCallersTools := TSimpleStatsListTools.Create(vstCallers,TProfilingInfoTypeEnum.pit_proc_callers);
  fvstProcsCalleesTools := TSimpleStatsListTools.Create(vstCallees,TProfilingInfoTypeEnum.pit_proc_callees);

  fvstThreadsTools := TSimpleStatsListTools.Create(vstThreads,TProfilingInfoTypeEnum.pit_thread);
end;

procedure TfrmMain.MRUClick(Sender: TObject; LatestFile: String);
begin
  if (openProject = nil) or (openProject.Name <> LatestFile) then begin
    CloseDelphiHandles;
    LoadProject(LatestFile);
  end;
end;

procedure TfrmMain.SaveMetrics(layoutName: string);

  procedure PutHeader(reg: TGpRegistry; aVST: TVirtualStringTree; prefix: string);
  var
    i: integer;
  begin
    for i := 0 to aVST.Header.Columns.Count-1 do
      reg.WriteInteger(prefix+'Column'+IntToStr(i)+'Width',aVST.Header.Columns[i].Width);
  end; { PutColumns }


  procedure PutColumns(reg: TGpRegistry; lv: TGpArrowListView; prefix: string);
  var
    i: integer;
  begin
    with lv do begin
      for i := 0 to Columns.Count-1 do begin
        reg.WriteInteger(prefix+'Column'+IntToStr(i)+'Width',Column[i].Width);
      end;
    end;
  end; { PutColumns }

var
  reg: TGpRegistry;
  wp : TWindowPlacement;
begin
  reg := TGpRegistry.Create;
  try
    with reg do begin
      RootKey := HKEY_CURRENT_USER;
      OpenKey(cRegistryUI,true);
      WriteString('UIVer', cUIVersion);
      OpenKey(layoutName,true);
      WriteInteger('WindowState',Ord(WindowState));
      wp.Length := SizeOf(TWindowPlacement);
      if GetWindowPlacement(frmMain.Handle,@wp) then begin
        WriteInteger('FormLeft',wp.rcNormalPosition.Left);
        WriteInteger('FormTop',wp.rcNormalPosition.Top);
        WriteInteger('FormRight',wp.rcNormalPosition.Right);
        WriteInteger('FormBottom',wp.rcNormalPosition.Bottom);
      end;
      WriteInteger('pnlUnitsWidth',pnlUnits.Width);
      WriteInteger('pnlClassesWidth',pnlClasses.Width);
      WriteInteger('Panel2Height',pnlSourcePreview.Height);
      WriteBool('previewVisibleInstr',previewVisibleInstr);
      WriteBool('previewVisibleAnalysis',previewVisibleAnalysis);
      WriteInteger('pnlCallersHeight',pnlCallers.Height);
      WriteInteger('pnlCalleesHeight',pnlCallees.Height);
      WriteBool('pnlCallersVisible',pnlCallers.Visible);
      WriteBool('pnlCalleesVisible',pnlCallees.Visible);
      PutHeader(reg,vstProcs,'lvProcs');
      PutHeader(reg,vstClasses,'lvClasses');
      PutHeader(reg,vstUnits,'lvUnits');
      PutHeader(reg,vstThreads,'lvThreads');
      PutHeader(reg,vstCallers,'lvCallers');
      PutHeader(reg,vstCallees,'lvCallees');
    end;
  finally reg.Free; end;
end; { TfrmMain.SaveMetrics }

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  with TGpRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      for i := 0 to lvLayouts.Items.Count-1 do
        if lvLayouts.Items[i].ImageIndex = 1 then
          DeleteKey(cRegistryUI + '\' + lvLayouts.Items[i].Caption);
    finally
      Free;
    end;

  SwitchDelMode(true); // process pending delete
  CloseDelphiHandles;
  if activeLayout <> '' then begin
    SaveMetrics(activeLayout);
    TGpRegistryTools.SetPref(cRegistryUIsub,'Layout',activeLayout)
  end;
  MRU.SaveToRegistry;
  MRUPrf.SaveToRegistry;
  FreeAndNil(openProject);
  FreeAndNil(openProfile);
  FreeAndNil(fvstUnitsTools);
  FreeAndNil(fvstClassesTools);
  FreeAndNil(fvstProcsTools);
  FreeAndNil(fvstProcsCallersTools);
  FreeAndNil(fvstProcsCalleesTools);
  FreeAndNil(fvstThreadsTools);
end;


procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.actPreferencesExecute(Sender: TObject);
var
  oldProject: TProject;
begin
  oldProject := openProject;
  openProject := nil;
  try
    with frmPreferences do begin
      if ExecuteGlobalSettings then
        RebuildDelphiVer;
    end;
  finally openProject := oldProject; end;
end;

procedure TfrmMain.cbProfileChange(Sender: TObject);
begin
  FillUnitTree(not chkShowAll.Checked);
  SetProjectPref('ShowAllFolders',chkShowAll.Checked);
end;

procedure TfrmMain.clbUnitsClick(Sender: TObject);
begin
  clbProcs.Items.BeginUpdate;
  try
    clbProcs.Items.Clear;
    clbClasses.Items.BeginUpdate;
    try
      clbClasses.Items.Clear;
      if clbUnits.ItemIndex > 0 then begin
        RecreateClasses(false);
        clbClasses.ItemIndex := 0;
        clbClassesClick(self);
        StatusPanel0(openProject.GetUnitPath(clbUnits.Items[clbUnits.ItemIndex]),false);
      end
      else if openProject <> nil then StatusBar.Panels[0].Text := openProject.Name;
      ClearSource;
    finally clbClasses.Items.EndUpdate; end;
  finally clbProcs.Items.EndUpdate; end;
end;

procedure TfrmMain.DoOnUnitCheck(index: integer; instrument: boolean);
var
  i: integer;
begin
  if index = 0 then begin
    clbUnits.Items.BeginUpdate;
    try
      for i := 1 to clbUnits.Items.Count-1 do clbUnits.State[i] := clbUnits.State[0];
    finally clbUnits.Items.EndUpdate; end;
    openProject.InstrumentAll(clbUnits.Checked[0],not chkShowAll.Checked);
  end
  else begin
    if instrument then openProject.InstrumentUnit(clbUnits.Items[index],clbUnits.Checked[index]);
    if openProject.AllInstrumented(not chkShowAll.Checked) then clbUnits.State[0] := cbChecked
    else if openProject.NoneInstrumented(not chkShowAll.Checked) then clbUnits.State[0] := cbUnchecked
    else clbUnits.State[0] := cbGrayed;
  end;
end; { TfrmMain.DoOnUnitCheck }

procedure TfrmMain.clbUnitsClickCheck(Sender: TObject; index: Integer);
begin
  if clbUnits.Items.Count = 1 then clbUnits.State[index] := cbUnchecked
  else begin
    if clbUnits.State[index] = cbGrayed then clbUnits.State[index] := cbChecked;
    DoOnUnitCheck(index,true);
  end;
end;

procedure TfrmMain.clbUnitsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #32 then
    clbUnitsClick(Sender);
  inherited;
end;

procedure TfrmMain.clbProcsClickCheck(Sender: TObject; index: Integer);
begin
  ClickProcs(index,true);
end;

procedure TfrmMain.DoInstrument;
var
  fnm   : string;
  outDir: string;
begin
  outDir := GetOutputDir(openProject.Name);
  fnm := MakeSmartBackslash(outDir)+ChangeFileExt(ExtractFileName(openProject.Name),'.gpi');
  openProject.Instrument(not chkShowAll.Checked,NotifyInstrument,
                         GetProjectPref('MarkerStyle',prefMarkerStyle),
                         GetProjectPref('KeepFileDate',prefKeepFileDate),
                         GetProjectPref('MakeBackupOfInstrumentedFile',prefKeepFileDate),
                         fnm,frmPreferences.ExtractDefines,
                         GetSearchPath(openProject.Name),
                         GetProjectPref('InstrumentAssembler',prefInstrumentAssembler));

  if FileExists(fnm) then
    with TIniFile.Create(fnm) do
      try
        WriteBool('Performance','ProfilingAutostart',GetProjectPref('ProfilingAutostart',prefProfilingAutostart));
        WriteBool('Performance','CompressTicks',GetProjectPref('SpeedSize',prefSpeedSize)>1);
        WriteBool('Performance','CompressThreads',GetProjectPref('SpeedSize',prefSpeedSize)>2);
        WriteString('Output','PrfOutputFilename',ResolvePrfProjectPlaceholders(prefPrfFilenameMakro));
      finally
        Free;
      end;

  ReloadSource;
  StatusPanel0('Instrumentation finished',false);
end; { TfrmMain.DoInstrument }

procedure TfrmMain.actInstrumentExecute(Sender: TObject);
begin
  actRescanChanged.Execute;
  DoInstrument;
end;

procedure TfrmMain.actOpenExecute(Sender: TObject);
var
  vFN: TFileName;
begin
  with OpenDialog do begin
    DefaultExt := 'dpr';
    if openProfile = nil then
      FileName := ''
    else
      FileName := ChangeFileExt(openProfile.Name,'.dpr');
    Filter := 'Delphi project (*.dpr)|*.dpr|Delphi package (*.dpk)|*.dpk|Any file (*.*)|*.*';
    if Execute then begin
      vFN := FileName;
      if AnsiUpperCase(ExtractFileExt(FileName)) = '.DPROJ' then
        vFN := ChangeFileExt(vFN, '.DPR');
      CloseDelphiHandles;
      LoadProject(vFN);
    end;
  end;
end;

procedure TfrmMain.actRescanProjectExecute(Sender: TObject);
begin
  LoadProject(openProject.Name);
end;

procedure TfrmMain.RecheckTopClass;
var
  all : boolean;
  none: boolean;
  i   : integer;
begin
  all  := true;
  none := true;
  with clbClasses do begin
    for i := 1 to Items.Count-1 do begin
      if (State[i] = cbChecked)   or (State[i] = cbGrayed) then none := false;
      if (State[i] = cbUnchecked) or (State[i] = cbGrayed) then all  := false;
    end;
    if      all  then State[0] := cbChecked
    else if none then State[0] := cbUnchecked
                 else State[0] := cbGrayed;
    clbUnits.State[clbUnits.ItemIndex] := State[0];
    DoOnUnitCheck(clbUnits.ItemIndex,false);
  end;
end; { TfrmMain.RecheckTopClass }

procedure TfrmMain.RecreateClasses(recheck: boolean);
type
  PAN = ^TAN;
  TAN = record
    anName: string;
    anAll : boolean;
    anNone: boolean;
  end;
var
  uc: TStringList;
  s : string;
  i : integer;
  j : integer;
  p : integer;
  q : integer;
  an: PAN;
  cl: TAN;
  un: TStringList;
begin
  un := TStringList.Create;
  try
    openProject.GetProcList(clbUnits.Items[clbUnits.ItemIndex],un,true);
    uc := TStringList.Create;
    try
      cl.anAll  := true;
      cl.anNone := true;
      for i := 0 to un.Count-1 do begin
        s := ButLast(un[i],1);
        p := Pos('.',s);
        if p > 0 then begin
          s := Copy(s,1,p-1);
          q := uc.IndexOf(UpperCase(s));
          if q = -1 then begin
            New(an);
            an.anName := s;
            an.anAll  := true;
            an.anNone := true;
            q := uc.Add(UpperCase(s));
            uc.Objects[q] := TObject(an);
          end;
          an := PAN(uc.Objects[q]);
        end
        else an := @cl;
        if Last(un[i],1) = '1' then an.anNone := false
                               else an.anAll  := false;
      end;
      with clbClasses do begin
        Items.BeginUpdate;
        try
          clbClasses.Perform(WM_SETREDRAW,0,0);
          try
            if not recheck then begin
              Clear;
              Sorted := true;
            end;
            for i := 0 to uc.Count-1 do
              with PAN(uc.Objects[i])^ do begin
                if not recheck then p := Items.Add(anName)
                else begin
                  p := -1;
                  s := UpperCase(anName);
                  for j := 0 to Items.Count-1 do begin
                    if UpperCase(Items[j]) = s then begin
                      p := j;
                      break;
                    end;
                  end;
                end;
                if p >= 0 then begin
                  if      anAll  then State[p] := cbChecked
                  else if anNone then State[p] := cbUnchecked
                  else begin Checked[p] := true; State[p] := cbGrayed; end;
                end;
              end;
            if not recheck then Sorted := false;
            if not (cl.anAll and cl.anNone) then begin
              if recheck then p := 1
              else begin
                Items.Insert(0,'<classless procedures>');
                p := 0;
              end;
              if      cl.anAll  then State[p] := cbChecked
              else if cl.anNone then State[p] := cbUnchecked
                                else State[p] := cbGrayed;
            end;
            if not recheck then Items.Insert(0,'<all classes>');
          finally clbClasses.Perform(WM_SETREDRAW,1,0); end;
          RecheckTopClass;
        finally clbClasses.Items.EndUpdate; end;
      end; // with
    finally
      for i := 0 to uc.Count-1 do
        Dispose(PAN(uc.Objects[i]));
      uc.Free;
    end;
  finally un.Free; end;
end;

procedure TfrmMain.RecreateProcs;
var
  s    : TStringList;
  t    : string;
  p    : integer;
  i    : integer;
  alli : boolean;
  nonei: boolean;
  ii   : integer;
  uc   : string;
  cc   : string;
begin
  s := TStringList.Create;
  try
    openProject.GetProcList(clbUnits.Items[clbUnits.ItemIndex],s,true);
    s.Sorted := true;
    clbProcs.Perform(WM_SETREDRAW,0,0);
    try
      clbProcs.Items.BeginUpdate;
      clbProcs.Items.Clear;
      try
        alli  := true;
        nonei := true;
        ii    := clbClasses.ItemIndex;
        cc    := clbClasses.Items[clbClasses.ItemIndex];
        uc    := UpperCase(cc);
        for i := 0 to s.Count-1 do begin
          t := ButLast(s[i],1);
          if t <> '' then begin
            p := Pos('.',t);
            if (ii = 0) or ((cc[1] = '<') and (p = 0)) or
               ((cc[1] <> '<') and (UpperCase(First(t,p-1)) = uc)) then begin
              if (cc[1] <> '<') and (p > 0) then clbProcs.Items.Add(ButFirst(t,p))
                                            else clbProcs.Items.Add(t);
              clbProcs.Checked[clbProcs.Items.Count-1] := (Last(s[i],1) = '1');
              if not clbProcs.Checked[clbProcs.Items.Count-1] then alli  := false
                                                              else nonei := false;
            end;
          end;
        end;
        if clbProcs.Items.Count > 0 then begin
          if ii = 0 then clbProcs.Items.Insert(0,'<all procedures>')
          else if cc[1] = '<' then clbProcs.Items.Insert(0,'<all classless procedures>')
          else clbProcs.Items.Insert(0,'<all '+cc+' methods>');
          if      alli  then clbProcs.State[0] := cbChecked
          else if nonei then clbProcs.State[0] := cbUnchecked
                        else clbProcs.State[0] := cbGrayed;
        end;
      finally clbProcs.Items.EndUpdate; end;
    finally clbProcs.Perform(WM_SETREDRAW,1,0); end;
  finally s.Destroy; end;
end; { TfrmMain.RecreateProcs }

procedure TfrmMain.clbClassesClick(Sender: TObject);
begin
  RecreateProcs;
  ReloadSource;
end;

procedure TfrmMain.clbClassesClickCheck(Sender: TObject; index: Integer);
var
  un: TStringList;
  cl: string;
  i : integer;
  p : integer;
begin
  if clbClasses.State[index] = cbGrayed then clbClasses.State[index] := cbChecked;
  if clbClasses.ItemIndex = 0 then begin
    clbUnits.State[clbUnits.ItemIndex] := clbClasses.State[index];
    clbUnitsClickCheck(Sender,clbUnits.ItemIndex);
    RecreateClasses(true);
  end
  else begin
    un := TStringList.Create;
    try
      openProject.GetProcList(clbUnits.Items[clbUnits.ItemIndex],un,false); 
      cl := UpperCase(clbClasses.Items[clbClasses.ItemIndex]);
      for i := 0 to un.Count-1 do begin
        p := Pos('.',un[i]);
        if ((cl[1] = '<') and (p = 0)) or
           ((cl[1] <> '<') and (UpperCase(Copy(un[i],1,p-1)) = cl)) then begin
          openProject.InstrumentProc(clbUnits.Items[clbUnits.ItemIndex],un[i],clbClasses.Checked[index]); 
        end;
      end;
    finally un.Free; end;
    RecheckTopClass;
  end;
end;

procedure TfrmMain.clbClassesKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #32 then
    clbClassesClick(Sender);
  inherited;
end;

procedure TfrmMain.ClickProcs(index: integer; recreateCl: boolean);
var
  i : integer;
  un: TUnit;
  s : string;
begin
  if clbProcs.State[index] = cbGrayed then clbProcs.State[index] := cbChecked;
  if index = 0 then begin
    clbProcs.Items.BeginUpdate;
    try
      for i := 1 to clbProcs.Items.Count-1 do begin
        if clbClasses.Items[clbClasses.ItemIndex][1] = '<'
          then s := clbProcs.Items[i]
          else s := clbClasses.Items[clbClasses.ItemIndex]+'.'+clbProcs.Items[i];
        clbProcs.Checked[i] := clbProcs.Checked[0];
        openProject.InstrumentProc(clbUnits.Items[clbUnits.ItemIndex],s,clbProcs.Checked[i]); 
      end;
    finally clbProcs.Items.EndUpdate; end;
  end
  else begin
    if clbClasses.Items[clbClasses.ItemIndex][1] = '<'
      then s := clbProcs.Items[index]
      else s := clbClasses.Items[clbClasses.ItemIndex]+'.'+clbProcs.Items[index];
    openProject.InstrumentProc(clbUnits.Items[clbUnits.ItemIndex],s,clbProcs.Checked[index]); 
    un := openProject.prUnits.Locate(clbUnits.Items[clbUnits.ItemIndex]);
    if      un.unAllInst  then clbProcs.State[0] := cbChecked
    else if un.unNoneInst then clbProcs.State[0] := cbUnchecked
    else begin
      clbProcs.Checked[0] := true;
      clbProcs.State[0] := cbGrayed;
    end;
  end;
  if recreateCl then RecreateClasses(true);
end;

procedure TfrmMain.actRemoveInstrumentationExecute(Sender: TObject);
var
  chk: boolean;
begin
  actRescanChanged.Execute;
  clbUnits.Items.BeginUpdate;
  try
    chk := chkShowAll.Checked;
    chkShowAll.Checked := true;
    clbUnits.State[0] := cbUnchecked;
    clbUnitsClickCheck(Sender,0);
    clbUnitsClick(Sender);
    DoInstrument;
    chkShowAll.Checked := chk;
  finally clbUnits.Items.EndUpdate; end;
end;

procedure TfrmMain.actRunExecute(Sender: TObject);
var
  run        : string;
  startupInfo: TStartupInfo;
begin
  with TGpRegistry.Create do
    try
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly('\SOFTWARE\Borland\Delphi\' + selectedDelphi) then
        run := ReadString('Delphi ' + FirstEl(selectedDelphi,'.',-1),'')
      else begin
        RootKey := HKEY_CURRENT_USER;
        if OpenKeyReadOnly('\SOFTWARE\Borland\BDS\' + DelphiVerToBDSVer(selectedDelphi)) then
          run := ReadString('App', '')
        else if OpenKeyReadOnly('\SOFTWARE\Embarcadero\BDS\' + DelphiVerToBDSVer(selectedDelphi)) then
          run := ReadString('App', '')
        else
          run := '';
      end;
    finally
      Free;
    end;

  if run = '' then
    raise Exception.Create('Can''t determine Delphi executable file location from registry.');

  if delphiThreadID <> 0 then // not first run =>
  begin // => check if Delphi is still alive
    MapThreadToWindows(delphiThreadID,delphiAppWindow,delphiEditWindow);
    if delphiAppWindow = 0 then
      CloseDelphiHandles // restart Delphi
    else begin
      if IsIconic(delphiAppWindow) then
        ShowWindow(delphiAppWindow,SW_RESTORE);
      SetForegroundWindow(delphiAppWindow); // New versions of Delphi have only app window :)
      if delphiEditWindow <> 0 then
        SetForegroundWindow(delphiEditWindow); // Old versions of Delphi (2-7) also have edit window
      Exit;
    end;
  end;

  with startupInfo do
  begin
    cb          := SizeOf(startupInfo);
    lpReserved  := nil;
    lpDesktop   := nil;
    lpTitle     := nil;
    dwFlags     := STARTF_USESHOWWINDOW+STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWDEFAULT;
    cbReserved2 := 0;
    lpReserved2 := nil;
  end;
  run := '"' + run + '" "' + openProject.Name + '"';
  if not CreateProcess(nil,PChar(run),nil,nil,false,
           CREATE_DEFAULT_ERROR_MODE+CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
           nil,PChar(ExtractFilePath(openProject.Name)),startupInfo,
           delphiProcessInfo) then
  begin
    StatusPanel0(Format('Cannot run Delphi (%s): %s',[run,SysErrorMessage(GetLastError)]),false,true);
    delphiThreadID := 0;
  end
  else
    delphiThreadID := delphiProcessInfo.dwThreadId;
end;

procedure TfrmMain.actOpenProfileExecute(Sender: TObject);
begin
  with OpenDialog do begin
    DefaultExt := 'prf';
    if openProject = nil then FileName := '*.prf'
                         else FileName := ChangeFileExt(openProject.Name,'.prf');
    Filter     := 'Profile data|*.prf|Any file|*.*';
    if Execute then LoadProfile(FileName);
  end;
end;

procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
  SetCaption;
  SetSource;
  if PageControl1.ActivePage = tabInstrumentation then begin
    clbProcsClick(Sender);
    pnlSourcePreview.Visible := previewVisibleInstr;
    splitSourcePreview.Visible := previewVisibleInstr;
    ResetSourcePreview(true);
  end
  else begin
    with PageControl2 do
      if      ActivePage = tabProcedures then vstProcs.SetFocus
      else if ActivePage = tabClasses    then vstClasses.SetFocus
      else if ActivePage = tabUnits      then vstUnits.SetFocus
      else if ActivePage = tabThreads    then vstThreads.SetFocus;
    lvProcsClick(Sender);
    pnlSourcePreview.Visible := previewVisibleAnalysis;
    splitSourcePreview.Visible := previewVisibleAnalysis;
    ResetSourcePreview(true);
  end;
end;

procedure TfrmMain.SetCaption;
begin
  if PageControl1.ActivePage = tabInstrumentation
    then Caption := 'GpProfile 2017'+IFF(currentProject <> '',' - '+currentProject,'')
    else Caption := 'GpProfile 2017'+IFF(currentProfile <> '',' - '+currentProfile,'')+IFF(loadCanceled,' (incomplete)','');
end;

procedure TfrmMain.SetSource;
var
  enabled: boolean;
begin
  if PageControl1.ActivePage = tabInstrumentation
    then enabled := (currentProject <> '')
    else enabled := (currentProfile <> '');
  if enabled then begin
    sourceCodeEdit.Enabled := true;
    sourceCodeEdit.Color   := SynPasSyn.SpaceAttri.Background;
  end
  else begin
    ClearSource;
    sourceCodeEdit.Enabled := false;
    sourceCodeEdit.Color   := clBtnFace;
  end;
end;

procedure TfrmMain.MRUPrfClick(Sender: TObject; LatestFile: String);
begin
  if (openProfile = nil) or (openProfile.Name <> LatestFile) or loadCanceled then
  try
    if not FileExists(LatestFile) then
      raise Exception.Create('File '+LatestFile+ ' not found.');
    LoadProfile(LatestFile);
  except on e:Exception do
    if ShowErrorYesNo('Error while loading file "'+LatestFile+'"'+slinebreak+'Delete it from the MRU list ?') = mrYes then
    begin
      MRUPrf.DeleteFromMenu(LatestFile);
      MRUPrf.SaveToRegistry();
      MRUPrf.LoadFromRegistry();
    end;
  end;
end;

procedure TfrmMain.actInstrumentRunExecute(Sender: TObject);
begin
  actRescanChanged.Execute;
  DoInstrument;
  actRun.Execute;
end;

procedure TfrmMain.btnCancelLoadClick(Sender: TObject);
begin
  cancelLoading := true;
end;


procedure TfrmMain.cbxSelectThreadProcChange(Sender: TObject);
begin
  FillProcView;
end;

procedure TfrmMain.cbxSelectThreadUnitChange(Sender: TObject);
begin
  FillUnitView();
end;

procedure TfrmMain.cbxSelectThreadClassChange(Sender: TObject);
begin
  FillClassView;
end;


procedure TfrmMain.LoadMetrics(layoutName: string);

  procedure GetHeaders(reg: TGpRegistry; aVST: TVirtualStringTree; prefix: string);
  var
    i: integer;
  begin
    for i := 0 to aVST.Header.Columns.Count-1 do begin
      aVST.Header.Columns[i].Width := reg.ReadInteger(prefix+'Column'+IntToStr(i)+'Width',aVST.Header.Columns[i].Width);
    end;
  end; { GetColumns }


  procedure GetColumns(reg: TGpRegistry; lv: TGpArrowListView; prefix: string);
  var
    i: integer;
  begin
    with lv do begin
      for i := 0 to Columns.Count-1 do begin
        Columns[i].Width := reg.ReadInteger(prefix+'Column'+IntToStr(i)+'Width',Column[i].Width);
      end;
    end;
  end; { GetColumns }

  function CheckCorrectUIVer: boolean;
  begin
    with TGpRegistry.Create do
      try
        RootKey := HKEY_CURRENT_USER;
        OpenKey(cregistryUI, True);
        if ReadString('UIVer','') = cUIVersion then
          Result := True
        else begin
          CloseKey;
          DeleteKey(cRegistryUI);
          LoadLayouts;
          Result := False;
        end;
      finally
        Free;
      end;
  end; { CheckCorrectUIVer }

var
  reg: TGpRegistry;
  wp : TWindowPlacement;
begin
  DisableAlign;
  try
    CheckCorrectUIVer;
    reg := TGpRegistry.Create;
    try
      with reg do begin
        RootKey := HKEY_CURRENT_USER;
        OpenKey(cRegistryUI+'\'+layoutName,true);
        WindowState := TWindowState(ReadInteger('WindowState', 0));
        wp.Length := SizeOf(TWindowPlacement);
        if GetWindowPlacement(frmMain.Handle,@wp) then begin
          wp.rcNormalPosition.Left   := ReadInteger('FormLeft',wp.rcNormalPosition.Left);
          wp.rcNormalPosition.Top    := ReadInteger('FormTop',wp.rcNormalPosition.Top);
          wp.rcNormalPosition.Right  := ReadInteger('FormRight',wp.rcNormalPosition.Right);
          wp.rcNormalPosition.Bottom := ReadInteger('FormBottom',wp.rcNormalPosition.Bottom);
          SetWindowPlacement(frmMain.Handle,@wp);
        end;
        pnlUnits.Width   := ReadInteger('pnlUnitsWidth',pnlUnits.Width);
        pnlClasses.Width := ReadInteger('pnlClassesWidth',pnlClasses.Width);
        pnlSourcePreview.Height := ReadInteger('Panel2Height',pnlSourcePreview.Height);
        previewVisibleInstr     := ReadBool('previewVisibleInstr',true);
        previewVisibleAnalysis  := ReadBool('previewVisibleAnalysis',true);
        pnlCallers.Height       := ReadInteger('pnlCallersHeight',pnlCallers.Height);
        pnlCallees.Height       := ReadInteger('pnlCalleesHeight',pnlCallees.Height);
        splitCallers.Visible    := ReadBool('pnlCalleesVisible',false);
        splitCallees.Visible    := ReadBool('pnlCallersVisible',false);
        pnlCallees.Visible      := splitCallers.Visible;
        pnlCallers.Visible      := splitCallees.Visible;
        pnlBottom.Top           := 99999;
        if PageControl1.ActivePage = tabInstrumentation
          then pnlSourcePreview.Visible := previewVisibleInstr
          else pnlSourcePreview.Visible := previewVisibleAnalysis;
        splitSourcePreview.Visible := pnlSourcePreview.Visible;
        GetHeaders(reg,vstProcs,'lvProcs');
        GetHeaders(reg,vstClasses,'lvClasses');
        GetHeaders(reg,vstUnits,'lvUnits');
        GetHeaders(reg,vstThreads,'lvThreads');
        GetHeaders(reg,vstCallers,'lvCallers');
        GetHeaders(reg,vstCallees,'lvCallees');
        ResetSourcePreview(false);
        ResetCallers;
        ResetCallees;
      end;
    finally reg.Free; end;
  finally EnableAlign; end;
  Application.ProcessMessages;
  SlidersMoved;
  TGpRegistryTools.SetPref(cRegistryUIsub,'Layout',layoutName);
  activeLayout := layoutName;
end; { TfrmMain.LoadMetrics }

procedure TfrmMain.UseDelphiSettings(delphiVer: integer);
var
  s      : TStringList;
  setting: integer;
  i      : integer;
  verch  : char;
begin
  s := TStringList.Create;
  try
    EnumUserSettings(s);
    verch := Chr(delphiVer+Ord('0'));
    setting := s.Count-1;
    for i := 0 to s.Count-2 do
      if s[i][1] = verch then begin
        setting := i;
        break;
      end;
    SynPasSyn.UseUserSettings(setting);
    SetSource;
    sourceCodeEdit.Invalidate;
  finally s.Free; end;
end;



procedure TfrmMain.vstCalleesNodeClick(Sender: TBaseVirtualTree;
  const HitInfo: THitInfo);
var
  LProfilingType : TProfilingInfoTypeEnum;
  LEnum : TVTVirtualNodeEnumerator;
  LProcId : Int64;
  LGraphId : int16;
begin
  LProcId := -1;
  LGraphId := -1;
  LProfilingType := TProfilingInfoTypeEnum.pit_proc; // unused here..
  if assigned(openProfile) and (Sender is TVirtualStringTree) and ((Sender as TVirtualStringTree).SelectedCount>0) then
  begin
    LEnum := (Sender as TVirtualStringTree).SelectedNodes(false).GetEnumerator();
    while(LEnum.MoveNext) do
    begin
      LProfilingType := PProfilingInfoRec(LEnum.Current.GetData).ProfilingType;
      PProfilingInfoRec(LEnum.Current.GetData).GetCallStackInfo(LProcId,LGraphId);
      Break;
    end;
    with openProfile do
    begin
      if LProfilingType in [TProfilingInfoTypeEnum.pit_proc_callers,TProfilingInfoTypeEnum.pit_proc_callees] then
      begin
        LoadSource(resUnits[resProcedures[LGraphId].peUID].ueQual,
                   resProcedures[LGraphId].peFirstLn);
      end;
    end;
  end;


end;

procedure TfrmMain.vstCalleesNodeDblClick(Sender: TBaseVirtualTree;
  const HitInfo: THitInfo);
var
  LProfilingType : TProfilingInfoTypeEnum;
  LEnum : TVTVirtualNodeEnumerator;
  LCaption : string;
  LSelectedProcID : Int64;
  LCallStackID : Int16;
begin
  LSelectedProcID := -1;
  LCallStackID := -1;
  LProfilingType := TProfilingInfoTypeEnum.pit_proc; // unused here..
  with Sender as TVirtualStringTree do
    if (Sender as TVirtualStringTree).SelectedCount>0 then
    begin
      ClearBrowser(popBrowseNext);
      LEnum := (Sender as TVirtualStringTree).SelectedNodes(false).GetEnumerator();
      while(LEnum.MoveNext) do
      begin
        LProfilingType := PProfilingInfoRec(LEnum.Current.GetData).ProfilingType;
        PProfilingInfoRec(LEnum.Current.GetData).GetCallStackInfo(LSelectedProcID,LCallStackID);
        Break;
      end;
      if LCallStackID<>-1 then
        if LProfilingType in [TProfilingInfoTypeEnum.pit_proc_callers,TProfilingInfoTypeEnum.pit_proc_callees] then
        begin
          LCaption := openProfile.resProcedures[LCallStackID].peName;
          PushBrowser(popBrowsePrevious,LCaption,LCallStackID);
        end;
      SelectProcs(LCallStackID);
    end;
end;

procedure TfrmMain.vstProcsNodeClick(Sender: TBaseVirtualTree;
  const HitInfo: THitInfo);
begin
  lvProcsClick(Sender);
end;

{ TfrmMain.UseDelphiSettings }

procedure TfrmMain.FormShow(Sender: TObject);

const
  first: boolean = true;

  procedure ParseCommandLine;
  var
    defDelphi: string;
    ddel     : string;
    delphiVer: integer;
    dpkName  : string;
  begin
    if ParamCount <> 0 then begin
      defDelphi := '';
      delphiVer := 0;
      if ParamCount >= 1 then begin
        ddel := ParamStr(ParamCount);
        if UpperCase(Copy(ddel,1,8)) = '/DELPHI=' then begin
          ddel := ButFirst(ddel,8);
          if (Length(ddel) > 0) and (ddel[1] in ['2'..'9']) then begin
            defDelphi := ddel;
            delphiVer := Ord(ddel[1])-Ord('0');
          end;
        end;
      end;
      UseDelphiSettings(delphiVer);
      if (ParamCount > 1) or (defDelphi = '') then begin
        dpkName := ChangeFileExt(ParamStr(1),'.dpk');
        if FileExists(dpkName)
          then LoadProject(dpkName,defDelphi)
          else LoadProject(ChangeFileExt(ParamStr(1),'.dpr'),defDelphi);
      end;
    end
    else begin
      UseDelphiSettings(0);
      SetSource;
    end;
  end; { ParseCommandLine }

begin
  if first then begin
    first := false;
    LoadMetrics(inpLayoutName.Text);
    FillDelphiVer;
    if (ParamCount = 1) and (UpperCase(ParamStr(1)) = '/FIRSTTIME') then begin
      frmAbout.Left := Left+((Width-frmAbout.Width) div 2);
      frmAbout.Top := Top+((Height-frmAbout.Height) div 2);
      frmAbout.ShowModal;
    end
    else ParseCommandLine;
    if HasParameter('/REMOVEINST') then begin
      actRemoveInstrumentation.Execute;
      actRun.Execute;
      Application.Terminate;
    end;
  end;
end;

procedure TfrmMain.StatusBarResize(Sender: TObject);
begin
  with StatusBar do begin
    if storedPanel1Width = 0
      then storedPanel1Width := Width-Panels[0].Width // first time
      else Panels[0].Width := Width-storedPanel1Width;
  end;
end;

procedure TfrmMain.actHideNotExecutedExecute(Sender: TObject);
begin
  actHideNotExecuted.Checked := not actHideNotExecuted.Checked;
  FillViews;
  SetProfilePref('HideNotExecuted', actHideNotExecuted.Checked);
end;

procedure TfrmMain.actProjectOptionsExecute(Sender: TObject);
var
  projMarker   : integer;
  projSpeedSize: integer;
  oldDefines   : string;
  LSettingsDict : TPrfPlaceholderValueDict;
begin
  with frmPreferences do 
  begin
    if ExecuteProjectSettings(chkShowAll.Checked) then 
    begin
      chkShowAll.Checked := cbShowAllFolders.Checked;
      RebuildDelphiVer;
      if DefinesChanged then 
        actRescanProject.Execute;
    end;
  end;
end;

procedure TfrmMain.actProfileOptionsExecute(Sender: TObject);
begin
  with frmPreferences do
    if frmPreferences.ExecuteProfileSettings(mnuHideNotExecuted.Checked) then
      if mnuHideNotExecuted.Checked <> cbHideNotExecuted.Checked then
        actHideNotExecuted.Execute;
end;


function TfrmMain.ReplaceMacros(s: string): string;

  function GetDelphiXE2Var(const aVarName: string): string;
  begin
    if lowercase(aVarName) = 'platform' then Result:= 'Win32';
    if lowercase(aVarName) = 'config' then Result:= 'Release';
  end;

  function GetEnvVar(const aVarName: String): String;
  var
    vSize: Integer;
  begin
    Result := '';
    vSize := GetEnvironmentVariable(PChar(aVarName), nil, 0);
    if vSize > 0 then
    begin
      SetLength(Result, vSize);
      GetEnvironmentVariable(PChar(aVarName), PChar(Result), vSize);
      // Cut out #0 char
      if Result <> '' then
        Result := Copy(Result, 1, Length(Result)-1);
    end;
  end;

var
  vMacroValue: String;
  vMacros: array of String;
  vInMacro: Boolean;
  vMacroSt: Integer;
  i, p: Integer;
begin
  Result := s;

  // First, build full macros list from Search Path (macro is found by $(MacroName))
  vMacros := nil;
  vMacroSt := -1;
  vInMacro := False;
  for i := 1 to Length(Result) do
    if Copy((Result+' '), i, 2) = '$(' then
    begin
      vInMacro := True;
      vMacroSt := i;
    end
    else if vInMacro and (Result[i] = ')') then
    begin
      vInMacro := False;

      // Get macro name (without round brackets: $( ) )
      p := Length(vMacros);
      SetLength(vMacros, p+1);
      vMacros[p] := Copy(Result, vMacroSt+2, i-1-(vMacroSt+2)+1);
    end;             

  for i := 0 to High(vMacros) do
  begin
    // NB! Paths from DCC_UnitSearchPath element of *.dproj file are already added,
    // so simply skip this macro
    if AnsiUpperCase(vMacros[i]) = 'DCC_UNITSEARCHPATH' then
      Continue;
    
    vMacroValue := GetEnvVar(vMacros[i]);
    if (vMacroValue = '') then vMacroValue:= GetDelphiXE2Var(vMacros[i]);
    // ToDo: Not all macros are possible to get throug environment variables
    // Neet to find out, how to resolve the rest macros
    if vMacroValue <> '' then
      Result := StringReplace(Result, '$(' + vMacros[i] + ')', vMacroValue, [rfReplaceAll]);
  end;
end; { TfrmMain.ReplaceMacros }

function TfrmMain.GetSearchPath(const aProject: string): string;
var
  vPath: string;
  vDofFN: TFileName;
  vDProjFN: TFileName;
  vBdsProjFN: TFileName;
  vDProj: TDProj;
  vBdsProj: TBdsProj;
  vOldCurDir: String;
  vFullPath: String;
  i: Integer;
begin
  vPath := '';

  // Get settings from obsolete dof-file
  vDofFN := ChangeFileExt(aProject, '.dof');
  if FileExists(vDofFN) then
    with TIniFile.Create(vDofFN) do
    try
      vPath := ReadString('Directories', 'SearchPath', '');
    finally
      Free;
    end;

  // Get settings from dproj-file
  vDProjFN := ChangeFileExt(aProject, '.dproj');
  if FileExists(vDProjFN) then
  begin
    vDProj := TDProj.Create(vDProjFN);
    try
      vPath := IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + vDProj.SearchPath;
    finally
      vDProj.Free;
    end;
  end;

  // Get settings from bdsproj-file
  vBdsProjFN := ChangeFileExt(aProject, '.bdsproj');
  if FileExists(vBdsProjFN) then
  begin
    vBdsProj := TBdsProj.Create(vBdsProjFN);
    try
      vPath := IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + vBdsProj.SearchPath;
    finally
      vBdsProj.Free;
    end;
  end;

  // Get settings from registry
  with TGpRegistry.Create do begin
    try
      //Path for Delphi XE2-XE3
      RootKey:= HKEY_CURRENT_USER;
      if OpenKeyReadOnly('HKEY_CURRENT_USER\Software\Embarcadero\BDS\'+DelphiVerToBDSVer(selectedDelphi)+'\Library\Win32') then begin
        vPath := vPath + IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + ReadString('Search Path','');
        CloseKey;
      end;

      // Path for Delphi 2009-XE
      RootKey := HKEY_CURRENT_USER;
      if OpenKeyReadOnly('SOFTWARE\Embarcadero\BDS\' + DelphiVerToBDSVer(selectedDelphi) + '\Library') then
      begin
        vPath := vPath + IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + ReadString('Search Path','');
        CloseKey;
      end;

      // Path for Delphi 2005-2007
      RootKey := HKEY_CURRENT_USER;
      if OpenKeyReadOnly('SOFTWARE\Borland\BDS\' + DelphiVerToBDSVer(selectedDelphi) + '\Library') then
      begin
        vPath := vPath + IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + ReadString('Search Path','');
        vPath := vPath + IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + ReadString('SearchPath','');
        CloseKey;
      end;

      // Path for Delphi 2-7
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKeyReadOnly('SOFTWARE\Borland\Delphi\'+selectedDelphi+'\Library') then
      begin
        vPath := vPath + IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + ReadString('SearchPath','');
        vPath := vPath + IfThen((vPath <> '') and (vPath[Length(vPath)] <> ';'), ';') + ReadString('Search Path','');
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

  // Substitute macros (environment variables) with their real values
  vPath := ReplaceMacros(vPath);

  // Transform all search paths into absolute
  Result := '';
  vOldCurDir := GetCurrentDir;
  if not SetCurrentDir(ExtractFileDir(aProject)) then
    Assert(False);
  try
    for i := 1 to NumElements(vPath, ';', -1) do
    begin
      vFullPath := ExpandUNCFileName(NthEl(vPath, i, ';', -1));
      if DirectoryExists(vFullPath) then
        Result := Result + IfThen(Result <> '', ';') + vFullPath;
    end;
  finally
    SetCurrentDir(vOldCurDir);
  end;
end; { TfrmMain.GetSearchPath }

function TfrmMain.GetOutputDir(const aProject: string): string;
const
  cPlatform = '$(Platform)';
  cConfig = '$(Config)';
var
  vDProj: TDProj;
  vDProjFN: TFileName;
  vDofFN: TFileName;
  vBdsProjFN: TFileName;
  vBdsProj: TBdsProj;
  vOldCurDir: String;
  vXE2Platform: string;
  XE2Pos: cardinal;
begin
  Result := '';

  vDProjFN := ChangeFileExt(aProject, '.dproj');
  if FileExists(vDProjFN) then
  begin
    vDProj := TDProj.Create(vDProjFN);
    try
      Result := vDProj.OutputDir;
      XE2Pos:= Pos(cConfig,Result);
      if XE2Pos <> 0 then begin
        if (XE2ConfigOverride <> '') then
          XE2Config:= XE2ConfigOverride
        else
          XE2Config:= vDProj.XE2Config;
        Result:= ReplaceStr(Result, cConfig, XE2Config);
      end;
      XE2Pos:= Pos(cPlatform,Result);
      if XE2Pos <> 0 then begin
        if (XE2PlatformOverride <> '') then
          XE2Platform:= XE2PlatformOverride
        else
          XE2Platform:= vDProj.XE2Platform;
        Result:= ReplaceStr(Result, cPlatform, XE2Platform);
      end;
    finally
      vDProj.Free;
    end;
  end
  else begin
    vDofFN := ChangeFileExt(aProject, '.dof');
    if FileExists(vDofFN) then
      with TIniFile.Create(vDofFN) do
      try
        Result := ReadString('Directories', 'OutputDir', '');
      finally
        Free;
      end
    else begin
      vBdsProjFN := ChangeFileExt(aProject, '.bdsproj');
      if FileExists(vBdsProjFN) then
      begin
        vBdsProj := TBdsProj.Create(vBdsProjFN);
        try
          Result := vBdsProj.OutputDir;
        finally
          vBdsProj.Free;
        end
      end;
    end;
  end;

  Result := ReplaceMacros(Result);

  // If getting output dir was not successful - use project dir as output dir 
  if Result = '' then
    Result := ExtractFilePath(aProject);

  // Transform path to absolute
  if not IsAbsolutePath(Result) then
  begin
    vOldCurDir := GetCurrentDir;
    try
      if not SetCurrentDir(ExtractFileDir(aProject)) then
        Assert(False);
      Result := ExpandUNCFileName(Result);
    finally
      SetCurrentDir(vOldCurDir)
    end;
  end;
  ProjectOutputDir := result;
end; { TfrmMain.GetOutputDir }

procedure TfrmMain.actRescanProfileExecute(Sender: TObject);
begin
  LoadProfile(openProfile.Name);
end;                      

procedure TfrmMain.CloseDelphiHandles;
begin
  with delphiProcessInfo do begin
    if hProcess <> 0 then begin
      CloseHandle(hProcess);
      CloseHandle(hThread);
      hProcess := 0;
      hThread  := 0;
    end;
    delphiThreadID   := 0;
    delphiAppWindow  := 0;
    delphiEditWindow := 0;
  end;
end;        

procedure TfrmMain.ReloadSource;
var
  unt: string;
  cls: string;
  prc: string;
begin
  if clbProcs.ItemIndex <= 0 then Exit;
  cls := clbClasses.Items[clbClasses.ItemIndex];
  if cls[1] = '<' then prc := clbProcs.Items[clbProcs.ItemIndex]
                  else prc := cls + '.' + clbProcs.Items[clbProcs.ItemIndex];
  unt := clbUnits.Items[clbUnits.ItemIndex];
  LoadSource(openProject.GetUnitPath(unt),openProject.GetFirstLine(unt,prc));
end; { TfrmMain.RebloadSource }

procedure TfrmMain.clbProcsClick(Sender: TObject);
begin
  ReloadSource;
end;

procedure TfrmMain.LoadSource(fileName: AnsiString; focusOn: integer);
begin
  try
    if fileName <> '' then begin
      if fileName <> loadedSource then begin
        sourceCodeEdit.Lines.LoadFromFile(fileName);
        loadedSource := fileName;
      end;
      if focusOn < 0 then focusOn := 0;
      if focusOn >= sourceCodeEdit.Lines.Count then focusOn := sourceCodeEdit.Lines.Count-1;
      sourceCodeEdit.TopLine := focusOn+1;
      StatusPanel0(fileName,true);
    end;
  except sourceCodeEdit.Lines.Clear; end;
end; { TfrmMain.LoadSource }

procedure TfrmMain.ClearSource;
begin
  sourceCodeEdit.Lines.Clear;
  loadedSource := '';
  StatusPanel0('',true);
end; { TfrmMain.ClearSource }

procedure TfrmMain.lvProcsClick(Sender: TObject);
var
  uid: integer;
  LVST : TVirtualStringTree;
  LEnum : TVTVirtualNodeEnumerator;
  LData : PProfilingInfoRec;
  LSelectedID : integer;
begin
  LSelectedID := -1;
  if openProfile <> nil then
    with PageControl2, ActivePage do begin
      if ActivePage <> tabThreads then
      begin
        if ActivePage = tabProcedures then
          LVST := vstProcs
        else if ActivePage = tabClasses then
          LVST := vstClasses
        else
          LVST := vstUnits;

        if Assigned(LVST) then
        begin
          LEnum := LVST.SelectedNodes(false).GetEnumerator();
          while(LEnum.MoveNext) do
          begin
            LData := PProfilingInfoRec(LEnum.Current.GetData);
            LSelectedID := LData.GetId;
          end;
        end;
        with openProfile do begin
        begin
          if LSelectedID >= 0 then
          begin
            if ActivePage = tabProcedures then begin
              RedisplayCallers;
              RedisplayCallees;
              LoadSource(resUnits[resProcedures[LSelectedID].peUID].ueQual,
                         resProcedures[LSelectedID].peFirstLn);
              Exit;
            end
            else if ActivePage = tabClasses then begin
              uid := resClasses[LSelectedID].ceUID;
              if uid >= 0 then LoadSource(resUnits[uid].ueQual,resClasses[LSelectedID].ceFirstLn);
              Exit;
            end
            else if ActivePage = tabUnits then begin
              LoadSource(resUnits[LSelectedID].ueQual,0);
              Exit;
            end;

          end;
        end;
      end;
    end;
  end;
  ClearSource;       
end;

procedure TfrmMain.PageControl2Change(Sender: TObject);
begin
  selectedProc := nil;
  if PageControl2.ActivePage = tabThreads then
    ClearSource
  else
    lvProcsClick(Sender);
end;

procedure TfrmMain.actExportProfileExecute(Sender: TObject);
begin
  with frmExport do begin
    cbProcedures.Checked := true;
    cbClasses.Checked    := true;
    cbUnits.Checked      := true;
    cbThreads.Checked    := true;
    QueryExport;
  end;
end;

procedure TfrmMain.mnuExportProfileClick(Sender: TObject);
begin
  with frmExport do begin
    cbProcedures.Checked := false;
    cbClasses.Checked    := false;
    cbUnits.Checked      := false;
    cbThreads.Checked    := false;
    with PageControl2 do begin
      if      ActivePage = tabProcedures then cbProcedures.Checked := true
      else if ActivePage = tabClasses    then cbClasses.Checked    := true
      else if ActivePage = tabUnits      then cbUnits.Checked      := true
      else if ActivePage = tabThreads    then cbThreads.Checked    := true;
    end;
    QueryExport;
  end;
end;

procedure TfrmMain.ExportTo(fileName: string; exportProcs, exportClasses,
  exportUnits, exportThreads, exportCSV: boolean);

  procedure LExport(var f: textfile; aLvTools:TSimpleStatsListTools; delim: char);
  var
    i   : integer;
    header: string;
    line  : string;
    lEnum : TVTVirtualNodeEnumerator;
  begin
    header := '';
    for i := 0 to aLvTools.ListView.Header.Columns.Count-1 do begin
      if header <> '' then header := header + delim;
      header := header + aLvTools.ListView.Header.Columns[i].Text;
    end;
    Writeln(f,header);
    lEnum := aLvTools.ListView.ChildNodes(nil).GetEnumerator;
    while(lEnum.MoveNext) do
    begin
      line := aLVTools.GetRowAsCsv(lEnum.Current,delim);
      Writeln(f,line);
    end;
    Writeln(f,delim);
  end; { _Export }

  procedure _Export(var f: textfile; listView: TGpArrowListView; delim: char);
  var
    i,j   : integer;
    header: string;
    line  : string;
  begin
    with listView do begin
      header := '';
      for i := 0 to Columns.Count-1 do begin
        if header <> '' then header := header + delim;
        header := header + Columns[i].Caption;
      end;
      Writeln(f,header);
      for j := 0 to Items.Count-1 do begin
        with Items[j] do begin
          line := Caption;
          for i := 0 to Subitems.Count-1 do
            line := line + delim + StringReplace(Subitems[i], ',', '.', [rfReplaceAll]);
          Writeln(f,line);
        end;
      end;
      Writeln(f,delim);
    end;
  end; { _Export }

  procedure ExpProcedures(var f: textfile; delim: char);
  begin
    LExport(f,fvstProcsTools,delim);
  end; { ExpProcedures }

  procedure ExpClasses(var f: textfile; delim: char);
  begin
   // TODO ASE: add classes

    LExport(f,fvstClassesTools, delim);
  end; { ExpClasses }

  procedure ExpUnits(var f: textfile; delim: char);
  begin
    LExport(f,fvstUnitsTools,delim);
  end; { ExpUnits }

  procedure ExpThreads(var f: textfile; delim: char);
  begin
    LExport(f,fvstThreadsTools,delim);
  end; { ExpThreads }

var
  f    : textfile;
  delim: char;

begin
//  kaj pa threadi?
  try
    if ExtractFileExt(fileName) = '' then
      if exportCSV then fileName := fileName + '.csv'
                   else fileName := fileName + '.txt';
    AssignFile(f,fileName);
    Rewrite(f);
    try
      if exportCSV then delim := ';' else delim := #9;
      if exportProcs   then ExpProcedures(f,delim);
      if exportClasses then ExpClasses(f,delim);
      if exportUnits   then ExpUnits(f,delim);
      if exportThreads then ExpThreads(f,delim);
    finally CloseFile(f); end;
  except Application.MessageBox(PChar('Cannot write to file '+fileName),'Export error',MB_OK); end;
end;

procedure TfrmMain.QueryExport;
begin
  with frmExport do begin
    Left := frmMain.Left+((frmMain.Width-Width) div 2);
    Top := frmMain.Top+((frmMain.Height-Height) div 2);
    if ShowModal = mrOK then begin
      if inpWhere.Text <> '' then
        ExportTo(inpWhere.Text,cbProcedures.Checked,cbClasses.Checked,
                 cbUnits.Checked,cbThreads.Checked,rbCSV.Checked);
    end;
  end;
end;

procedure TfrmMain.StatusPanel0(msg: string; isSourcePos: boolean; beep: boolean = false);
begin
  if (msg <> '') or wasSourcePos then begin
    StatusBar.Panels[0].Text := msg;
    wasSourcePos := isSourcePos;
    if beep then MessageBeep($FFFFFFFF);
  end;
end;

procedure TfrmMain.ShowError(const Msg : string);
begin
  StatusPanel0(msg,true,true);
  MessageDlg(msg,TMsgDlgType.mtError,[mbOK],0,mbOk);
end;


function TfrmMain.ShowErrorYesNo(const Msg : string): integer;
begin
  result := MessageDlg(msg,TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes ,TMsgDlgBtn.mbNo],0,mbYes);
end;

procedure TfrmMain.actMakeCopyProfileExecute(Sender: TObject);
var LSrc : string;
begin
  try
    SaveDialog1.FileName := ButLast(openProfile.Name,Length(ExtractFileExt(openProfile.Name)))+
                FormatDateTime('_ddmmyy',Now)+'.prf';
    SaveDialog1.Title := 'Make copy of '+openProfile.Name;
    if SaveDialog1.Execute then begin
      if ExtractFileExt(SaveDialog1.FileName) = '' then 
        SaveDialog1.FileName := SaveDialog1.FileName + '.prf';
    LSrc := openProfile.Name;
    TFile.Copy(LSrc,SaveDialog1.FileName,true);
    MRUPrf.LatestFile := SaveDialog1.FileName;
    MRUPrf.LatestFile := openProfile.Name;
  end;
  except on e: Exception do
    begin
      ShowError(e.Message);
    end;
  end;
end;

procedure TfrmMain.actDelUndelProfileExecute(Sender: TObject);
var
  newProj: string;
begin
  try
    if undelProject = '' then begin // delete
      undelProject := ChangeFileExt(openProfile.Name,'.~pr');
      TFile.Move(openProfile.Name,undelProject);
      NoProfile;
      SwitchDelMode(false);
    end
    else begin
      newProj := ChangeFileExt(undelProject,'.prf');
      TFile.Move(undelProject,newProj);
      LoadProfile(newProj);
    end;
  except on e: Exception do
    begin
      ShowError(e.Message);
    end;
  end;
end;

procedure TfrmMain.SwitchDelMode(delete: boolean);
var
  proj: string;
begin
  if delete then begin
    if undelProject <> '' then DeleteFile(undelProject);
    undelProject := '';
    with actDelUndelProfile do begin
      Caption := '&Delete';
      ImageIndex := 14;
      Hint := 'Delete profile';
    end;
  end
  else begin
    with actDelUndelProfile do begin
      proj := ChangeFileExt(undelProject,'.prf');
      Caption := 'Un&delete '+proj;
      ImageIndex := 15;
      Hint := 'Undelete '+proj;
    end;
  end;
end;

procedure TfrmMain.actRenameMoveProfileExecute(Sender: TObject);
begin
  try
    SaveDialog1.FileName := ButLast(openProfile.Name,Length(ExtractFileExt(openProfile.Name)))+
                FormatDateTime('_ddmmyy',Now)+'.prf';
    SaveDialog1.Title := 'Rename/Move '+openProfile.Name;
    if SaveDialog1.Execute then begin
      if ExtractFileExt(SaveDialog1.FileName) = '' then
        SaveDialog1.FileName := SaveDialog1.FileName + '.prf';
      TFile.Move(openProfile.Name,SaveDialog1.FileName);
      openProfile.Rename(SaveDialog1.FileName);
      currentProfile := ExtractFileName(SaveDialog1.FileName);
      SetCaption;
      MRUPrf.LatestFile := SaveDialog1.FileName;
    end;
  except on e: Exception do
    begin
      ShowError(e.Message);
    end
  end;
end;

procedure TfrmMain.NoProfile;
begin
  openProfile.Free;
  openProfile := nil;
  FillThreadCombos;
  currentProfile := '';
  PageControl1.ActivePage := tabInstrumentation;
  PageControl1Change(self);
  SetCaption;
  SetSource;
  FillViews(1);
  ClearBreakdown;
  actHideNotExecuted.Enabled   := false;
  actJumpToCallGraph.Enabled   := false;
  actRescanProfile.Enabled     := false;
  actExportProfile.Enabled     := false;
  mnuExportProfile.Enabled     := false;
  actRenameMoveProfile.Enabled := false;
  actMakeCopyProfile.Enabled   := false;
  actProfileOptions.Enabled    := false;
  frmCallGraph.ClearProfile;
  frmCallGraph.Hide;
  DisablePC2;
end;

procedure TfrmMain.actRescanChangedExecute(Sender: TObject);
begin
  RescanProject;
end;

procedure TfrmMain.AppActivate(Sender: TObject);
begin
  // Maybe, Rescan in OnActivate is excessive (especially for large projects)
  actRescanChanged.Execute;
end; { TfrmMain.AppActivate }

procedure TfrmMain.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  Handled := false;
  if msg.HWND = Application.Handle then
    if msg.message = cmdMsg then
      if msg.WParam = CMD_DONE then
      begin
        PostMessage(Handle,WM_ReloadProfile,0,0);
        Handled := true;
      end;
end; { TfrmMain.AppMessage }

procedure TfrmMain.AppShortcut(var Msg: TWMKey; var Handled: boolean);
begin
  if msg.CharCode = 112 then
    if frmAbout.Visible then Application.HelpContext(_WhatisGpProfile)
    else if frmPreferences.Visible then begin
      if not frmPreferences.tabInstrumentation.TabVisible then Application.HelpContext(_Options2)
      else if not frmPreferences.tabAnalysis.TabVisible then Application.HelpContext(_Options1)
      else Application.HelpContext(_Preferences);
    end
    else if frmExport.Visible then Application.HelpContext(_Export)
    else if pnlLayout.Visible then Application.HelpContext(_LayoutManager)
    else if PageControl1.ActivePage = tabInstrumentation then Application.HelpContext(_Instrumentation3)
    else Application.HelpContext(_Analysis3);
end; { TfrmMain.AppShortcut }

procedure TfrmMain.RescanProject;
var
  iiu,iic,iip: integer;
begin
  if openProject = nil then
    Exit;

  if (not GetProjectPref('UseFileDate', prefUseFileDate)) or openProject.AnyChange(false) then
  begin
    iiu := clbUnits.ItemIndex;
    iic := clbClasses.ItemIndex;
    iip := clbProcs.ItemIndex;
    ParseProject(openProject.Name, true);
    if (iiu < clbUnits.Items.Count) and (clbUnits.Items.Count > 0) then
    begin
      clbUnits.ItemIndex := iiu;
      clbUnitsClick(self);
      if (iic < clbClasses.Items.Count) and (clbClasses.Items.Count > 0) then
      begin
        clbClasses.ItemIndex := iic;
        clbClassesClick(self);
        if (iip < clbProcs.Items.Count) and (clbProcs.Items.Count > 0) then
        begin
          clbProcs.ItemIndex := iip;
          clbProcsClick(self);
        end;
      end;
    end;
    SetSource;
  end;
end;

procedure TfrmMain.actChangeLayoutExecute(Sender: TObject);
begin
  if (not pnlLayout.Visible) or
     (UpperCase(activeLayout) <> UpperCase(lvLayouts.Selected.Caption))
    then SaveMetrics(activeLayout);
  inpLayoutName.Text := lvLayouts.Selected.Caption;
  LoadMetrics(inpLayoutName.Text);
  RebuildLayoutPopup(true);
  SetChangeLayout(true);
end;

procedure TfrmMain.actLayoutManagerExecute(Sender: TObject);
begin
  if not pnlLayout.Visible then RepositionLayout;
  pnlLayout.Visible := not pnlLayout.Visible;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  pnlLayout.Hide;
end;

procedure TfrmMain.RepositionSliders;
begin
  pnlCallees.Height := Round(calleesPerc*tabProcedures.Height);
  pnlBottom.Top := 99999;
  pnlCallers.Height := Round(callersPerc*tabProcedures.Height);
end;

procedure TfrmMain.SlidersMoved;
begin
  callersPerc := pnlCallers.Height/tabProcedures.Height;
  calleesPerc := pnlCallees.Height/tabProcedures.Height;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  if pnlLayout.Visible then RepositionLayout;
  RepositionSliders;
end;

procedure TfrmMain.RepositionLayout;
var
  right : integer;
  right2: integer;
begin
  right  := BtnLayoutManager.Left+pnlToolbarLayout.Left+BtnLayoutManager.Width+3;
  right2 := Width-9;
  if right2 < right then right := right2;
  pnlLayout.Left := right-pnlLayout.Width+1;
  pnlLayout.Top  := 0;
end;

procedure TfrmMain.lbLayoutsClick(Sender: TObject);
begin
  if assigned(lvLayouts.Selected)
    then inpLayoutName.Text := lvLayouts.Selected.Caption;
end;

procedure TfrmMain.actAddLayoutUpdate(Sender: TObject);
begin
  actAddLayout.Enabled := ((inpLayoutName.Text <> '') and
                           (not IsLayout(inpLayoutName.Text)));
end;

procedure TfrmMain.actRenameLayoutUpdate(Sender: TObject);
begin
  actRenameLayout.Enabled := ((lvLayouts.Selected <> nil) and
                              (inpLayoutName.Text <> '') and
                              (not IsLayout(inpLayoutName.Text)) and
                              (lvLayouts.Selected.ImageIndex <> 1));
end;

procedure TfrmMain.actChangeLayoutUpdate(Sender: TObject);
begin
  actChangeLayout.Enabled := ((not pnlLayout.Visible) or
                              ((lvLayouts.Selected <> nil) and
                               (lvLayouts.Selected.ImageIndex <> 1)));
end;

procedure TfrmMain.actDelLayoutUpdate(Sender: TObject);
begin
  actDelLayout.Enabled := (lvLayouts.Selected <> nil);
end;

procedure TfrmMain.inpLayoutNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '\' then Key := #0
  else if Key = #13 then begin
    actAddLayout.Execute;
    pnlLayout.Hide;
  end;
end;

procedure TfrmMain.actDelLayoutExecute(Sender: TObject);
var
  idx: integer;
begin
  if lvLayouts.Selected.ImageIndex = 1 then begin
    lvLayouts.Selected.ImageIndex := 0;
    RebuildLayoutPopup(false);
  end
  else begin
    activeLayout := '';
    lvLayouts.Selected.ImageIndex := 1;
    idx := lvLayouts.Items.IndexOf(lvLayouts.Selected);
    Inc(idx);
    if idx >= lvLayouts.Items.Count then idx := 0;
    if idx < lvLayouts.Items.Count then begin
      lvLayouts.Selected := lvLayouts.Items[idx];
      inpLayoutName.Text := lvLayouts.Items[idx].Caption;
    end
    else inpLayoutName.Text := '';
    RebuildLayoutPopup(true);
    if idx < lvLayouts.Items.Count then actChangeLayout.Execute;
  end;
  with actDelLayout do begin
    if lvLayouts.Selected.ImageIndex = 1 then begin
      Caption := 'Undelete';
      Hint    := 'Undelete layout';
    end
    else begin
      Caption := 'Delete';
      Hint    := 'Delete layout';
    end;
  end;
end;

procedure TfrmMain.actAddLayoutExecute(Sender: TObject);
begin
  SaveMetrics(activeLayout);
  lvLayouts.Selected := lvLayouts.Items.Add;
  lvLayouts.Selected.Caption := inpLayoutName.Text;
  activeLayout := inpLayoutName.Text;
  RebuildLayoutPopup(true);
end;

procedure TfrmMain.lbLayoutsDblClick(Sender: TObject);
begin
  if lvLayouts.Selected.ImageIndex <> 1 then begin
    inpLayoutName.Text := lvLayouts.Selected.Caption;
    actChangeLayout.Execute;
    pnlLayout.Hide;
  end;
end;

procedure TfrmMain.lbLayoutsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    if lvLayouts.Selected <> nil then lbLayoutsDblClick(Sender);
end;

procedure TfrmMain.actRenameLayoutExecute(Sender: TObject);
begin
  with TGpRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      MoveKey(cRegistryUI+'\'+lvLayouts.Selected.Caption, cRegistryUI+'\'+inpLayoutName.Text,true);
    finally
      Free;
    end;

  lvLayouts.Selected.Caption := inpLayoutName.Text;
  RebuildLayoutPopup(true);
end;

procedure TfrmMain.actHelpAboutExecute(Sender: TObject);
begin
  frmAbout.Left := Left+((Width-frmAbout.Width) div 2);
  frmAbout.Top := Top+((Height-frmAbout.Height) div 2);
  frmAbout.ShowModal;   
end;

procedure TfrmMain.actHelpShortcutKeysExecute(Sender: TObject);
begin
  WinHelp(Handle,PChar(Application.HelpFile+'>Proc'),HELP_CONTEXT,_Shortcutkeys);
end;

procedure TfrmMain.lvLayoutsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  with actDelLayout do begin
    if Item.ImageIndex = 1 then begin
      Caption := 'Undelete';
      Hint    := 'Undelete layout';
    end
    else begin
      Caption := 'Delete';
      Hint    := 'Delete layout';
    end;
  end;
  with actChangeLayout do begin
    SetChangeLayout(Item.ImageIndex = 2);
  end;
end; 

procedure TfrmMain.SetChangeLayout(setRestore: boolean);
begin
  with actChangeLayout do begin
    if setRestore then begin
      Caption := 'Restore';
      Hint    := 'Restore layout';
    end
    else begin
      Caption := 'Activate';
      Hint    := 'Activate layout';
    end;
  end;
end; { TfrmMain.SetChangeLayout }

procedure TfrmMain.actHelpContentsExecute(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER,0);
end;

procedure TfrmMain.actHelpQuickStartExecute(Sender: TObject);
begin
  Application.HelpContext(_Handson);
end;

procedure TfrmMain.ResetSourcePreview(reposition: boolean);
begin
  with actShowHideSourcePreview do begin
    Tag := 1-Ord(pnlSourcePreview.Visible);
    if Tag = 1 then begin
      Caption := 'Show &Source Preview';
      Hint    := 'Show source preview';
    end
    else begin
      Caption := 'Hide &Source Preview';
      Hint    := 'Hide source preview';
    end;
    ImageIndex := 20+Tag;
  end;
  if reposition then RepositionSliders;
end; { TfrmMain.ResetSourcePreview }

procedure TfrmMain.ResetCallers;
begin
  with actShowHideCallers do begin
    Tag := 1-Ord(pnlCallers.Visible);
    if Tag = 1 then begin
      Caption := 'Show &Callers';
      Hint    := 'Show callers';
    end
    else begin
      Caption := 'Hide &Callers';
      Hint    := 'Hide callers';
    end;
    ImageIndex := 22+Tag;
  end;
  RedisplayCallers;
  SlidersMoved;
end; { TfrmMain.ResetCallers }

procedure TfrmMain.ResetCallees;
begin
  with actShowHideCallees do begin
    Tag := 1-Ord(pnlCallees.Visible);
    if Tag = 1 then begin
      Caption := 'Show Calle&d';
      Hint    := 'Show called';
    end
    else begin
      Caption := 'Hide Calle&d';
      Hint    := 'Hide called';
    end;
    ImageIndex := 24+Tag;
  end;
  RedisplayCallees;
  SlidersMoved;
end; { TfrmMain.ResetCallers }

procedure TfrmMain.actShowHideSourcePreviewExecute(Sender: TObject);
begin
  pnlSourcePreview.Visible := not pnlSourcePreview.Visible;
  splitSourcePreview.Visible := pnlSourcePreview.Visible;
  if PageControl1.ActivePage = tabInstrumentation
    then previewVisibleInstr := pnlSourcePreview.Visible
    else previewVisibleAnalysis := pnlSourcePreview.Visible;
  ResetSourcePreview(true);
  if pnlCallers.Height > pnlTopTwo.Height then pnlCallers.Height := pnlTopTwo.Height div 2;
end;

procedure TfrmMain.actShowHideCallersExecute(Sender: TObject);
begin
  if pnlCallers.Visible then begin
    pnlCallers.Hide;
    splitCallers.Hide;
  end
  else begin
    splitCallers.Show;
    pnlCallers.Show;
  end;
  ResetCallers;
end;

procedure TfrmMain.actShowHideCallersUpdate(Sender: TObject);
begin
  actShowHideCallers.Enabled := (PageControl1.ActivePage = tabAnalysis) and
                                (PageControl2.ActivePage = tabProcedures);
end;

procedure TfrmMain.actShowHideCalleesExecute(Sender: TObject);
begin
  if pnlCallees.Visible then begin
    pnlCallees.Hide;
    splitCallees.Hide; 
  end
  else begin
    pnlCallees.Show;
    splitCallees.Show;
  end;
  pnlCallees.Top := 99999;
  pnlBottom.Top := 99999;
  ResetCallees;
end;

procedure TfrmMain.actShowHideCalleesUpdate(Sender: TObject);
begin
  actShowHideCallees.Enabled := (PageControl1.ActivePage = tabAnalysis) and
                                (PageControl2.ActivePage = tabProcedures);
end;



procedure TfrmMain.RedisplayCallees(resortOn: integer = -1);
var
  callingPID: int64;
  i         : integer;
begin
  if pnlCallees.Visible and (vstProcs.SelectedCount>0) then
  begin
    fvstProcsCalleesTools.BeginUpdate;
    fvstProcsCalleesTools.Clear();
    fvstProcsCalleesTools.ThreadIndex := cbxSelectThreadClass.ItemIndex;
    fvstProcsCalleesTools.ProfileResults := openProfile;
    try
      with openProfile do
      begin
        if DigestVer < 3 then
          Exit;
        if cbxSelectThreadProc.ItemIndex >= 0 then
        begin
          callingPID := fvstProcsTools.GetSelectedId;
          for i := Low(resCallGraph)+1 to High(resCallGraph) do begin
            if assigned(resCallGraph[callingPID,i]) then begin
              with resCallGraph[callingPID,i]^ do begin
                if (not actHideNotExecuted.Checked) or (cgeProcCnt[cbxSelectThreadProc.ItemIndex] > 0) then
                begin
                  fvstProcsCalleesTools.AddEntry(callingPID,i);
                end;
              end; // with
            end; // if
          end; // for
        end;
      end;
    finally
      fvstProcsCalleesTools.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.RedisplayCallers(resortOn: integer = -1);
var
  calledPID: int64;
  i        : integer;
begin
  if pnlCallers.Visible and (vstProcs.SelectedCount<>0) then
  begin
    fvstProcsCallersTools.BeginUpdate;
    fvstProcsCallersTools.Clear();
    fvstProcsCallersTools.ThreadIndex := cbxSelectThreadClass.ItemIndex;
    fvstProcsCallersTools.ProfileResults := openProfile;
    try
      with openProfile do
      begin
        if DigestVer < 3 then
          Exit;
        if cbxSelectThreadProc.ItemIndex >= 0 then
        begin
          calledPID := fvstProcsTools.GetSelectedId();
          for i := Low(resCallGraph)+1 to High(resCallGraph) do begin
            if assigned(resCallGraph[i,calledPID]) then
            begin
              fvstProcsCallersTools.AddEntry(calledPID, i);
            end; // if
          end; // for
        end;
      end;
    finally
      fvstProcsCallersTools.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.SelectProcs(pid: integer);
var
  LEnumor : TVTVirtualNodeEnumerator;
  LData : PProfilingInfoRec;
begin
  LEnumor := vstProcs.Nodes().GetEnumerator();
  while(LEnumor.MoveNext) do
  begin
    LData := PProfilingInfoRec(LEnumor.Current.GetData());
    if LData.ProcId = pid then
    begin
      vstProcs.Selected[LEnumor.Current] := True;

    end;
  end;
(*  for i := 0 to .Count-1 do
      if integer(Items[i].Data) = pid then begin
        Selected := Items[i];
        ItemFocused := Selected;
        ActiveControl := lvProcs;
        Selected.MakeVisible(false);
        lvProcsSelectItem(lvProcs,Selected,true);
        Exit;
      end;
  end;    *)
end;

procedure TfrmMain.ClearBrowser(popBrowser: TPopupMenu);
begin
  while popBrowser.Items.Count > 0 do popBrowser.Items.Remove(popBrowser.Items[0]);
end;

procedure TfrmMain.PushBrowser(popBrowser: TPopupMenu; description: string;
  procID: integer);
var
  mn: TMenuItem;
begin
  mn := TMenuItem.Create(self);
  mn.Caption := description;
  mn.HelpContext := procID;
  mn.OnClick := BrowserClick;
  popBrowser.Items.Insert(0,mn);
  if popBrowser = popBrowseNext then actBrowseNext.Hint := description
                                else actBrowsePrevious.Hint := description;
end;

procedure TfrmMain.BrowserClick(Sender: TObject);
begin
  if (Sender as TMenuItem).Parent = popBrowsePrevious.Items
    then Restack(popBrowsePrevious,popBrowseNext,Sender as TMenuItem)
    else Restack(popBrowseNext,popBrowsePrevious,Sender as TMenuItem);
end;

procedure TfrmMain.actBrowsePreviousExecute(Sender: TObject);
begin
  RestackOne(popBrowsePrevious,popBrowseNext);
end;

procedure TfrmMain.actBrowseNextExecute(Sender: TObject);
begin
  RestackOne(popBrowseNext,popBrowsePrevious);
end;

procedure TfrmMain.actBrowseNextUpdate(Sender: TObject);
begin
  actBrowseNext.Enabled := popBrowseNext.Items.Count > 0;
end;

procedure TfrmMain.actBrowsePreviousUpdate(Sender: TObject);
begin
  actBrowsePrevious.Enabled := popBrowsePrevious.Items.Count > 0;
end;

procedure TfrmMain.PopBrowser(popBrowser: TPopupMenu; var description: string;
  var procID: integer);
var
  newDesc: string;
begin
  with popBrowser.Items[0] do begin
    description := Caption;
    procID := HelpContext;
  end;
  popBrowser.Items.Remove(popBrowser.Items[0]);
  if popBrowser.Items.Count = 0 then newDesc := ''
                                else newDesc := popBrowser.Items[0].Caption;
  if popBrowser = popBrowseNext then actBrowseNext.Hint := newDesc
                                else actBrowsePrevious.Hint := newDesc;
end;

procedure TfrmMain.ClearBreakdown;
begin
  ClearBrowser(popBrowseNext);
  ClearBrowser(popBrowsePrevious);
  fvstProcsCallersTools.Clear;
  fvstProcsCalleesTools.Clear();
end;

procedure TfrmMain.RestackOne(fromPop, toPop: TPopupMenu);
var
  description: string;
  procID     : integer;
  LNode : PVirtualNode;
begin
  LNode := fvstProcsTools.GetSelectedNode;
  if assigned(LNode) then
    PushBrowser(toPop,fvstProcsTools.GetSelectedCaption(),fvstProcsTools.GetSelectedId());
  PopBrowser(fromPop,description,procID);
  SelectProcs(procID);
end;

procedure TfrmMain.Restack(fromPop, toPop: TPopupMenu;
  menuItem: TMenuItem);
var
  mustStop  : boolean;
  juggleDesc: string;
  jugglePID : integer;
begin
  juggleDesc := fvstProcsTools.GetSelectedCaption();
  jugglePID  := fvstProcsTools.GetSelectedId();
  repeat
    mustStop := (fromPop.Items[0] = menuItem);
    PushBrowser(toPop,juggleDesc,jugglePID);
    PopBrowser(fromPop,juggleDesc,jugglePID);
  until mustStop;
  SelectProcs(jugglePID);
end;

procedure TfrmMain.actOpenCallGraphExecute(Sender: TObject);
begin
  frmCallGraph.ReloadProfile(openProfile.Name,openProfile);
  frmCallGraph.Show;
end;

procedure TfrmMain.ZoomOnProcedure(procedureID, threadID: integer);
begin
  PageControl2.ActivePage := tabProcedures;
  if cbxSelectThreadProc.Enabled then cbxSelectThreadProc.ItemIndex := threadID;
  SelectProcs(procedureID);
  frmMain.Show;
end;

procedure TfrmMain.actOpenCallGraphUpdate(Sender: TObject);
begin
  actOpenCallGraph.Enabled := assigned(openProfile) and (openProfile.DigestVer > 2);
end;

procedure TfrmMain.actJumpToCallGraphExecute(Sender: TObject);
begin
  actOpenCallGraph.Execute;
  frmCallGraph.ZoomOnProcedure(fvstProcsTools.GetSelectedId(),cbxSelectThreadProc.ItemIndex);
end;

procedure TfrmMain.actJumpToCallGraphUpdate(Sender: TObject);
begin
  actJumpToCallGraph.Enabled := assigned(fvstProcsTools.GetSelectedNode());
end;

function TfrmMain.GetDOFSetting(section, key, defval: string): string;
begin
  Result := '';
  if Assigned(openProject) then
  begin
    with TIniFile.Create(ChangeFileExt(openProject.Name,'.dof')) do
      try
        Result := ReadString(section, key, defval);
      finally
        Free;
      end;
  end
  else
    Result := '(project defines)';
end;

procedure TfrmMain.splitCallersMoved(Sender: TObject);
begin
  SlidersMoved;
end;


end.