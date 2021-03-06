unit TztMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, ImgList, ComCtrls, ToolWin,
  StdCtrls, Mask, Grids, ExtCtrls, Math, Buttons, StrUtils, StdActns,
  ActnMan, ActnCtrls,ActnMenus, XPStyleActnCtrls, StdStyleActnCtrls,
  hh, hh_funcs,
  XPMan, // f�r XP Style, Externe Manifest-Datei nicht mehr n�tig
  VistaFix, // Korrekturen f�r Probleme mit Vista
  ShellApi,
  AllgConst, AllgObj, AllgComp, AllgFunc, TztAllg, TztInfoDlg, MruObj;

type

  TTztHauptDlg = class(TForm)

  published

    XPManifest1: TXPManifest;
    UhrzeitTimer: TTimer;
    ImageList: TImageList;
    FileOpenDialog1: TFileOpenDialog;
    FileSaveDialog1: TFileSaveDialog;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ActionMainMenuBar: TActionMainMenuBar;
    ActionToolBar: TActionToolBar;
    ActionManager: TActionManager;
    DatNeuAction: TAction;
    DatOeffnenAction: TAction;
    DatSpeichernAction: TAction;
    DatSpeichernUnterAction: TAction;
    DatKopierenAction: TAction;
    ImportTlnLstAction: TAction;
    AbgleichAction: TAction;
    DruckenAction: TAction;
    AendernAction: TAction;
    NeuAction: TAction;
    LoeschenAction: TAction;
    StartAction: TAction;
    StoppAction: TAction;
    ZeitnahmeAction: TAction;
    MausSperrenAction: TAction;
    SpalteTlnAction: TAction;
    ShowTlnLstAction: TAction;
    SpalteZahlAction: TAction;
    ZeitAufAction: TAction;
    ZeitAbAction: TAction;
    SnrAufAction: TAction;
    SnrAbAction: TAction;
    KleinerAction: TAction;
    GroesserAction: TAction;
    ZoomBreitAction: TAction;
    ZoomGanzAction: TAction;
    OnlineHilfeAction: TAction;
    TrzImWebAction: TAction;
    InfoAction: TAction;
    ContextHilfeAction: TAction;
    MruAction1: TAction;
    MruAction2: TAction;
    MruAction3: TAction;
    MruAction4: TAction;
    MruAction5: TAction;
    MruAction6: TAction;
    MruAction7: TAction;
    MruAction8: TAction;
    BeendenAction: TAction;
    OptionenAction: TAction;
    UpdateAction: TAction;
    SnrRfidLabel: TLabel;
    SnrRfidEdit: TTriaMaskEdit;
    ZeitLabel: TLabel;
    ZeitDummyEdit: TTriaEdit;
    ZeitEdit: TStartZeitEdit;
    NameLabel: TLabel;
    NameEdit: TTriaEdit;
    ZahlLabel: TLabel;
    ZahlEdit: TTriaEdit;
    ErfassenBtn: TButton;
    TrennPanel: TPanel;
    TztGrid: TTriaGrid;
    GridSnrRfidEdit: TTriaMaskEdit;
    GridZeitEdit: TUhrZeitEdit;
    AendBtn: TButton;
    NeuBtn: TButton;
    LoeschBtn: TButton;
    MausFixEdit: TTriaEdit;
    StatusBar: TStatusBar;

    // Event Handler - TztHauptDlg
    procedure FormShow(Sender: TObject);
    procedure UhrzeitTimerTick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    // Event Handler - Men� Datei
    procedure DatNeuActionExecute(Sender: TObject);
    procedure DatOeffnenActionExecute(Sender: TObject);
    procedure DatSpeichernActionExecute(Sender: TObject);
    procedure DatSpeichernUnterActionExecute(Sender: TObject);
    procedure DatKopierenActionExecute(Sender: TObject);
    procedure ImportTlnLstActionExecute(Sender: TObject);
    procedure DruckenActionExecute(Sender: TObject);
    procedure MruActionExecute(Sender: TObject);
    procedure BeendenActionExecute(Sender: TObject);
    // Event Handler - Men� Bearbeiten
    procedure AendernActionExecute(Sender: TObject);
    procedure NeuActionExecute(Sender: TObject);
    procedure LoeschenActionExecute(Sender: TObject);
    procedure AbgleichActionExecute(Sender: TObject);
    // Event Handler - Men� Zeitnahme
    procedure StoppActionExecute(Sender: TObject);
    procedure StartActionExecute(Sender: TObject);
    procedure ZeitnahmeActionExecute(Sender: TObject);
    procedure ErfassenBtnClick(Sender: TObject);
    procedure MausSperrenActionExecute(Sender: TObject);
    // Event Handler - Men� Ansicht
    procedure SpalteTlnActionExecute(Sender: TObject);
    procedure SpalteZahlActionExecute(Sender: TObject);
    procedure ShowTlnLstActionExecute(Sender: TObject);
    procedure ZeitAufActionExecute(Sender: TObject);
    procedure ZeitAbActionExecute(Sender: TObject);
    procedure SnrAufActionExecute(Sender: TObject);
    procedure SnrAbActionExecute(Sender: TObject);
    procedure KleinerActionExecute(Sender: TObject);
    procedure GroesserActionExecute(Sender: TObject);
    procedure ZoomBreitActionExecute(Sender: TObject);
    procedure ZoomGanzActionExecute(Sender: TObject);
    // Event Handler - Men� Extras
    procedure UpdateActionExecute(Sender: TObject);
    procedure OptionenActionExecute(Sender: TObject);
    // Event Handler - Men� Hilfe
    procedure OnlineHilfeActionExecute(Sender: TObject);
    procedure ContextHilfeActionExecute(Sender: TObject);
    procedure TrzImWebActionExecute(Sender: TObject);
    procedure InfoActionExecute(Sender: TObject);
    // Event Handler - Edit
    procedure SnrRfidEditChange(Sender: TObject);
    procedure SnrRfidEditClick(Sender: TObject);
    procedure SnrRfidEditKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
    procedure SnrRfidEditMouseActivate(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
                                   X, Y, HitTest: Integer; var MouseActivate: TMouseActivate);
    procedure ZeitDummyEditMouseActivate(Sender:TObject; Button:TMouseButton; Shift:TShiftState;
                                         X, Y, HitTest: Integer; var MouseActivate: TMouseActivate);
    procedure ZeitEditMouseActivate(Sender:TObject; Button:TMouseButton; Shift:TShiftState;
                                    X, Y, HitTest: Integer; var MouseActivate: TMouseActivate);
    procedure SnrRfidEditMouseWheel(Sender: TObject; Shift: TShiftState;
                                WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure GridSnrRfidEditMouseWheel(Sender: TObject; Shift: TShiftState;
                                     WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure GridZeitEditMouseWheel(Sender: TObject; Shift: TShiftState;
                                     WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure GridSnrRfidEditChange(Sender: TObject);
    // Event Handler - TztGrid
    procedure TztGridSelectCell(Sender:TObject;ACol,ARow:Integer;var CanSelect:Boolean);
    function  TztGridSnrText(Item:Pointer): String;
    function  TztGridSnrAnzahl(Item:Pointer;SnrStr:String): String;
    function  TztGridSnrName(Item:Pointer;SnrStr:String): String;
    procedure TztGridGetColText(Sender:TTriaGrid;Item:Pointer;ACol:Integer;var Value:string);
    procedure TztGridKeyPress(Sender: TObject; var Key: Char);
    procedure TztGridMouseDown(Sender:TObject;Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
    procedure TztGridMouseUp(Sender:TObject;Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
    procedure TztGridDblClick(Sender: TObject);
    procedure TztGridDrawCell(Sender:TObject;ACol,ARow:Integer;Rect:TRect;State:TGridDrawState);
    procedure TztGridPaint(Sender: TObject);

  private

    FStopPaint,
    FPaintWartend,
    Updating,
    DisableButtons : Boolean;
    RahmenBreite,
    RahmenHoehe,
    Rand,
    NumFontSize,
    AlfFontSize,
    AlfTextHoehe,
    NumTextHoehe,
    EditHoehe,
    ColEditHoehe,
    ButtonHoehe,
    AlfFontSizeAlt,
    NumFontSizeAlt : Integer;
    StatusFontSizeAlt : Integer;
    FMruListe         : TMruListe;
    FAutoSpeichernInterval : DWord; // in msek
    TastaturHook : HHOOK;
    function  EingabeOK: Boolean;
    procedure SetzeNumFonts;
    procedure SetzeFontSize(NumFontSizeNeu:Integer);
    procedure SetzeFontSizeMax(ARect:TRect);
    function  MinBreite: Integer;
    function  GridBreite: Integer;
    function  ButtonBreite: Integer;
    function  TztColBreite(ACol:Integer): Integer;
    function  GesamtBreite: Integer;
    function  GesamtHoehe: Integer;
    procedure SetAutoSpeichernInterval(Zeit:DWord);
    procedure CommandHeader;
    procedure SetzeFocus;
    procedure CommandTrailer;
    procedure CMDialogKey(Var Msg: TWMKey); message CM_DIALOGKEY;
    function  GetColText(ACol,ARow: Integer): String;
    function  GetCol(Spalte:TTztSpalte): Integer;
    procedure UpdateNameEdit;
    procedure UpdateZahlEdit;

  protected

    procedure SetStopPaint(StopNeu:Boolean);
    procedure AlignControls(AControl:TControl; var ARect:TRect); override;
    function  CustomAlignInsertBefore(C1, C2: TControl): Boolean; override;
    procedure CustomAlignPosition(Control: TControl;
                            var NewLeft,NewTop,NewWidth,NewHeight: Integer;
                            var AlignRect:TRect; AlignInfo:TAlignInfo); override;

  public
    NumFontName,
    AlfFontName : String;
    NumFontSizeMin,
    AlfFontSizeDefault,
    MouseX, MouseY,
    StartUhrZeit,
    EditZeit,
    UhrZeitAktuell,
    UhrZeitAktGelistet,
    UhrZeitAktGespeichert : Integer;
    SpalteTlnAlt,
    SpalteZahlAlt,
    MausFixAlt,
    SnrNameListeAltNull   : Boolean;
    ZeitFormatAlt         : TZeitFormat;
    TrennZeichenAlt       : String;
    RfidModusAlt          : Boolean;
    RfidZeichenAlt        : Integer;
    RfidHexAlt            : Boolean;

    constructor Create(AOwner: TComponent); override;
    procedure   IdleEventHandler(Sender:TObject; var Done:Boolean);
    procedure   MausFixieren;
    procedure   AppActivate(Sender:TObject);
    procedure   AppDeactivate(Sender: TObject);
    destructor  Destroy; override;
    procedure   WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure   Repaint; override;
    function    UhrZeit: Integer;
    procedure   SetzeTimerModus(ModusNeu:TTimerModus);
    procedure   SetzeButtons;
    function    ResetEditierMode: Boolean;
    procedure   SetzeEditierMode(ACol,ARow:Integer);
    procedure   UpdateStatusBar;
    function    GetSortMode: TSortMode;
    procedure   SetSortMode(SM:TSortMode);
    procedure   UpdateCaption;
    procedure   UpdateLayout;
    property    MruListe: TMruListe read FMruListe;
    property    StopPaint : Boolean read FStopPaint write SetStopPaint;
    property    AutoSpeichernInterval: DWord read FAutoSpeichernInterval write SetAutoSpeichernInterval;
  end;

var
  TztHauptDlg         : TTztHauptDlg;
  TimerTickDisabled   : Boolean;
  AutoUpdateAktiv     : Boolean;
  AutoSpeichernActive : Boolean;
  mHHelp              : THookHelpSystem;
  HelpFenster         : TWinControl;

implementation

uses TztDat,TztConfig,TztOptDlg,TztDruckDlg,TztHistory,TztUpdDlg,TztAbglDlg,TztStrtLst;

{$R *.dfm}

//******************************************************************************
function TastaturHookProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
//******************************************************************************
// Local Keyboard Hook um Taste F5 abzufangen. Tastendruck und Taste-Simulation
// funktionieren auch bei ge�ffneten Dialoge
(*
lParam:
0-15: key repeat count
16-23: Scan code
24: extended key flag
25-28: reserved
29: Context Code
30: previous key-state flag
    Indicates whether the key that generated the keystroke message was previously
    up or down. It is 1 if the key was previously down and 0 if the key was previously up.
    You can use this flag to identify keystroke messages generated by the keyboard's
    automatic repeat feature. This flag is set to 1 for WM_KEYDOWN and WM_SYSKEYDOWN
    keystroke messages generated by the automatic repeat feature.
    It is always set to 0 for WM_KEYUP and WM_SYSKEYUP messages.
31: transition state flag
    Indicates whether pressing a key or releasing a key generated the keystroke message.
    This flag is always set to 0 for WM_KEYDOWN and WM_SYSKEYDOWN messages;
    it is always set to 1 for WM_KEYUP and WM_SYSKEYUP messages.
*)
begin
  if (nCode = HC_ACTION) and (wParam = vk_F5) then // Taste F5 abfangen
  begin
    if lparam and $80000000 = 0 then // KeyDown
      TztHauptDlg.ZeitnahmeActionExecute(nil);
    Result := 1; // weitere Bearbeitung F5 blockieren
  end else
    Result := CallNextHookEx(TztHauptDlg.TastaturHook, ncode, wParam, lParam);
end;


// f�r Help Context Popup

//******************************************************************************
procedure F1HelpEvent(ContextHelpID:LongInt; x,y:Integer);
//******************************************************************************

// Alle 'Whats This' und F1 Help_ContextPopup WinHelp-Ereignisse werden
// hier ankommen
var hhpopup: HH.THHPopup;
begin
  with hhpopup do
  begin
    // Gr��e dieser Struktur
    cbStruct := SizeOf(hhpopup);
    // Instanz-Handle f�r String-Ressource
    hinst := 0;
    // Enth�lt 0, eine Ressourcen-ID o dre eine Topic-ID in einer Textdatei
    idString := ContextHelpID;
    // Enth�lt den Text, der angezeigt werden soll, wenn idString 0 ist
    pszText := nil;
    // top center (in Pixeln) des Popup-Fensters
    pt := Point(x,y);
    // Textfarbe, verwende -1 f�r Standard; RGB-Wert z.B. rot: $000000FF
    clrForeground := COLORREF(-1);
    // Hintergrundfarbe, verwende -1 f�r Stanndard, sonst RGB-Wert
    clrBackground := COLORREF(-1);
    // Anzahl an Leerzeichen zwischen Fensterrand und Text, -1 f�r jeden
    // Teil zum ignorieren
    rcMargins := Rect(-1,-1,-1,-1);
    // Schrift: facename, point size, char set, BOLD ITALIC UNDERLINE
    pszFont := '';
  end;
  HtmlHelp({TztHauptDlg}HelpFenster.Handle,
           PChar(ExtractFilePath(ParamStr(0))+'TriaZeit.chm::/TriaZeit.txt'),
           HH_DISPLAY_TEXT_POPUP, DWORD(@hhpopup));
end;


//******************************************************************************
// Public Methoden
//******************************************************************************

//******************************************************************************
constructor TTztHauptDlg.Create(AOwner: TComponent);
//******************************************************************************
var chmFile: string;
begin
  inherited Create(AOwner); // hier wird  SetzeFontSize bereits aufgerufen

  UhrZeitTimer.Enabled  := false;
  UhrzeitTimer.Interval := cnTrzTimerInterval;  // 5 mSek.
  TimerTickDisabled     := true;

  // HTML-Help
  chmFile := ExtractFilePath(Paramstr(0))+'TriaZeit.chm';
  mHHelp  := nil;

  // pr�fen ob Hilfe-Datei vorhanden ist
  if not SysUtils.FileExists(chmFile) then
  begin
    HelpDateiVerfuegbar := false;
    OnlineHilfeAction.Enabled := false;
    ContextHilfeAction.Enabled := false;
  end else
    HelpDateiVerfuegbar := true;

  (*HH 1.2 oder h�her Versionskontrolle*)
  if (hh.HHCtrlHandle = 0)
     or (hh_funcs._hhMajVer < 4)
     or ((hh_funcs._hhMajVer = 4) and (hh_funcs._hhMinVer < 73)) then
    TriaMessage('Microsoft HTML Help 1.2 oder h�her ist erforderlich.',
                 mtInformation,[mbOk]);

  {Hook - verwendet HH_funcs.pas}
  mhHelp := hh_funcs.THookHelpSystem.Create(chmFile,'',htHHAPI);
  mHHelp.HelpCallback2 := F1HelpEvent;
  HelpContext := 0{100};  //damit kein Popup bei Elementen ohne ContextID (=0)

  // allgemein
  AutoUpdateAktiv       := false;
  AutoSpeichernActive   := false;
  DisableButtons        := false;
  Position              := poScreenCenter; // wird in TriaConfig �berschrieben
  Application.Title     := cnTrzProg;
  ProgVersion           := TVersion.Create(cnVersionsJahr,cnVersionsNummer);
  HelpFenster           := Self;
  ZeitAufAction.Checked := true;
  ZeitAbAction.Checked  := false;
  SnrAufAction.Checked  := false;
  SnrAbAction.Checked   := false;
  TztDatName            := cnTztDatNeu; // wird in DateiNeu expanded
  TztDatGeladen         := false;
  UpdateCaption;
  Updating              := false;
  FStopPaint            := false;
  FPaintWartend         := false;
  EditZeit              := 0;
  UhrZeitAktuell        := -1;
  UhrZeitAktGelistet    := -1;
  UhrZeitAktGespeichert := -1;
  BorderIcons           := BorderIcons + [biHelp]; // f�r Popup Help

  // in ObjectInspektor gesetzt
  //SnrRfidEdit.TabOrder      := 0;
  //TztGrid.TabOrder      := 1;
  //ErfassenBtn.TabOrder  := 2;
  //TrennPanel.TabOrder   := 3;
  //ZeitEdit.TabOrder     := 4;
  //GridSnrRfidEdit.TabOrder  := 5;
  //GridZeitEdit.TabOrder := 6;
  //AendBtn.TabOrder      := 7;
  //NeuBtn.TabOrder       := 8;
  //LoeschBtn.TabOrder    := 9;

  // in ObjectInspektor gesetzt
  //SnrRfidEdit.TabStop      := false;
  //ZeiDummyEdit.TabStop := false;
  //ZeitEdit.TabStop     := false;
  //ErfassenBTn.TabStop  := false;
  //TztGrid.TabStop      := true;
  //AendBtn.TabStop      := false;
  //NeuBtn.TabStop       := false;
  //LoeschBtn.TabStop    := false;
  //GridSnrRfidEdit.TabStop  := true;
  //GridZeitEdit.TabStop := true;
  //TrennPanel.TabStop   := false;

  // in ObjectInspector gesetzt
  //SnrRfidEdit.Align      := alCustom;
  //ZeitDummyEdit.Alin := alCustom;
  //ZeitEdit.Align     := alCustom;
  //ErfassenBtn.Align  := alCustom;
  //AendBtn.Align      := alCustom;
  //NeuBtn.Align       := alCustom;
  //LoeschBtn.Align    := alCustom;
  //TztGrid.Align      := alCustom;
  //GridSnrRfidEdit.Align  := alCustom;
  //GridZeitEdit.Align := alCustom;
  //StatusBar.Align    := alCustom;
  //SnrRfidLabel.Align     := alCustom;
  //ZeitLabel.Align    := alCustom;
  //TrennPanel.Align   := alCustom;}

  // VistaFix: Fonts
  Font.Name          := 'Segoe UI';
  Font.Size          := 9;
  VistaFix.SetzeFonts(Self.Font);
  VistaFix.SetzeFonts(ActionMainMenuBar.Font);
  VistaFix.SetzeFonts(ActionToolBar.Font);
  VistaFix.SetzeFonts(StatusBar.Font);

  AlfFontName        := Font.Name;
  AlfFontSizeDefault := Font.Size;
  AlfFontSize        := AlfFontSizeDefault;

  with TztGrid do
  begin
    FixedCols := 0;
    FixedRows := 1; // vor TztGrid.Init
    Options   := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goTabs,
                  goThumbTracking];
         {goFixedHorzLine:     Draw horizontal grid lines in the fixed cell area.
          goFixedVertLine:     Draw veritical grid lines in the fixed cell area.
          goHorzLine:          Draw horizontal lines between cells.
          goVertLine:          Draw vertical lines between cells.
          goRangeSelect:       Allow a range of cells to be selected.
          goDrawFocusSelected: Draw the focused cell in the selected color.
          goRowSizing:         Allows rows to be individually resized.
          goColSizing:         Allows columns to be individually resized.
          goRowMoving:         Allows rows to be moved with the mouse
          goColMoving:         Allows columns to be moved with the mouse.
          goEditing:           Places an edit control over the focused cell.
          goAlwaysShowEditor:  Always shows the editor in place instead of
                               waiting for a keypress or F2 to display it.
          goTabs:              Enables the tabbing between columns.
          goRowSelect:         Selection and movement is done a row at a time.
          goThumbTracking      Das Gitterbild wird aktualisiert, w�hrend der Benutzer
                               das Bildlauffeld der Bildlaufleiste zieht. Wenn
                               goThumbTracking nicht enthalten ist, wird die
                               Darstellung des Gitters erst aktualisiert, wenn
                               der Benutzer das Bildlauffeld an der neuen Position
                               losl�sst.
          goFixedColClick      Das Gitter unterst�tzt das Anklicken von fixierten
                               Spalten. goFixedColClick ist n�tzlich, wenn das
                               Gitter-Steuerelement fixierte Spalten enth�lt.
          goFixedRowClick      Das Gitter unterst�tzt das Anklicken von fixierten
                               Zeilen. goFixedRowClick ist n�tzlich, wenn das
                               Gitter-Steuerelement fixierte Zeilen enth�lt.
          goFixedHotTrack      Das Gitter unterst�tzt das Hervorheben von fixierten
                               Spalten oder Zeilen, wenn der Mauszeiger dar�ber
                               bewegt wird. goFixedHotTrack weist das Gitter an,
                               die fixierten Zellen hervorzuheben, wenn der
                               Mauszeiger dar�ber bewegt wird. }

    ColCount      := 3;  // 3 weil RndCheckAnzeige = false
    ColAlign[0]   := taCenter;        // Nr
    ColAlign[1]   := taRightJustify;  // Snr
    ColAlign[2]   := taCenter;        // Zeit
    ColEdits[1]   := GridSnrRfidEdit;
    ColEdits[2]   := GridZeitEdit;
    Color         := chGridColor;

    Font.Name          := AlfFontName;
    Font.Color         := clWindowText;
    Canvas.Font.Color  := clWindowText;
    Canvas.Brush.Color := clWindowText;
    Canvas.Pen.Color   := clWindowText;
    ColEditFontColor   := clWindowText;
  end;

  SetzeNumFonts;
  Rand := 24;
  SetzeFontSize(NumFontSizeMin); // auch AlfFontSize,NumFontSize gesetzt

  AlfFontSizeAlt            := 0; // UpdateLayout erzwingen
  NumFontSizeAlt            := 0;
  TztGrid.Font.Size         := AlfFontSize;
  StatusBar.Font.Size       := AlfFontSize;
  MausFixEdit.Font.Size     := AlfFontSize;
  StatusFontSizeAlt         := 0;
  SnrRfidEdit.Font.Size     := NumFontSize;
  ZeitEdit.Font.Size        := NumFontSize;
  GridSnrRfidEdit.Font.Size := NumFontSize;
  GridZeitEdit.Font.Size    := NumFontSize;
  NameEdit.Font.Size        := NumFontSize;
  ZahlEdit.Font.Size        := NumFontSize;

  RahmenBreite  := Width - ClientWidth;
  RahmenHoehe   := Height - ClientHeight;
  ZeitFormat    := zfSek; // Anfangswert
  DecTrennZeichen := opDecTrennZeichen;
  SpalteZahl      := false;
  RndCheckZahl    := 1;
  RndCheckColl    := TIntSortCollection.Create(TztHauptDlg);
  SpalteZahlAction.Checked := false;
  SpalteTln       := false;
  KopierDatei     := '';
  StartlisteDateiName := '';
  SpalteTlnAction.Checked := false;
  ZeitEdit.InitEditMask;
  GridZeitEdit.InitEditMask;

  Constraints.MinWidth  := MinBreite;   // f�r Mindest Fontsize
  Constraints.MinHeight := GesamtHoehe; // f�r Mindest Fontsize
  Constraints.MaxHeight := 0; // keine Einschr�nkung
  Constraints.MaxWidth  := 0; // keine Einschr�nkung
  SetBounds(Left,Top,Constraints.MinWidth,Constraints.MinHeight+100); // Align

  GridSnrRfidEdit.BorderStyle := bsNone;
  GridZeitEdit.BorderStyle    := bsNone;
  GridSnrRfidEdit.Color       := clWindow;
  GridZeitEdit.Color          := clWindow;

  ErfassenBtn.ParentFont := true;
  AendBtn.ParentFont     := true;
  NeuBtn.ParentFont      := true;
  LoeschBtn.ParentFont   := true;

  AutoUpdate       := opAutoUpdate;
  UpdateDatum      := opUpdateDatum;
  MruDateiOeffnen  := opMruDateiOeffnenTrz;
  BackupErstellen  := opBackUpErstellenTrz;
  ZeitGleich       := zgGleichOk;  // Zeitgleichheiten bei Erfassung zulassen
  BeepSignal       := opBeepSignal;

  MausSperrenAction.Checked := false; // immer zun�chst ausschalten, ist immer der Fall
  MausFixEdit.Visible       := false;

  TztColl := TTztColl.Create(nil,TTztObj);
  TztColl.SortMode := smTztZeitAuf;
  TztColl.SnrSortList := TSnrSortList.Create;
  TztColl.AddItem(TTztObj.Create(nil,TztColl,oaNoAdd)); // leeres Item am Ende
  TztGrid.Init(TztColl,smSortiert,ssVertical,nil);  //in FormShow

  TztBufColl := TTztColl.Create(nil,TTztObj);
  TztBufColl.SortMode := smNichtSortiert; // BufColl wird nicht sortiert
  TztBufColl.SnrSortList := nil;

  SnrNameListe := TStringList.Create;
  with SnrNameListe do
  begin
    CaseSensitive := false;
    Duplicates    := dupIgnore;
    OwnsObjects   := true;
    Sorted        := true;
  end;

  TztGrid.Defaultdrawing := false;

  MouseX := -1;
  MouseY := -1;

  TztDatModified := false;
  // in IdleEventHandler wird anschlie�end Datei erstellt/ge�ffnet
  // nur bei g�ltiger Datei wird Programm weiter ausgef�hrt
  CursorAlt := Screen.Cursor;
  FMruListe := TMruListe.Create(Self,ActionMainMenuBar);
  SetupGestartet := false;
  ActionMainMenuBar.PersistentHotKeys := true;

  FAutoSpeichernInterval  := opAutoSpeichernTrz; // 10x 0,1 Min
  AutoSpeichernRequest    := false;
  ZeitAktuell             := 0;
  ZeitDatGespeichert      := 0;

  // TimerModus UhrZeit
  ErfassenBtn.Caption := '&Zeitnahme';
  ErfassenBtn.HelpContext := 103;
  ErfassenBtn.Hint := 'Startnummer und Zeit �bernehmen (F5)';
  StartAction.Enabled := false;
  ZeitnahmeAction.Enabled := true;
  StoppAction.Enabled := false;
  StartUhrZeit := -1;
  SnrRfidEdit.ReadOnly  := false;
  ZeitEdit.ReadOnly := true;
  SetzeButtons;

  ZeitDummyEdit.Text := '';
  ZeitEdit.Text      := UhrZeitStr(UhrZeit);
  SnrRfidEdit.Text   := '';
  UpdateNameEdit;
  UpdateZahlEdit;
  MenueCommandActive   := false;

  ZeitFormatAlt        := zfSek;
  TrennZeichenAlt      := ''; // wird in UpdateLayout gesetzt
  SpalteTlnAlt         := false;
  SpalteZahlAlt        := false;
  MausFixAlt           := false;
  SnrNameListeAltNull  := true;
  RfidModus            := false;
  RfidZeichen          := cnRfidZeichenDefault; //=10, erlaubt 2-24
  RfidHex              := true;
  RfidModusAlt         := RfidModus;
  RfidZeichenAlt       := RfidZeichen;
  RfidHexAlt           := RfidHex;

  LadeKonfiguration; // FormShow Event

  Application.OnActivate   := AppActivate;
  Application.OnDeactivate := AppDeactivate;
  Application.OnIdle       := IdleEventHandler;  //Am Ende, damit Handler nicht zu fr�h aufgerufen wird
  UhrZeitTimer.Enabled := true;
  TimerTickDisabled    := false;
  TastaturHook := SetWindowsHookEx(WH_KEYBOARD, @TastaturHookProc, 0, GetCurrentThreadID);

  if not HelpDateiVerfuegbar then
    TriaMessage('Die Hilfe-Datei wurde nicht gefunden:' +#13+ chmFile,
                mtInformation,[mbOk]);
end;

//******************************************************************************
procedure TTztHauptDlg.IdleEventHandler(Sender:TObject; var Done:Boolean);
//******************************************************************************
begin
  // PersistentHotkeys wird bei jedem Men�zugriff zur�ckgesetzt (wieso?)
  // Muss gesetzt bleiben, sonst wird '&' in Dateiname nicht richtig angezeigt.
  if not ActionMainMenuBar.PersistentHotKeys then
    ActionMainMenuBar.PersistentHotKeys := true;
  // nach Click auf ScrollBar bleibt TztGrid focused, auch in EditierMode,
  // hier korrigieren
  if (ActiveControl = TztGrid) and not TztGrid.EditierMode then
    SetzeFocus;
  Done := true;
end;

//******************************************************************************
procedure TTztHauptDlg.MausFixieren;
//******************************************************************************
var R : TRect;
    RandLinks,RandOben : Integer;
begin
  if MausSperrenAction.Checked then
  begin
    RandLinks := (Width - ClientWidth) DIV 2; // Rand links und rechts gleich
    RandOben  := Height - ClientHeight - RandLinks; // Rand unten und seitlich gleich
    R.Left    := Left + RandLinks + ErfassenBtn.Left + ErfassenBtn.Width DIV 2;
    R.Top     := Top + RandOben + ErfassenBtn.Top + ErfassenBtn.Height DIV 2;
    R.Right   := R.Left + 1;
    R.Bottom  := R.Top + 1;
    ClipCursor(@R);
  end else
    ClipCursor(nil);
end;

//******************************************************************************
procedure TTztHauptDlg.AppActivate(Sender: TObject);
//******************************************************************************
// Die Maus-Fixierung f�r Remote-Zeitnahme wiederherstellen
begin
  MausFixieren;
end;

//******************************************************************************
procedure TTztHauptDlg.AppDeactivate(Sender: TObject);
//******************************************************************************
begin
  ClipCursor(nil);
end;

//******************************************************************************
destructor TTztHauptDlg.Destroy;
//******************************************************************************
begin

  if TastaturHook <> 0 then
  begin
    UnhookWindowsHookEx(TastaturHook);
    TastaturHook := 0;
  end;

  // f�r HTML-Help
  HHCloseAll;  // Schlie�t alle Hilfe-Fenster
  if Assigned(mhHelp) then mHHelp.Free;

  SnrNameListe.Free;
  TztColl.Free;
  TztBufColl.Free;
  RndCheckColl.Free;
  Screen.Cursor := CursorAlt;

  inherited Destroy;
end;

//******************************************************************************
procedure TTztHauptDlg.WMSize(var Msg: TWMSize);
//******************************************************************************
// Msg.SizeType: SIZE_MAXIMIZED, SIZE_MINIMIZED, SIZE_RESTORED, SIZE_MAXHIDE, SIZE_MAXSHOW
begin
  if Assigned(ZoomGanzAction) then
    if Msg.Sizetype = SIZE_MAXIMIZED then
      ZoomGanzAction.Checked := true
    else
      ZoomGanzAction.Checked := false;
  inherited;
end;

//******************************************************************************
procedure TTztHauptDlg.Repaint;
//******************************************************************************
begin
  if FStopPaint then FPaintWartend := true
  else
  begin
    FPaintWartend := false;
    inherited Repaint;
  end;
end;

//******************************************************************************
function TTztHauptDlg.UhrZeit: Integer;
//******************************************************************************
// ab 3.4 in 1/100 Sek
var
  DateTime : TDateTime;
  hh,mm,ss,ddd,d : Word;  // ddd = msec, d = 1/10 sec
begin
  DateTime := Time; // Aktuelles Datum und Uhrzeit
  DecodeTime(DateTime,hh,mm,ss,ddd);
  case ZeitFormat of
    zfHundertstel : d := ddd DIV 10;
    zfZehntel     : d := (ddd DIV 100) * 10;
    else            d := 0;
  end;
  Result := d + 100*ss + 6000*mm + 360000*hh;
end;

//******************************************************************************
procedure TTztHauptDlg.SetzeTimerModus(ModusNeu:TTimerModus);
//******************************************************************************
// ZeitEdit wird in UhrZeitTimerTick gesetzt
begin
  TimerTickDisabled := true; // komplett ausf�hren
  UhrZeitAktuell := -1; // damit Zeit sofort gesetzt wird
  TimerModus := ModusNeu;
  case TimerModus of
    zmUhrzeit:
    begin
      ErfassenBtn.Caption := '&Zeitnahme';
      ErfassenBtn.HelpContext := 103;
      if RfidModus then
        ErfassenBtn.Hint := 'RFID-Code und Zeit �bernehmen (F5)'
      else
        ErfassenBtn.Hint := 'Startnummer und Zeit �bernehmen (F5)';
      StartAction.Enabled := false;
      ZeitnahmeAction.Enabled := true;
      StoppAction.Enabled := false;
      StartUhrZeit := -1;
      SnrRfidEdit.ReadOnly  := false;
      ZeitEdit.ReadOnly := true;
    end;
    zmStop:
    begin
      ErfassenBtn.Caption := '&Start';
      ErfassenBtn.HelpContext := 108;
      ErfassenBtn.Hint := 'Startzeit �bernehmen und Stoppuhr starten (F3)';
      StartAction.Enabled := true;
      ZeitnahmeAction.Enabled := false;
      StoppAction.Enabled := false;
      StartUhrZeit := -1;
      SnrRfidEdit.Text  := '';
      ZeitEdit.Text := UhrZeitStr(0);
      SnrRfidEdit.ReadOnly  := true;
      ZeitEdit.ReadOnly := false;
    end;
    zmStart: // �bergangszustand nach Start-Button, in UhrZeitTimerTick zmRun gesetzt
    begin
      ErfassenBtn.Caption := '&Zeitnahme';
      ErfassenBtn.HelpContext := 103;
      if RfidModus then
        ErfassenBtn.Hint := 'RFID-Code und Zeit �bernehmen (F5)'
      else
        ErfassenBtn.Hint := 'Startnummer und Zeit �bernehmen (F5)';
      StartAction.Enabled := false;
      ZeitnahmeAction.Enabled := true;
      StoppAction.Enabled := true;
      SnrRfidEdit.ReadOnly  := false;
      ZeitEdit.ReadOnly := true;
      // StartUhrZeit in UhrZeitTimerTick gesetzt
    end;
    zmRun: // TztConfig, UhrZeitTimerTick
    begin
      ErfassenBtn.Caption := '&Zeitnahme';
      ErfassenBtn.HelpContext := 103;
      if RfidModus then
        ErfassenBtn.Hint := 'RFID-Code und Zeit �bernehmen (F5)'
      else
        ErfassenBtn.Hint := 'Startnummer und Zeit �bernehmen (F5)';
      StartAction.Enabled := false;
      ZeitnahmeAction.Enabled := true;
      StoppAction.Enabled := true;
      SnrRfidEdit.ReadOnly  := false;
      ZeitEdit.ReadOnly := true;
      // StartUhrZeit bleibt unver�ndert
    end;
  end;
  TimerTickDisabled := false;
end;

//******************************************************************************
procedure TTztHauptDlg.SetzeButtons;
//******************************************************************************
begin
  if TztGrid.EditierMode then
  begin
    ErfassenBtn.Default := false;
    AendBtn.Default     := true;
  end else // Zeitnahmne, SnrRfidEdit focused
  begin
    ErfassenBtn.Default := true;
    AendBtn.Default     := false;
  end;

  if (TztBufColl <> nil) and (TztBufColl.Count < cnBufferMax) then
    ErfassenBtn.Enabled := true
  else
    ErfassenBtn.Enabled := false;

  if (TztBufColl <> nil) and (TztBufColl.Count > 0) or // noch nicht alle Eintr�ge in TztColl
      AutoUpdateAktiv or AutoSpeichernActive then
  begin
    // Datei
    DatNeuAction.Enabled            := false;
    DatOeffnenAction.Enabled        := false;
    DatSpeichernAction.Enabled      := false;
    DatSpeichernUnterAction.Enabled := false;
    DatKopierenAction.Enabled       := false;
    AbgleichAction.Enabled          := false;
    DruckenAction.Enabled           := false;
    MruAction1.Enabled              := false;
    MruAction2.Enabled              := false;
    MruAction3.Enabled              := false;
    MruAction4.Enabled              := false;
    // Bearbeiten-editieren
    AendernAction.Enabled           := false;
    NeuAction.Enabled               := false;
    LoeschenAction.Enabled          := false;
    // Extras
    UpdateAction.Enabled            := false;
    OptionenAction.Enabled          := false;
  end else
  begin
    // Datei
    DatNeuAction.Enabled            := true;
    DatOeffnenAction.Enabled        := true;
    if TztDatModified then DatSpeichernAction.Enabled := true
                      else DatSpeichernAction.Enabled := false;
    DatSpeichernUnterAction.Enabled := true;
    DatKopierenAction.Enabled       := true;
    if RfidModus then AbgleichAction.Enabled := false
                 else AbgleichAction.Enabled := true;
    DruckenAction.Enabled           := true;
    MruAction1.Enabled              := true;
    MruAction2.Enabled              := true;
    MruAction3.Enabled              := true;
    MruAction4.Enabled              := true;
    // Bearbeiten-editieren
    AendernAction.Enabled           := true;
    NeuAction.Enabled               := true;
    LoeschenAction.Enabled          := true;
    // Extras
    UpdateAction.Enabled            := true;
    OptionenAction.Enabled          := true;
  end;

  if WindowState = wsMaximized then
  begin
    GroesserAction.Enabled  := false;
    KleinerAction.Enabled   := false;
    ZoomBreitAction.Enabled := false;
  end else
  begin
    GroesserAction.Enabled  := true;
    KleinerAction.Enabled   := true;
    ZoomBreitAction.Enabled := true;
  end;

end;

//******************************************************************************
function TTztHauptDlg.MinBreite: Integer;
//******************************************************************************
// f�r Constraints.MinWidth, berechnet mit min. Fontsize
var NumFontSizeBuf: Integer;
begin
  NumFontSizeBuf := NumFontSize;
  SetzeFontSize(NumFontSizeMin);
  Result := GesamtBreite;
  SetzeFontSize(NumFontSizeBuf);
end;

//******************************************************************************
function TTztHauptDlg.ResetEditierMode: Boolean;
//******************************************************************************
var i : Integer;
    LeerZeile : Boolean;
begin
  Result := true;
  with TztGrid do
  begin
    if EditierMode then
    begin
      if ColEditMode then
        TztGridSelectCell(TztGrid,-1,-1,Result); // ColEdit := false
      if Result then
        EditierMode := false;
    end;
    if Result then
    begin
      // eine und nur eine LeerZeile am Ende
      LeerZeile := false;
      if TztColl.Count>0 then
        for i := TztColl.Count-1 downto 0 do
          if TztColl[i].InitWert then
            if not LeerZeile then
              LeerZeile := true
            else
              TztColl.ClearIndex(i); // �berz�hlige Leerzeilen l�schen
      if not LeerZeile then
        TztColl.AddItem(TTztObj.Create(nil,TztColl,oaNoAdd)); // leeres Item am Ende

      CollectionUpdate;
      SetSortMode(GetSortMode);
      BringToFront;
      Invalidate;
      Refresh;
      SetzeButtons;
    end;
    SetzeFocus;
  end;
end;

//******************************************************************************
procedure TTztHauptDlg.SetzeEditierMode(ACol,ARow:Integer);
//******************************************************************************
// von: AendernActionExecute,NeuActionExecute,TztGridMouseDown,SnrRfidEditKeyDown(VK_TAB)
// mit TAB oder Button immer Col=1 und aktueller Row selektieren,
// mit MouseDown Col,Row = ACol,ARow
var Buf : Boolean;
begin
  with TztGrid do
  begin
    Buf := EnableOnClick;
    if not EditierMode then
    try
      EnableOnClick := false;
      EditierMode := true;
      SetSortMode(smFestSortiert);
      BringToFront;
      Invalidate; // ganze Zeile mit Rahmen neu zeichnen
      if ACol < 1 then ACol := Max(1,Col)
      else
      if ACol > 2 then ACol := Min(2,Col);
      if ARow < 1 then ARow := Max(1,Row);
      FocusZelle(ACol,ARow); // TztGridSelectCell immer ausgef�hrt - TztGrid fokussiert
      Refresh;
      SetzeButtons;
    finally
      EnableOnClick := Buf;
    end;
    SetzeFocus;
  end;
end;

//******************************************************************************
procedure TTztHauptDlg.UpdateStatusBar;
//******************************************************************************
var S : String;
begin
  S := ' Eintr�ge:  ';
  if not Assigned(TztGrid) then Exit;
  if (TztGrid.ItemCount>0) and TTztObj(TztGrid[TztGrid.ItemCount-1]).InitWert then
    S := S + IntToStr(TztGrid.ItemCount-1)
  else
    S := S + IntToStr(TztGrid.ItemCount);
  if Assigned(SnrNameListe) and (SnrNameListe.Count > 0) then
    S := S + ',   Startliste:  '+IntToStr(SnrNameListe.Count);

  if (StatusBar.Panels[0].Text <> S) or
     (StatusFontSizeAlt <> StatusBar.Font.Size) then // flackern vermeiden
  begin
    StatusFontSizeAlt := StatusBar.Font.Size;
    StatusBar.Panels[0].Text  := ''; // zun�chst l�schen
    StatusBar.Panels[0].Text  := S;
  end;
end;

//******************************************************************************
function TTztHauptDlg.GetSortMode: TSortMode;
//******************************************************************************
// SortMode nach R�ckkehr aus EditierMode von Ansicht-Items ableiten.
// Diese bleiben in smFestSortiert-Modus erhalten
begin
  if ZeitAbAction.Checked then Result := smTztZeitAb
  else
  if SnrAufAction.Checked then Result := smTztSnrAuf
  else
  if SnrAbAction.Checked then Result := smTztSnrAb
  else Result := smTztZeitAuf;
end;

//******************************************************************************
procedure TTztHauptDlg.SetSortMode(SM:TSortMode);
//******************************************************************************
// smFestSortiert nur in Editmode
var i : Integer;
    Ptr : Pointer;
begin
  Ptr := TztGrid.FocusedItem;
  if SM = smFestSortiert then
  begin
    // Checked-Item bleibt unver�ndert, ben�tigt beim Pfeil-Draw und R�ckkehr
    for i:=0 to TztColl.SortCount-1 do
      TztColl.SortItems[i].FestSortIndex := i;
    TztGrid.Collection.SortMode := smFestSortiert;
  end else
  begin
    ZeitAufAction.Checked := false;
    ZeitAbAction.Checked  := false;
    SnrAufAction.Checked  := false;
    SnrAbAction.Checked   := false;
    case SM of
      smTztZeitAuf : ZeitAufAction.Checked := true;
      smTztZeitAb  : ZeitAbAction.Checked  := true;
      smTztSnrAuf  : SnrAufAction.Checked  := true;
      smTztSnrAb   : SnrAbAction.Checked   := true;
      else ;
    end;

    TztColl.Sortieren(SM);
    TztGrid.CollectionUpdate;
    TztGrid.Invalidate;
    TztGrid.FocusedItem := Ptr;

    UpdateStatusBar;
  end;
end;

//******************************************************************************
procedure TTztHauptDlg.UpdateCaption;
//******************************************************************************
begin
  Caption := Application.Title;
  if TztDatName <> '' then
    Caption := Caption + '  -  ' + SysUtils.ExtractFileName(TztDatName);
end;

//******************************************************************************
procedure TTztHauptDlg.UpdateLayout;
//******************************************************************************
// Parameter setzen, inkl. Constraints.MinWidth und FontSize
// Gr��e unver�ndert, es sei denn Constraints.MinWidth > aktuelle Breite
var StopPaintAlt   : Boolean;
    ZeitWertBuf, i : Integer;
    ARect : TRect;

  //............................................................................
  function UhrZeitWertBuf(const Zeit:String): Integer;
  begin
    case ZeitFormatAlt of
      zfHundertstel: Result := UhrZeitWert100(Zeit);
      zfZehntel:     Result := UhrZeitWertDec(Zeit);
      else {zfSek}   Result := UhrZeitWertSek(Zeit);
    end;
  end;

//..............................................................................
begin
  if not Self.Visible or // immer ausf�hren w�hrend Create
     (ZeitFormat <> ZeitFormatAlt) or (DecTrennZeichen <> TrennZeichenAlt) or
     (SpalteTln <> SpalteTlnAlt) or (SpalteZahl <> SpalteZahlAlt) or
     (MausSperrenAction.Checked <> MausFixAlt) or
     ((SnrNameListe.Count=0) <> SnrNameListeAltNull) or
     (RfidModus <> RfidModusAlt) or
     (RfidZeichen <> RfidZeichenAlt) or
     (RfidHex <> RfidHexAlt) then
  begin

    StopPaintAlt := StopPaint;
    if not StopPaintAlt then SetStopPaint(true);

    // alle Snr/Rfid am neuen Modus anpassen
    if not Self.Visible or // immer ausf�hren w�hrend Create
       (RfidModus <> RfidModusAlt) or (RfidZeichen <> RfidZeichenAlt) or
       (RfidHex <> RfidHexAlt) then
    begin
      if RfidModus then
      begin
        ImportTlnLstAction.Enabled := false;
        AbgleichAction.Enabled := false;

        SpalteTln := false;
        SpalteTlnAction.Checked := false;
        SpalteTlnAction.Enabled := false;
        SpalteZahl := false;
        SpalteZahlAction.Checked := false;
        SpalteZahlAction.Enabled := false;

        if Assigned(TztStartListe) and TztStartListe.Visible then
          TztStartListe.Hide;
        if Assigned(SnrNameListe) then
          SnrNameListe.Clear;
        ShowTlnLstAction.Enabled := false;

        if MausSperrenAction.Checked then
        begin
          MausSperrenAction.Checked := false;
          MausFixEdit.Visible       := false;
          ClipCursor(nil);
        end;
        MausSperrenAction.Enabled := false;

        SnrRfidLabel.Caption   := 'RFID-Code';
        SnrRfidEdit.EditMask   := '';
        SnrRfidEdit.MaxLength  := 24; // Eingabe > RfidZeichen zulassen, wird in Tabelle rot angezeigt
        SnrRfidEdit.ZahlFormat := zfKein; // bei RfidHex auch Eingabe von nicht-Hex-werte zulassen
        SnrRfidEdit.Text       := '';
        GridSnrRfidEdit.EditMask   := SnrRfidEdit.EditMask;
        GridSnrRfidEdit.MaxLength  := SnrRfidEdit.MaxLength;
        GridSnrRfidEdit.ZahlFormat := SnrRfidEdit.ZahlFormat;
        GridSnrRfidEdit.Text       := SnrRfidEdit.Text;
      end
      else // Snr-Modus
      begin
        ImportTlnLstAction.Enabled := true;
        SpalteTlnAction.Enabled := true;
        ShowTlnLstAction.Enabled := true;
        SpalteZahlAction.Enabled := true;
        AbgleichAction.Enabled := true;
        MausSperrenAction.Enabled := true;

        SnrRfidLabel.Caption := 'Startnr.';
        SnrRfidEdit.EditMask   := '';
        SnrRfidEdit.MaxLength  := 4;
        SnrRfidEdit.ZahlFormat := zfDez;
        SnrRfidEdit.Text       := '';
        GridSnrRfidEdit.EditMask   := SnrRfidEdit.EditMask;
        GridSnrRfidEdit.MaxLength  := SnrRfidEdit.MaxLength;
        GridSnrRfidEdit.ZahlFormat := SnrRfidEdit.ZahlFormat;
        GridSnrRfidEdit.Text       := SnrRfidEdit.Text;
      end;

      SetzeNumFonts; // nicht proportianale Schriftart f�r RFID-Code
    end;

    // alle Zeiten an neuem Fomat anpassen
    if not Self.Visible or // immer ausf�hren w�hrend Create
       (ZeitFormat <> ZeitFormatAlt) or (DecTrennZeichen <> TrennZeichenAlt) then
    begin
      ZeitWertBuf := UhrZeitWertBuf(ZeitEdit.Text); // altes Format
      ZeitEdit.InitEditMask; // neues Format
      ZeitEdit.Text := UhrZeitStr(ZeitWertBuf); // neues Format
      ZeitWertBuf := UhrZeitWertBuf(GridZeitEdit.Text); // altes Format
      GridZeitEdit.InitEditMask; // neues Format
      GridZeitEdit.Text := UhrZeitStr(ZeitWertBuf); // neues Format
      if TztGrid.ItemCount > 0 then
      begin
        if (TztGrid.ItemCount > 1) or not TTztObj(TztGrid[0]).InitWert then
          TztDatModified := true;
        for i:=0 to TztGrid.ItemCount-1 do
        begin
          ZeitWertBuf := UhrZeitWertBuf(TTztObj(TztGrid[i]).Zeit);// altes Format
          if ZeitWertBuf < 0 then
            TTztObj(TztGrid[i]).Zeit := ZeitInitWert // neues Format
          else
            TTztObj(TztGrid[i]).Zeit := UhrZeitStr(ZeitWertBuf); // neues Format
        end;
      end;
    end;

    // Grid Columns setzen
    if not Self.Visible or // immer ausf�hren w�hrend Create
       (SpalteTln <> SpalteTlnAlt) or (SpalteZahl <> SpalteZahlAlt) or
       ((SnrNameListe.Count=0) <> SnrNameListeAltNull) then
    begin
      SpalteTlnAction.Enabled  := SnrNameListe.Count > 0;
      SpalteTlnAction.Checked  := SpalteTln;
      SpalteZahlAction.Checked := SpalteZahl;
      if SpalteTln and SpalteZahl then
      begin
        TztGrid.ColCount    := 5;
        TztGrid.ColAlign[3] := taCenter;      // Zahl
        TztGrid.ColAlign[4] := taLeftJustify; // Name
        NameLabel.Show;
        NameEdit.Show;
        ZahlLabel.Show;
        ZahlEdit.Show;
      end else
      if SpalteTln then
      begin
        TztGrid.ColCount    := 4;
        TztGrid.ColAlign[3] := taLeftJustify; // Name
        NameLabel.Show;
        NameEdit.Show;
        ZahlLabel.Hide;
        ZahlEdit.Hide;
      end else
      if SpalteZahl then
      begin
        TztGrid.ColCount    := 4;
        TztGrid.ColAlign[3] := taCenter;  // Zahl
        NameLabel.Hide;
        NameEdit.Hide;
        ZahlLabel.Show;
        ZahlEdit.Show;
      end else
      begin
        TztGrid.ColCount := 3;
        NameLabel.Hide;
        NameEdit.Hide;
        ZahlLabel.Hide;
        ZahlEdit.Hide;
      end;
    end;

    if MausSperrenAction.Checked <> MausFixAlt then
      if MausSperrenAction.Checked then
        MausFixEdit.Show
      else
        MausFixEdit.Hide;

    UpdateNameEdit;
    UpdateZahlEdit;
    if NameEdit.Visible and (Trim(NameEdit.Text)=strSnrUnbekannt) then
      NameEdit.Font.Color := clRed
    else
      NameEdit.Font.Color := clWindowText;
    if ZahlEdit.Visible and (StrToIntDef(ZahlEdit.Text,0)>RndCheckZahl) then
      ZahlEdit.Font.Color := clRed
    else
      ZahlEdit.Font.Color := clWindowText;

    ZeitFormatAlt       := ZeitFormat;
    TrennZeichenAlt     := DecTrennZeichen;
    SpalteZahlAlt       := SpalteZahl;
    SpalteTlnAlt        := SpalteTln;
    MausFixAlt          := MausSperrenAction.Checked;
    SnrNameListeAltNull := SnrNameListe.Count=0;
    RfidModusAlt        := RfidModus;
    RfidZeichenAlt      := RfidZeichen;
    RfidHexAlt          := RfidHex;

    Constraints.MinWidth := MinBreite;
    ARect := ClientRect;
    AlignControls(nil,ARect);

    TztGrid.Invalidate;
    Invalidate;
    if not StopPaintAlt then SetStopPaint(false);
  end;
end;

//******************************************************************************
procedure TTztHauptDlg.SetzeFontSizeMax(ARect:TRect);
//******************************************************************************
// FontSize an neue Fenstergr��e (ARect=ClientRect) anpassen
var BreiteFont,HoeheFont: Integer;
begin
  // zun�chst mit aktuellen Fonts probieren
  BreiteFont := GesamtBreite - RahmenBreite;
  HoeheFont  := GesamtHoehe - RahmenHoehe;
  if (BreiteFont > ARect.Width) or (HoeheFont > ARect.Height) then
  begin
    while ((BreiteFont > ARect.Width) or (HoeheFont > ARect.Height)) and
          (NumFontSize > NumFontSizeMin) do
    begin
      SetzeFontSize(NumFontSize-1);
      BreiteFont := GesamtBreite - RahmenBreite;
      HoeheFont  := GesamtHoehe - RahmenHoehe;
      // letzter Wert von NumFontSizeNeu ist g�ltig
    end
  end else
  if (BreiteFont < ARect.Width) and (HoeheFont < ARect.Height) then
  begin
    // FontSize eventuell zu klein, gr��t m�glicher Wert suchen
    while (BreiteFont <= ARect.Width) and (HoeheFont <= ARect.Height) do
    begin
      SetzeFontSize(NumFontSize+1);
      BreiteFont := GesamtBreite - RahmenBreite;
      HoeheFont  := GesamtHoehe - RahmenHoehe;
    end;
    // vorletzter Wert von NumFontSizeNeu ist g�ltig
    SetzeFontSize(NumFontSize-1);
  end; // else NumFontSize bleibt unver�ndert

  // interne FontSize
  Font.Size                := AlfFontSize;
  TztGrid.Font.Size        := AlfFontSize;
  StatusBar.Font.Size      := AlfFontSize;
  MausFixEdit.Font.Size    := AlfFontSize;
  SnrRfidEdit.Font.Size    := NumFontSize;
  ZeitEdit.Font.Size       := NumFontSize;
  NameEdit.Font.Size       := NumFontSize;
  ZahlEdit.Font.Size       := NumFontSize;
  TztGrid.ColEditFontSize  := NumFontSize;
  TztGrid.Canvas.Font.Size := NumFontSize;
end;

//------------------------------------------------------------------------------
// private Methoden
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
function TTztHauptDlg.EingabeOK: Boolean;
//------------------------------------------------------------------------------
// Bei Enter (AendBtn=default) und Pfeiltasten wird ValidateEdit
// nicht automatisch ausgeff�hrt, deshalb diese Funktion
// Nach Fehlermeldung wird Focus durch ValidateEdit zur�ckgesetzt, damit mit
// ESC-Taste korrigiert werden kann
// ValidateEdit funktioniert nur wenn ge�ndert wurde (Modified=true), nicht bei InitWert
begin
  with TztGrid do
    if ColEditMode then
      case Col of
        1 : Result := GridSnrRfidEdit.ValidateEdit;
        2 : Result := GridZeitEdit.ValidateEdit; // LeerString ist hier Ok
        else Result := true; // keine Pr�fung notwendig
      end
    else Result := true;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.SetzeNumFonts;
//------------------------------------------------------------------------------
// in RfidModus keine proportionale Schriftarten, L�nge Rfid-Code sollte konstant sein
begin
  if not RfidModus and (Screen.Fonts.IndexOf('Calibri') >= 0) then // nicht RFID
  begin
    NumFontName        := 'Calibri';
    NumFontSizeMin     := 11;
    TztGrid.TopAbstand := 1;
  end else
  if not RfidModus and (Screen.Fonts.IndexOf('Verdana') >= 0) then // nicht RFID
  begin
    NumFontName        := 'Verdana';
    NumFontSizeMin     := 10;
    TztGrid.TopAbstand := 1;
  end else
  if Screen.Fonts.IndexOf('Consolas') >= 0 then
  begin
    NumFontName        := 'Consolas';
    NumFontSizeMin     := 11;
    TztGrid.TopAbstand := 1;
  end else
  if not RfidModus and (Screen.Fonts.IndexOf('Arial') >= 0) then // nicht RFID
  begin
    NumFontName        := 'Arial';
    NumFontSizeMin     := 11;
    TztGrid.TopAbstand := 1;
  end else
  if Screen.Fonts.IndexOf('Lucida Console') >= 0 then
  begin
    NumFontName        := 'Lucida Console';
    NumFontSizeMin     := 10;
    TztGrid.TopAbstand := 2;
  end else
  if Screen.Fonts.IndexOf('Courier New') >= 0 then
  begin
    NumFontName        := 'Courier New';
    NumFontSizeMin     := 10;
    TztGrid.TopAbstand := 1;
  end else
  begin
    NumFontName        := 'Courier';
    NumFontSizeMin     := 10;
    TztGrid.TopAbstand := 2;
  end;

  SnrRfidEdit.Font.Name     := NumFontName;
  ZeitEdit.Font.Name        := NumFontName;

  GridSnrRfidEdit.Font.Name := NumFontName;
  GridZeitEdit.Font.Name    := NumFontName;
  TztGrid.Canvas.Font.Name  := NumFontName; // nur f�r Header auf Font.Name umschalten
  TztGrid.ColEditFontName   := NumFontName;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.SetzeFontSize(NumFontSizeNeu:Integer);
//------------------------------------------------------------------------------
// nur Canvas.Fonts setzen f�r Breite/Hoehe-berechnung in SetzeFontSizeMax
// Setzen von Font.Size verursacht flickern
begin
  NumFontSize              := NumFontSizeNeu;
  AlfFontSize              := Max(AlfFontSizeDefault, NumFontSize * 5 DIV 10);
  Canvas.Font.Size         := AlfFontSize;
  AlfTextHoehe             := Canvas.TextHeight('0');
  ButtonHoehe              := AlfTextHoehe + 10;
  TztGrid.Canvas.Font.Size := NumFontSize;
  TztGrid.ColEditFontSize  := NumFontSize;
  NumTextHoehe             := TztGrid.Canvas.TextHeight('0');
  EditHoehe                := NumTextHoehe + 2;
  ColEditHoehe             := NumTextHoehe + 2*TztGrid.TopAbstand; // = Default RowHeight
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.GridBreite: Integer;
//------------------------------------------------------------------------------
var i: Integer;
begin
  // basis: NumFontRec,TxtFontRec
  Result := TztGrid.DummySB.Width + 4;
  for i := 0 to TztGrid.ColCount-1 do
    Result := Result + TztColBreite(i) + 1;
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.ButtonBreite: Integer;
//------------------------------------------------------------------------------
begin
  // basis: TztHauptDlg.Canvas.Font
  Result := Canvas.TextWidth(' _Zeitnahme_ ');
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.TztColBreite(ACol:Integer): Integer;
//------------------------------------------------------------------------------
// basis: NumFontRec,TxtFontRec
// NumFontRec immer eingestellt
var S : String;
begin
  case ACol of
    0: Result := TztGrid.Canvas.TextWidth('x0000x');
    1: if RfidModus then
       begin
         S := 'xx';
         while Length(S) < RfidZeichen+2 do S := S+'0';  
         Result := Max(TztGrid.Canvas.TextWidth(S),
                       Canvas.TextWidth('RFID-Code') + AlfTextHoehe)
       end else
         Result := Max(TztGrid.Canvas.TextWidth('x0000x'),
                       Canvas.TextWidth('Startnr.') + AlfTextHoehe);
    2: case ZeitFormat of
         zfHundertstel : Result := TztGrid.Canvas.TextWidth('x00:00:00.00x');
         zfZehntel     : Result := TztGrid.Canvas.TextWidth('x00:00:00.0x');
         else            Result := TztGrid.Canvas.TextWidth('x00:00:00x');
       end;
    3: if SpalteTln then
         Result := TztGrid.Canvas.TextWidth('xName, Vorname0123456789x')
       else
       if SpalteZahl then
         Result := Max(TztGrid.Canvas.TextWidth('x0000x'),
                       Canvas.TextWidth(' Anzahl ') + AlfTextHoehe)
       else
         Result := 0;
    4: if SpalteZahl then
         Result := Max(TztGrid.Canvas.TextWidth('x0000x'),
                       Canvas.TextWidth(' Anzahl ') + AlfTextHoehe)
       else
         Result := 0;

    else Result := 0; // Warnung vermeiden
  end;
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.GesamtBreite: Integer;
//------------------------------------------------------------------------------
// Wert abh�ngig von Fontsize und ColCount
// Mindestgr��e f�r Symbolleiste 361 + Toleranz
begin
  Result := Max(363,Rand + GridBreite + Rand + ButtonBreite + Rand + RahmenBreite);
  // ScrollBars passen immer, da Rand = 20, aber nie sichtbar
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.GesamtHoehe: Integer;
//------------------------------------------------------------------------------
// GesamtH�he abh�ngig von FontSize
// nach GesamtBreite Berechnen, damit Font.Size etc. gesetzt sind
//..............................................................................
  function GetGridTop: Integer;
  begin
    Result := ActionMainMenuBar.Height + ActionToolBar.Height + Rand +  // SnrRfidLabel.Top
              AlfTextHoehe +                                            // SnrRfidEdit.Top
              EditHoehe + 4 +                    // SnrRfidEdit.Height
              2*ButtonHoehe + TrennPanel.Height;
  end;
//..............................................................................
begin
  Result := RahmenHoehe + GetGridTop +
            Max(2 + AlfTextHoehe+4 + 2*ColEditHoehe + 5, 2 + 4*ButtonHoehe + 4) +
            ButtonHoehe{+ Rand};
  if MausSperrenAction.Checked then
    Result := Result + 8 + AlfTextHoehe+5
  else
    Result := Result + Rand;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.SetAutoSpeichernInterval(Zeit:DWord);
//------------------------------------------------------------------------------
begin
  if Zeit > 0 then FAutoSpeichernInterval := Zeit // in mSek
              else FAutoSpeichernInterval := 0;
  ZeitDatGespeichert := 0; // Interval neu gestartet
  AutoSpeichernRequest := false;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.CommandHeader;
//------------------------------------------------------------------------------
begin
  if AutoSpeichernActive then
  begin
    AutoSpeichernActive := false;
    SetzeButtons; // Enable Commands
  end;
  if not ActionMainMenuBar.PersistentHotKeys then
    ActionMainMenuBar.PersistentHotKeys:= true;
  Repaint; // komplettes Fenster Repaint
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.SetzeFocus;
//------------------------------------------------------------------------------
// EditierMode: set in SetzeEditierMode
//              reset in ResetEditierMode
var AltCtrl,NeuCtrl : TWinControl;
begin
  if Visible then // nach Show-Event
  begin
    AltCtrl := ActiveControl; // alle Controls m�glich
    with TztGrid do
      if EditierMode then
        if ColEditMode and Assigned(ColEdits[Col]) then
          NeuCtrl := ColEdits[Col]
        else NeuCtrl := TztGrid

      else // not EditierMode
      if TimerModus = zmStop then
        NeuCtrl := ZeitEdit
      else
        NeuCtrl := SnrRfidEdit;

    if NeuCtrl <> AltCtrl then
      with NeuCtrl do
        if Visible and CanFocus then SetFocus;
  end;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.CommandTrailer;
//------------------------------------------------------------------------------
begin
  SetzeFocus;
  SetzeButtons;
  TztGrid.Invalidate;
  Repaint;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.CMDialogKey(var Msg: TWMKEY);
//------------------------------------------------------------------------------
// VK_TAB in Edits hier abfangen, sonst wird n�chster Control in Form fokussiert
// mit Charcode=0 bleibt TAB im Edit, landet in CustomEdit.Keydown
// und bei GridEdits von dort in TTriaGrid.KeyDown
// sicherheitshalber immer, unabh�ngig von EditierMode und ColEditMode
begin
  if (Msg.Charcode = VK_TAB) and
     ((ActiveControl = SnrRfidEdit) or
      (ActiveControl = ZeitEdit) or (ActiveControl = ZeitDummyEdit) or
      (ActiveControl = GridSnrRfidEdit) or (ActiveControl = GridZeitEdit)) then
    Msg.Charcode := 0;  // damit weiter in CustomMaskEdit.Keydown
  inherited;
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.GetColText(ACol,ARow:Integer): String;
//------------------------------------------------------------------------------
var TztObj : TTztObj;
begin
  Result := '';
  with TztGrid do
  begin
    if ARow < ItemCount + FixedRows then // FixedRows = 1
      TztObj := Items[ARow - FixedRows]
    else TztObj := nil;
    if TztObj <> nil then
      if not ColEditMode or (ARow<>Row) or (ACol<>Col) then // kein Text unter ColEdit
        TztGridGetColText(nil,TztObj,ACol,Result);
  end;
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.GetCol(Spalte:TTztSpalte): Integer;
//------------------------------------------------------------------------------
// TTztSpalte = (tsNr,tsSnr,tsZeit,tsName,tsZahl);
begin
  case Spalte of
    tsSnr  : Result := 1;
    tsZeit : Result := 2;
    tsName : Result := 3;
    tsZahl : if SpalteTln then Result := 4
                          else Result := 3;
    else (*tsNr*) Result := 0;
  end;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.UpdateNameEdit;
//------------------------------------------------------------------------------
// nicht RfidModus
var Indx : Integer;
    L,S  : String;
begin
  Indx := -1;
  S    := '';
  L    := '';
  if SpalteTln then
  begin
    S := Trim(SnrRfidEdit.Text);
    S := AddLeadZero(S,4); // '0000' wenn S=''
    if (SnrNameListe.Count > 0) and (StrToIntDef(S,0) > 0) then
      if SnrNameListe.Find(S,Indx) then
        S := TNameObj(SnrNameListe.Objects[Indx]).Name
      else
        S := strSnrUnbekannt
    else
      S := '-';

    L := ' ';
    with TztGrid do
      while Canvas.TextWidth(L+'  ') < Canvas.TextWidth('0') do
        L := L + ' ';
  end;

  NameEdit.Text := L + S;
  if NameEdit.Visible and (Trim(NameEdit.Text)=strSnrUnbekannt) then
    NameEdit.Font.Color := clRed
  else
    NameEdit.Font.Color := clWindowText;
end;

//------------------------------------------------------------------------------
procedure TTztHauptDlg.UpdateZahlEdit;
//------------------------------------------------------------------------------
// nicht RfidModus
var L,S   : String;
begin
  S := '';
  L := '';
  if SpalteZahl then
  begin
    S := Trim(SnrRfidEdit.Text);
    S := AddLeadZero(S,4); // '0000' wenn S=''
    if StrToIntDef(S,0) > 0 then
      S := IntToStr(TztColl.SnrSortList.SnrZahl(S)+1)
    else
      S := '-';
    L := ' ';
    with TztGrid do
      while Canvas.TextWidth(L+' ') < (ZahlEdit.ClientWidth-Canvas.TextWidth(S)) DIV 2 do
        L := L + ' ';
  end;

  ZahlEdit.Text := L + S;
  if ZahlEdit.Visible and (StrToIntDef(ZahlEdit.Text,0)>RndCheckZahl) then
    ZahlEdit.Font.Color := clRed
  else
    ZahlEdit.Font.Color := clWindowText;
end;

//==============================================================================
// Protected Methoden
//==============================================================================

//==============================================================================
procedure TTztHauptDlg.SetStopPaint(StopNeu:Boolean);
//==============================================================================
begin
  if StopNeu <> FStopPaint then
  begin
    FStopPaint := StopNeu;
    TztGrid.StopPaint := StopNeu;
    // beim Freigeben Paint ausf�hren wenn vorher blokkiert wurde
    if not FStopPaint and FPaintWartend then Repaint;
  end;
end;

//==============================================================================
procedure TTztHauptDlg.AlignControls(AControl:TControl; var ARect:TRect);
//==============================================================================
// aufgerufen nach Gr��en�nderung (ARect = ClientRect)
var i : Integer;
begin
  if (NumFontSize > 0) and (NumFontSize >= NumFontSizeMin) then
  begin
    if AControl=nil then // 1x pro �nderung
    begin
      // Parameter setzen, die nur von ARect abh�ngig sind
      SetzeFontSizeMax(ARect); // Fontgr��en an ClientRect anpassen
      TztGrid.DefaultRowHeight := ColEditHoehe; // NumTextHoehe + 2*TopAbstand
      TztGrid.RowHeights[0]    := AlfTextHoehe+4; 
      TztGrid.Width := GridBreite;
      for i:=0 to TztGrid.ColCount-1 do
        TztGrid.ColWidths[i] := TztColBreite(i);
      StatusBar.Panels[0].Width := ARect.Width;
    end;

    inherited AlignControls(AControl, ARect);

    if AControl=nil then // 1x pro �nderung
      MausFixieren;
  end;
end;

//==============================================================================
function TTztHauptDlg.CustomAlignInsertBefore(C1, C2: TControl): Boolean;
//==============================================================================
// true wenn C2 vor C1 gezeichnet wird
//..............................................................................
function Rang(const C:TControl): Integer;
begin
  if (C = SnrRfidEdit)          then Result := 1
  else if (C = ZeitDummyEdit)   then Result := 2
  else if (C = ZeitEdit)        then Result := 3
  else if (C = NameEdit)        then Result := 4
  else if (C = ZahlEdit)        then Result := 5
  else if (C = SnrRfidLabel)    then Result := 6 // Label zuerst macht Probleme
  else if (C = ZeitLabel)       then Result := 7
  else if (C = NameLabel)       then Result := 8
  else if (C = ZahlLabel)       then Result := 9
  else if (C = ErfassenBtn)     then Result := 10
  else if (C = TrennPanel)      then Result := 11
  else if (C = TztGrid)         then Result := 12
  else if (C = GridSnrRfidEdit) then Result := 13
  else if (C = GridZeitEdit)    then Result := 14
  else if (C = AendBtn)         then Result := 15
  else if (C = NeuBtn)          then Result := 16
  else if (C = LoeschBtn)       then Result := 17
  else
  if MausSperrenAction.Checked  then
    if (C = MausFixEdit)        then Result := 18
    else if (C = StatusBar)     then Result := 19
                                else Result := 20
  else
    if (C = StatusBar)          then Result := 18
                                else Result := 19;
end;
//..............................................................................
begin
  if Rang(C1) < Rang(C2) then Result := true
  else Result := false;
end;

//==============================================================================
procedure TTztHauptDlg.CustomAlignPosition(Control: TControl;
                              var NewLeft,NewTop,NewWidth,NewHeight: Integer;
                              var AlignRect:TRect; AlignInfo:TAlignInfo);
//==============================================================================
// Reihenfolge in CustomAlignInsertBefore definiert
// ButtonHoehe,ButtonBreite,EditHoehe,TztGrid.ColWidths[i],TztGrid.Width vorher berechnet
var LeftA,TopA,WidthA,HeightA : Integer;
begin
  if Control = SnrRfidEdit then // Rang=1
  begin
    NewLeft   := Rand + TztGrid.ColWidths[0] + 2;
    NewTop    := ActionMainMenuBar.Height + ActionToolBar.Height + Rand +
                 AlfTextHoehe;
    NewHeight := EditHoehe + 4;
    NewWidth  := TztGrid.ColWidths[1]; 
  end
  else
  if Control = ZeitDummyEdit then // Rang=2
  begin
    NewLeft   := SnrRfidEdit.Left + SnrRfidEdit.Width + 1; //ZeitLabel.Left nicht OK
    NewTop    := SnrRfidEdit.Top;
    NewHeight := SnrRfidEdit.Height;
    NewWidth  := TztGrid.ColWidths[2];
  end
  else
  // ZeitEdit und StartZeitEdit nicht immer deckend, deshalb nur eine Text zeigen
  if Control = ZeitEdit then // Rang=3
  begin
    NewTop    := ZeitDummyEdit.Top + 3;
    NewHeight := EditHoehe; // = ZeitDummyEdit.ClientHeight
    NewWidth  := TztGrid.ColEditBreite(2);
    NewLeft   := ZeitDummyEdit.Left+ (ZeitDummyEdit.ClientWidth-NewWidth) DIV 2;
  end
  else
  if Control = NameEdit then // Rang=4
  begin
    NewLeft   := ZeitDummyEdit.Left+ZeitDummyEdit.Width + 1;
    NewTop    := SnrRfidEdit.Top;
    NewHeight := SnrRfidEdit.Height;
    NewWidth  := TztGrid.ColWidths[3];
  end
  else
  if Control = ZahlEdit then // Rang=5
    if GetCol(tsZahl)=3 then
    begin
      NewLeft   := ZeitDummyEdit.Left+ZeitDummyEdit.Width + 1;
      NewTop    := SnrRfidEdit.Top;
      NewHeight := SnrRfidEdit.Height;
      NewWidth  := TztGrid.ColWidths[3];
    end else
    begin
      NewLeft   := NameEdit.Left+NameEdit.Width + 1;
      NewTop    := SnrRfidEdit.Top;
      NewHeight := SnrRfidEdit.Height;
      NewWidth  := TztGrid.ColWidths[4];
    end
  else
  if Control = SnrRfidLabel then // Rang=6
  begin
    NewLeft   := SnrRfidEdit.Left;
    NewTop    := ActionMainMenuBar.Height + ActionToolBar.Height + Rand;
    NewHeight := AlfTextHoehe;
    NewWidth  := SnrRfidEdit.Width; 
  end
  else
  if Control = ZeitLabel then // Rang=7
  begin
    NewLeft   := ZeitDummyEdit.Left;
    NewTop    := SnrRfidLabel.Top;
    NewHeight := AlfTextHoehe;
    NewWidth  := ZeitDummyEdit.Width;
  end
  else
  if Control = NameLabel then // Rang=8
  begin
    NewLeft   := NameEdit.Left;
    NewTop    := SnrRfidLabel.Top;
    NewHeight := AlfTextHoehe;
    NewWidth := Canvas.TextWidth('0  '+NameLabel.Caption)
  end
  else
  if Control = ZahlLabel then // Rang=9
  begin
    NewLeft   := ZahlEdit.Left;
    NewTop    := SnrRfidLabel.Top;
    NewHeight := AlfTextHoehe;
    NewWidth  := ZahlEdit.Width;
  end
  else
  if Control = ErfassenBtn then // Rang=10
  begin
    NewLeft   := Rand + GridBreite + Rand;
    NewTop    := SnrRfidEdit.Top + (EditHoehe + 4 - ButtonHoehe) DIV 2;
    NewHeight := ButtonHoehe;
    NewWidth  := ButtonBreite;
  end
  else
  if Control = TrennPanel then // Rang=11
  begin
    NewLeft   := 0;
    NewTop    := SnrRfidEdit.Top + SnrRfidEdit.Height + ButtonHoehe;
    NewHeight := TrennPanel.Height; // unver�ndert
    NewWidth  := ClientWidth;
  end
  else
  if Control = TztGrid then // Rang=12
  begin
    NewLeft   := Rand;
    NewTop    := TrennPanel.Top + TrennPanel.Height + ButtonHoehe;
    if MausSperrenAction.Checked then
      HeightA := ClientHeight - TrennPanel.Top - TrennPanel.Height - ButtonHoehe - // TztGridTop
                 8-AlfTextHoehe-5{FixMausEdit} - ButtonHoehe{StatusBar}
    else
      HeightA := ClientHeight - TrennPanel.Top - TrennPanel.Height - ButtonHoehe - // TztGridTop
                 Rand - ButtonHoehe{StatusBar};

    NewHeight := Max(Max(HeightA, // TztGridBottom
                         2 + AlfTextHoehe+4 + 2*ColEditHoehe + 5), // >= 2 GridZeilen
                     2 + 4*ButtonHoehe + 4); // Buttons bleiben Sichtbar
    NewWidth  := TztGrid.Width;
  end
  else
  if Control = GridSnrRfidEdit then // Rang=13
    if TztGrid.GetColEditsPos(1,LeftA,TopA,WidthA,HeightA) then
    begin
      NewLeft   := LeftA;
      NewTop    := TopA;
      NewHeight := HeightA;
      NewWidth  := WidthA;
    end else
  else
  if Control = GridZeitEdit then // Rang=14
    if TztGrid.GetColEditsPos(2,LeftA,TopA,WidthA,HeightA) then
    begin
      NewLeft   := LeftA;
      NewTop    := TopA;
      NewHeight := HeightA;
      NewWidth  := WidthA;
    end else
  else
  if Control = AendBtn then // Rang=15
  begin
    NewLeft   := ErfassenBtn.Left;
    NewTop    := TztGrid.Top;
    NewHeight := ButtonHoehe;
    NewWidth  := ButtonBreite;
  end
  else
  if Control = NeuBtn then // Rang=16
  begin
    NewLeft   := ErfassenBtn.Left;
    NewTop    := TztGrid.Top + 2*ButtonHoehe;
    NewHeight := ButtonHoehe;
    NewWidth  := ButtonBreite;
  end
  else
  if Control = LoeschBtn then // Rang=17
  begin
    NewLeft   := ErfassenBtn.Left;
    NewTop    := TztGrid.Top + 3*ButtonHoehe + 4;
    NewHeight := ButtonHoehe;
    NewWidth  := ButtonBreite;
  end
  else
  if Control = MausFixEdit then // Rang=18, wenn sichtbar
  begin
    NewLeft   := 4;//Rand;
    NewHeight := AlfTextHoehe+5;
    NewTop    := TztGrid.Top + TztGrid.Height + 4;
    NewWidth  := ClientWidth-8;// - 2*Rand;
  end
  else
  if Control = StatusBar then // Rang=18 oder 19
  begin
    NewLeft  := 0;  // = konstant
    NewHeight := ButtonHoehe;
    NewTop    := ClientHeight-ButtonHoehe;
    NewWidth  := ClientWidth;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - TztHauptDlg                                             *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.FormShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nach Laden der Ini-Datei
begin
  // TriaZeit Setup abbrechen, wenn TriaZeit ausgef�hrt wird
  // gleicher MutexName in Inno Setup verwenden
  CreateMutex(nil, False, 'TriaZeitMutexName');
  SetzeFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.UhrzeitTimerTick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// cnTrzTimerInterval = 5; // 5 mSek
// hier wird nur auto-gespeichert, wenn �ber Intervalzeit kein Command aktiviert wird
// Konflikt zwischen Men�Command und AutoSpeichernRequest vermeiden:
// Priorit�t beim asynchronen men�Command:
// Beim 1. Tick wird AutoSpeichernRequest und AutoSpeichernActive true und
// SetzeButtons ausgef�hrt (Command-Disable)
// Beim Men�Command wird MenueCommandActive gesetzt und AutoSpeichernActive gepr�ft,
// und falls gesetzt AutoSpeichernActive zur�ckgesetzt und SetzeButtons ausgef�hrt
// (Command-Enable)
// beim 2. Tick wird TriDatAutoSpeichern nur ausgef�hrt, wenn noch nicht geschehen
// in CommandExecute (ZeitDatGespeichert ge�ndert) und MenueCommandActive false

var TztObj : TTztObj;
    Zeit : Integer;
    ActCtrlAlt : TWinControl;
begin
  if TimerTickDisabled then Exit;
  TimerTickDisabled := true; // Funktionen komplett abschlie�en
  ActCtrlAlt := ActiveControl; // alle Controls m�glich

  // UhrZeit nur 1x auslesen
  Zeit := UhrZeit; // in 1/100, gerundet entsprechend ZeitFormat
  if Zeit <> UhrzeitAktuell then
  begin
    UhrZeitAktuell := Zeit;

    case TimerModus of
      zmStop  : EditZeit := -1; // ZeitEdit editierbar, ReadOnly=false
      zmStart :
      begin
        // Startzeit aus ZeitEdit und UhrZeitAktuell �bernehmen
        StartUhrZeit := UhrZeitWert(ZeitEdit.EditText); // Wert nur 1x berechnen
        if UhrZeitAktuell >= StartUhrZeit then
          StartUhrZeit := UhrZeitAktuell - StartUhrZeit
        else
          StartUhrZeit := cnZeit24_00 + UhrZeitAktuell - StartUhrZeit;
        EditZeit := -1;
        SetzeTimerModus(zmRun);
        SpeichereKonfiguration; // Modus und StartUhrzeit in Ini-Datei speichern
        SetzeFocus;
        ActCtrlAlt := ActiveControl;
      end;
      zmRun :
        if UhrZeitAktuell >= StartUhrZeit then
          EditZeit := UhrZeitAktuell - StartUhrZeit
        else
          EditZeit := cnZeit24_00 + UhrZeitAktuell - StartUhrZeit;
      else // zmUhrZeit
        EditZeit := UhrZeitAktuell;
    end;
    if EditZeit >= 0 then // nur zmUhrZeit und zmRun, sonst bleibt 00:00:00
      ZeitEdit.Text := UhrZeitStr(EditZeit);
  end;

  // Records aus TztBufColl in TztColl/TztGrid �bernehmen
  // wenn ZeitGleich=zgGleichNOk, dann wird eine erfasste Snr erst �bernommen
  // wenn sich die Zeit ge�ndert hat, um identische Zeiten zu verhindern
  // EditierMode und ColEditMode beibehalten, kein SelectCell, sonst ggf. endlose Fehlermeldung
  if (TztBufColl<>nil) and
     ((ZeitGleich = zgGleichOk) or (UhrZeitAktuell <> UhrZeitAktGelistet)) and
     (TztBufColl.Count > 0) then
  begin
    UhrZeitAktGelistet := UhrZeitAktuell;
    SetStopPaint(true);
    with TztGrid do
    begin
      if (TztBufColl[0].FestSortIndex >= 0) and // Zeile ohne Zeit
         (TztBufColl[0].FestSortIndex < TztColl.Count) then // unabh�ngig von ColEditMode
      begin
        TztColl[TztBufColl[0].FestSortIndex].Zeit := UhrZeitStr(EditZeit); // Snr bleibt unver�ndert
        if not EditierMode then                                // endlose Fehlermeldung vermeiden,
          FocusedItem := TztColl[TztBufColl[0].FestSortIndex] // Focus in Editiermode bleibt unver�ndert
        else
        if ColEditMode and (Col=2) and
           (TztColl[TztBufColl[0].FestSortIndex] = FocusedItem) then // Edit mit neuer Zeit �berschreiben,
          GridZeitEdit.Text := UhrZeitStr(EditZeit);                 // auch wenn mittlerweile <> ZeitInitwert
        if (ItemCount > 0) and not TTztObj(TztGrid[ItemCount-1]).InitWert then // letzte Zeile nicht leer
        begin
          TTztColl(Collection).AddItem(TTztObj.Create(nil,TztColl,oaNoAdd)); // leeres Item am Ende
          CollectionUpdate; // RowCount gesetzt
        end;
      end else
      begin
        // erste Item aus TztBufColl (Index=0) in TztColl �bernehmen
        TztObj := TTztObj.Create(nil,TztColl,oaNoAdd);
        TztObj.Init(TztBufColl[0].Snrrfid,UhrZeitStr(EditZeit));
        AddItem(TztObj); // TztObj am Ende anh�ngen
        CollectionUpdate;
        if not EditierMode then  // endlose Fehlermeldung vermeiden,
          FocusedItem := TztObj; // Focus in Editiermode bleibt unver�ndert
      end;
    end;
    SetStopPaint(false);
    TztBufColl.ClearIndex(0);
    TztGrid.Refresh;// nach Setzen von FocusedItem, damit Row+Col richtig markiert
    TztDatModified := true;
  end;

  // Zeit nur 1x auslesen
  ZeitAktuell := GetTickCount; // in mSek
  if ZeitDatGespeichert = 0 then // ZeitAktGespeichert initialisieren
    ZeitDatGespeichert := ZeitAktuell; // Interval neu gestartet
  // Zeiten in mSek
  if AutoSpeichernInterval > 0 then
    if TztDatModified then
      if ZeitAktuell >= ZeitDatGespeichert + AutoSpeichernInterval then
        if AutoSpeichernRequest = false then // zuerst immer false
        begin
          AutoSpeichernRequest := true;
          AutoSpeichernActive := true;
          SetzeButtons; // disable Men�Commands
          // falls gleichzeitig Men�command aktiviert wird, wird AutoSpeichernActive zur�ckgesetzt
          // Request bleibt aktiviert, auch wenn Men�Command aktiv ist und kann w�hrend
          // Command-Ausf�hrung abgefragt werden
          // warten bis n�chsten Tick, 5 mSek Zeit f�r Men�Command zum Disabeln
        end

        else // mindstens 5 mSek kein Command aktiviert
          if not MenueCommandActive then // ZeitDatGespeichert wird gesetzt
            DateiAutoSpeichern // im Fehlerfall wird abgeschaltet
          else // warten bis Command beendet oder Datei gespeichert
      else // warten bis Zeit erreicht ist
    else AutoSpeichernRequest := false
  else
  begin
    AutoSpeichernRequest := false;
    ZeitDatGespeichert := ZeitAktuell; // nach �nderung immer neuer Zyklus
  end;

  if (ActCtrlAlt <> nil) and (ActCtrlAlt <> ActiveControl) then
    with ActCtrlAlt do
      if Visible and CanFocus then SetFocus;
  SetzeButtons;
  TztHauptDlg.UpdateStatusBar;
  TimerTickDisabled := false;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.FormClose(Sender: TObject; var Action: TCloseAction);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  ClipCursor(nil);
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  CanClose := false;
  if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;

  if SetupGestartet or DateiSichern then
  begin
    UhrZeitTimer.Enabled := false;
    SpeichereKonfiguration;
    CanClose := true;
  end else
  begin
    SetzeFocus;
    SetzeButtons;
  end;
end;


(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - Men� Datei                                              *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.DatNeuActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    DateiNeu('');
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.DatOeffnenActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    DateiOeffnen;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.DatSpeichernActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    DateiSpeichern;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.DatSpeichernUnterActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    DateiSpeichernUnter;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.DatKopierenActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    DateiKopieren;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.ImportTlnLstActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;

    StartlisteDateiLaden('');
    if SnrNameListe.Count > 0 then
    begin
      TztHauptDlg.ShowTlnLstAction.Enabled := true;
      TztStartliste.Anzeigen; // geht nicht in TztConfig, weil TztStartliste=nil
    end else
      TztHauptDlg.ShowTlnLstAction.Enabled := false;

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.DruckenActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    Drucken;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.MruActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var
  Idx : Integer;
  Pfad : String;
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;

    if Sender = MruAction1 then Idx := 1
    else if Sender = MruAction2 then Idx := 2
    else if Sender = MruAction3 then Idx := 3
    else if Sender = MruAction4 then Idx := 4
    else if Sender = MruAction5 then Idx := 5
    else if Sender = MruAction6 then Idx := 6
    else if Sender = MruAction7 then Idx := 7
    else if Sender = MruAction8 then Idx := 8
    else Idx := -1;

    Pfad := FMruListe[Idx];
    if Pfad <> '' then DateiNeu(Pfad);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.BeendenActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // Abfrage in FormCloseQuery
  MenueCommandActive := true;
  try
    CommandHeader;
    Close;
  finally
    MenueCommandActive := false;
  end;
end;


(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - Men� Bearbeiten                                         *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.AendernActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    MenueCommandActive := true;
    CommandHeader;
    with TztGrid do
      if not EditierMode then
        SetzeEditierMode(1,Row) // immer Snr-Spalte selektieren
      else
        NachUnten; // n�chste Zeile,gleiche Spalte
    CommandTrailer;
  finally
    DisableButtons := false;
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.NeuActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Einf�gen
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    MenueCommandActive := true;
    CommandHeader;
    if not TztGrid.ResetColEditMode then Exit;

    if TztColl.Count >= cnTlnMax then
    begin
      TriaMessage('Die maximale Zahl der Zeitnahmen ist erreicht.'+#13+
                  'Weitere Eintr�ge k�nnen nicht aufgenommen werden.',
                   mtInformation,[mbOk]);
      TztGrid.Refresh;
      Exit;
    end;

    with TztGrid do // obwohl nicht sinnvoll, mehrere Leerzeilen zulassen
    begin
      SetzeEditierMode(1,Row);
      SetStopPaint(true);
      TTztColl(TztGrid.Collection).InsertItem(ItemIndex,TTztObj.Create(nil,TztColl,oaNoAdd));
      CollectionUpdate;
      UpdateStatusBar;
      SetStopPaint(false);
      SetzeFocus;
      Refresh;
    end;

    // TztDatModified erst gesetzt wenn Edit gespeichert wird in OnSelectCell

  finally
    CommandTrailer;
    DisableButtons := false;
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.LoeschenActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// FocusedItem entfernen
var Snr,Zeit,SnrRfid: String;
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    MenueCommandActive := true;
    CommandHeader;
    //if not ResetEditMode then Exit; auch im Fehlerfall l�schen

    if RfidModus then SnrRfid := 'RFID-Code'
                 else SnrRfid := 'Startnr.';

    with TztGrid do
    if FocusedItem <> nil then
    begin
      if ColEditMode and (Col = 1) then Snr := GridSnrRfidEdit.Text
      else Snr := TTztObj(FocusedItem).SnrRfid;
      if not RfidModus then Snr := Trim(RemLeadZero(Snr));  //  bei l�schen leerzeile focus eins hoch
      if ColEditMode and (Col = 2) then Zeit := GridZeitEdit.Text
      else Zeit := TTztObj(FocusedItem).Zeit;
      if (RfidModus and StrGleich(Snr,'') or
          not RfidModus and (StrToIntDef(Snr,0) = 0)) and (UhrZeitWert(Zeit) < 0) and // = InitWert
         (ItemIndex = ItemCount - 1) and // letzte LeerZeile
         ((ItemCount=1) or not TTztObj(TztGrid[ItemCount-2]).InitWert) then // vorletzte Zeile nicht leer
      begin
        if ItemCount > 1 then ItemIndex := ItemCount-2;
        Exit;
      end else
      if (RfidModus and StrGleich(Snr,'') or
          not RfidModus and (StrToIntDef(Snr,0) = 0)) and (UhrZeitWert(Zeit) < 0) or
         (TriaMessage('Eintrag Nr. ' + IntToStr(Row) + ' ('+SnrRfid+' = "' + Snr +
                      '", '+ 'Zeit = "'+Zeit + '")  l�schen?',
                       mtConfirmation,[mbOk,mbCancel]) = mrOk) then
      begin
        TztDatModified := true;
        Refresh;
        SetStopPaint(true);
        ClearItem(FocusedItem);  // incl. Grid.Invalidate
        if (ItemCount = 0) or not TTztObj(TztGrid[ItemCount-1]).InitWert then
          AddItem(TTztObj.Create(nil,TztColl,oaNoAdd)); // leeres Item am Ende
        CollectionUpdate;
        UpdateStatusBar;
        SetStopPaint(false);
        SetzeFocus;
        Refresh;
      end;
    end;

  finally
    CommandTrailer;
    DisableButtons := false;
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.AbgleichActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    SnrAbgleichen;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;


(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - Men� Zeitnahme                                          *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.StartActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Men�-Klick, F3-Taste und ErfassenBtn (TimerModus=zmStop) landen hier
// EditierMode und ColEditMode nur bei gesperrter Maus beibehalten
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    MenueCommandActive := true;
    CommandHeader;
    // ZeitEdit.ValidateEdit zuerst, sonst Meldung in ResetEditierMode/ResoreFocus ohne Exit
    if not ZeitEdit.ValidateEdit or
       not MausSperrenAction.Checked and not ResetEditierMode then Exit;

    ZeitEdit.ReadOnly := true;
    if BeepSignal then MessageBeep(MB_OK);
    SetzeTimerModus(zmStart); // SpeichereKonf. (zmRun und StartUhrZeit) in UhrzeitTimerTick
  finally
    CommandTrailer;
    MenueCommandActive := false;
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.StoppActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;

    if (TztGrid.ItemCount=0) or // gibt es nicht
       (TztGrid.ItemCount = 1) and TTztObj(TztGrid[0]).InitWert or
       (TriaMessage('M�chten Sie die Uhr anhalten und zur�cksetzen?',
                    mtConfirmation,[mbOk,mbCancel]) = mrOk) then
    begin
      SetzeTimerModus(zmStop);
      SpeichereKonfiguration; // Modus zmStop in Ini-Datei speichern
    end;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.ZeitnahmeActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Men�-Klick, ErfassenBtnClick (TimerModus <> zmStop),
// F5-Taste (von Tastatur-Hook abgefangen) und landen hier
// EditierMode und ColEditMode beibehalten bei F5 und gesperrter Maus
// Focus in Editiermode unver�ndert, sonst neuer Eintrag
// Sender=nil bei F5-Taste

var TztBufObj,TztLeerObj : TTztObj;

  //..............................................................................
  function ItemInTztBufColl(Idx:Integer): Boolean;
  // bereits in TztBufColl aufgenommenen Items nicht als Leer ber�cksichtigen
  var i : Integer;
  begin
    Result := false;
    for i:=0 to TztBufColl.Count-1 do
      if TztBufColl[i].FestSortIndex = Idx then
      begin
        Result := true;
        Exit;
      end;
  end;

  //..............................................................................
  function GetZeit(Idx:Integer): String;
  begin
    with TztGrid do
      if (Idx = ItemIndex) and ColEditMode and (Col=2) then
        Result := GridZeitEdit.Text
      else
        Result := TTztObj(TztGrid[Idx]).Zeit;
  end;

  //..............................................................................
  function ErstesItemOhneZeit: TTztObj;
  // in diese Zeile wird Zeit eingetragen, wenn keine Zeit vorhanden
  // bei ColEditMode und (Col=2) Wert GridZeitEdit.Text, sonst TztGrid[i]).Zeit ber�cksichtigen
  // GridZeitEdit wird ggf. in UhrzeitTimerTick mit neuer Zeit �berschrieben
  var i : Integer;
  begin
    Result := nil;
    with TztGrid do
      for i:=0 to ItemCount-1 do // angezeigte Reihenfolge in Grid
        if not ItemInTztBufColl(TztColl.IndexOf(TztGrid[i])) and
           StrGleich(ZeitInitWert,GetZeit(i)) then
           //(UhrZeitWert(GetZeit(i)) < 0) then
        begin
          Result := TztGrid[i];
          Exit;
        end;
  end;

//..............................................................................
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    MenueCommandActive := true;
    CommandHeader;

    // ZeitEdit.ValidateEdit zuerst, sonst Meldung in ResetEditierMode/ResoreFocus ohne Exit
    // �berlaufen von TztBufColl und ung�ltige Zeit verhindern
    // EditierMode und ColEditMode beibehalten bei F5 (Sender=nil) und gesperrtem Mausklick
    if not ZeitEdit.ValidateEdit or not ErfassenBtn.Enabled or
       not MausSperrenAction.Checked and (Sender<>nil) and not ResetEditierMode then Exit;

    TztBufObj := TTztObj.Create(nil,TztColl,oaNoAdd); // FestSortIndex = -1
    if not TztGrid.EditierMode or                   // immer am Ende anh�ngen, wenn kein EditierMode
       (StrToIntDef(Trim(SnrRfidEdit.Text),0) > 0) then // oder g�ltige Snr oben eingetragen
      TztLeerObj := nil
    else
      TztLeerObj := ErstesItemOhneZeit;

    if TztLeerObj <> nil then // Zeile ohne Zeit vorhanden, Zeit eintragen
    begin
      if BeepSignal then MessageBeep(MB_OK); // bei ung�ltiger Name oder Anzahl Beep bereits bei Eingabe Snr
      TztBufObj.Init(TztLeerObj.SnrRfid,ZeitEdit.EditText);
      TztBufObj.FestSortIndex := TztColl.IndexOf(TztLeerObj);
    end else
    begin
      // wie bisher, neuer Eintrag mit SnrRfidEdit und ZeitEdit
      if BeepSignal or
         ZahlEdit.Visible and (StrToIntDef(ZahlEdit.Text,0)>RndCheckZahl) or
         NameEdit.Visible and (Trim(NameEdit.Text)=strSnrUnbekannt) then
        MessageBeep(MB_OK);
      TztBufObj.Init(SnrRfidEdit.Text,ZeitEdit.EditText); // FestSortIndex bleibt -1
      SnrRfidEdit.Text := '';
    end;

    // TztDatModified := true; erst bei Eintrag in TztGrid setzen
    // Eintrag zun�chst in Buffer-Collection speichern
    // In TztGrid erst aufnehmen nachdem gespeichert wurde
    TztBufColl.AddItem(TztBufObj); // FestSortIndex ge�ndert

  finally
    CommandTrailer; // weitere Eingaben ab cnBufferMax sperren in SetzeButtons
    MenueCommandActive := false;
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.ErfassenBtnClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if TimerModus = zmStop then StartActionExecute(Sender) // = F3
                         else ZeitnahmeActionExecute(Sender); // = F5
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.MausSperrenActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit then Exit;

    if MausSperrenAction.Checked then
      MausSperrenAction.Checked := false
    else
    if TriaMessage('Maus f�r Remote-Zeitnahme fixieren?' + #13+#13+
                   'Mit der Tastenkombination Strg + M kann die Maus wieder freigegeben werden.',
                    mtConfirmation,[mbOk,mbCancel]) = mrOk then
    begin
      if not TztGrid.EditierMode then
        SetzeEditierMode(1,TztGrid.Row); // immer Snr-Spalte selektieren
      MausSperrenAction.Checked := true;
    end;
    UpdateLayout; // inkl. Maus fixieren oder freigeben

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;

end;


(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - Men� Ansicht                                            *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.SpalteTlnActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;

    if SpalteTlnAction.Checked then
    begin
      SpalteTlnAction.Checked := false;
      SpalteTln := false;
    end else
    begin
      SpalteTlnAction.Checked := true;
      SpalteTln := true;
    end;
    UpdateLayout;

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.ShowTlnLstActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;

    TztStartliste.Anzeigen;

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.SpalteZahlActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;

    if SpalteZahlAction.Checked then
    begin
      SpalteZahlAction.Checked := false;
      SpalteZahl := false;
    end else
    begin
      SpalteZahlAction.Checked := true;
      SpalteZahl := true;
      RndCheckZahl := Max(1,RndCheckZahl); // 1 = default
    end;
    UpdateLayout;

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.ZeitAufActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    SetSortMode(smTztZeitAuf);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.ZeitAbActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    SetSortMode(smTztZeitAb);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.SnrAufActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    SetSortMode(smTztSnrAuf);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.SnrAbActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    SetSortMode(smTztSnrAb);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.KleinerActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
{
TForm-Eigenschaften:
Left:                   linker Rand des Formulars relativ zum gesamten Bildschirm
Width                   Breite des Formulars in Pixel
ClientWidth             Width minus der Breite des Rahmens und der Bildlaufleisten

Screen.Width:           Breite des Benutzerbildschirms
Screen.WorkAreaWidth:   Breite des Arbeitsbereichs auf dem Hauptbildschirm (Eigenschaft Primary = true).
                        Fl�chen, die auf dem Desktop von der Taskleiste und eventuell
                        von Symbolleisten belegt sind, werden abgezogen
Screen.DesktopWidth:    Breite des Desktops, entspricht dem gesamten virtuellen Desktop,
                        der alle Bildschirme im System einschlie�t
Screen.DesktopLeft:     X-Koordinate des Desktops relativ zur linken, oberen Ecke des Hauptbildschirms

Screen.MonitorCount:              gibt an wieviele Bildschirme f�r das Anzeigen des Desktops verwendet werden.
Screen.Monitors[Index]:           Zugriff auf die einzelnen Bildschirme eines Mehrschirmsystems
Screen.Monitors[i].Width:         Breite des Bildschirms [i]
Screen.Monitors[i].WorkAreaWidth: Breite des Arbeitsbereichs auf dem Bildschirm [i]
Screen.monitors[i].Left:          Linker Rand des Bildschirms[i] innerhalb des Gesamtbereichs aller Bildschirme.
                                  Position relativ zur linken Kante des Prim�rbildschirms
}
var FontSizeAlt,FontSizeNeu,GesamtBreiteAlt,
    WidthNeu,HeightNeu: Integer;
    R : TRect;
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if WindowState = wsMaximized then Exit;

    R := Monitor.WorkareaRect;
    FontSizeAlt     := NumFontSize;
    GesamtBreiteAlt := GesamtBreite;
    WidthNeu        := Width;  // Width,Height nicht f�r Berechnungen benutzen,
    HeightNeu       := Height; // damit Align erst am Ende 1x statt findet

    // Versuche 30%, aber MinSize=NumFontSizeMin
    FontSizeNeu := Max(NumFontSizeMin,(10 * NumFontSize) DIV 13);
    if (FontSizeNeu < FontSizeAlt) or (GesamtBreiteAlt < WidthNeu) then
    begin
      SetzeFontSize(FontSizeNeu);
      WidthNeu := GesamtBreite;
      if GesamtBreiteAlt > 0 then
        HeightNeu := Max((WidthNeu * HeightNeu) DIV GesamtBreiteAlt, GesamtHoehe);
    end else
      if HeightNeu > GesamtHoehe then HeightNeu := GesamtHoehe;

    // AlignControls nur 1x aufrufen
    SetBounds(Max(R.Left, Min(Left,R.Left+R.Width-WidthNeu)),
              Max(R.Top, Min(Top,R.Top+R.Height-HeightNeu)),
              WidthNeu, HeightNeu);

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.GroesserActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var FontSizeAlt,FontSizeNeu, GesamtBreiteNeu,GesamtBreiteAlt,
    WidthNeu,HeightNeu: Integer;
    R : TRect;
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if WindowState = wsMaximized then Exit;

    R := Monitor.WorkareaRect;
    FontSizeAlt := NumFontSize;
    GesamtBreiteAlt := GesamtBreite;
    WidthNeu  := Width;
    HeightNeu := Height;

    // Versuche zun�chst 30%, dann kleinere schritte
    FontSizeNeu := (13 * NumFontSize) DIV 10;
    SetzeFontSize(FontSizeNeu);
    if GesamtBreite > R.Width then
      repeat
        Dec(FontSizeNeu);
        SetzeFontSize(FontSizeNeu);
      until (FontSizeNeu <= FontSizeAlt) or (GesamtBreite <= R.Width);

    if FontSizeNeu > FontSizeAlt then
    begin
      SetzeFontSize(FontSizeNeu);
      GesamtBreiteNeu := GesamtBreite;
      WidthNeu := Max(GesamtBreiteNeu,WidthNeu);
      if GesamtBreiteAlt > 0 then
        HeightNeu := Min((GesamtBreiteNeu * HeightNeu) DIV GesamtBreiteAlt,R.Height);
    end else
      HeightNeu := Min((HeightNeu*13) DIV 10,R.Height);

    // AlignControls nur 1x aufrufen
    SetBounds(Max(R.Left, Min(Left,R.Left+R.Width-WidthNeu)),
              Max(R.Top, Min(Top,R.Top+R.Height-HeightNeu)),
              WidthNeu, HeightNeu);

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.ZoomBreitActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var HeightNeu: Integer;
    R : TRect;
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if WindowState = wsMaximized then Exit;

    R := Monitor.WorkareaRect;
    HeightNeu := Max(GesamtHoehe,Height);
    // AlignControls nur 1x aufrufen
    SetBounds(Monitor.WorkareaRect.Left,
              Max(R.Top,R.Top + (R.Height - HeightNeu) DIV 2),
              Monitor.WorkareaRect.Width, HeightNeu);

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.ZoomGanzActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    // Checked gesetzt in WMSize, auch bei BorderIcon
    if not ZoomGanzAction.Checked then WindowState := wsMaximized
    else WindowState := wsNormal;

    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;


(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - Men� Extras                                             *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.UpdateActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    InternetUpdate(umManuell);
    if SetupGestartet then Close
    else CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.OptionenActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    Optionen;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - Men� Hilfe                                              *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.OnlineHilfeActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    CommandTrailer;
    if HelpDateiVerfuegbar then
      Application.HelpContext(0100)  // �bersicht
    else
      TriaMessage('Die Hilfe-Datei wurde nicht gefunden:'#13+
                  ExtractFilePath(Paramstr(0))+'TriaZeit.chm',
                  mtInformation,[mbOk]);
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.ContextHilfeActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    CommandTrailer; // vor DefWindProc, sonst verschwindet Fenster sofort
    // MausZeiger f�r Help Text Popup setzen
    //WinHelpTester_Enable(false); hilft nicht
    if HelpDateiVerfuegbar then
      DefWindowProc(handle, WM_SYSCOMMAND, SC_CONTEXTHELP, 0)
    else
      TriaMessage('Die Hilfe-Datei wurde nicht gefunden:'#13+
                  ExtractFilePath(Paramstr(0))+'TriaZeit.chm',
                  mtInformation,[mbOk]);
    //WinHelpTester_Enable(true);
  finally
    MenueCommandActive := false;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTztHauptDlg.TrzImWebActionExecute(Sender: TObject);
(*----------------------------------------------------------------------------*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    CommandTrailer;
    ShellExecute(Application.Handle,'open',PChar('http://www.selten.de'),
                 nil,nil, sw_ShowNormal);
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.InfoActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not ZeitEdit.ValidateEdit or not ResetEditierMode then Exit;
    ZeigeInfo;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - Edit                                                    *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.SnrRfidEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  UpdateNameEdit;
  UpdateZahlEdit;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.SnrRfidEditClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// auch f�r SnrRfidLabel, Zeitlabel und ZeitEdit benutzt
begin
  if ZeitEdit.ValidateEdit and ResetEditierMode then SetzeFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.SnrRfidEditKeyDown(Sender:TObject; var Key:Word; Shift:TShiftState);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Pfeiltasten aus SnrRfidEdit hier abfangen f�r Steuerung von Grid-Position
// Kommen in KeyPress nicht an
// TAB kommt hier via CMDialogKey an
begin
  case Key of
    VK_HOME,VK_PRIOR,VK_UP,VK_DOWN,VK_NEXT,VK_END:
    begin
      TztGrid.KeyDown(Key,Shift);
      SetzeFocus;
    end;
    VK_TAB:
      if ZeitEdit.ValidateEdit then
        SetzeEditierMode(1,TztGrid.Row); // immer Snr-Spalte selektieren
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.SnrRfidEditMouseActivate(Sender:TObject; Button:TMouseButton;
                    Shift:TShiftState; X,Y,HitTest:Integer; var MouseActivate:TMouseActivate);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if TimerModus = zmStop then
  begin
    if ZeitEdit.ValidateEdit and ResetEditierMode then
      SetzeFocus;
    MouseActivate := maNoActivateAndEat
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.ZeitDummyEditMouseActivate(Sender:TObject; Button:TMouseButton;
               Shift:TShiftState; X,Y,HitTest:Integer; var MouseActivate: TMouseActivate);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if ZeitEdit.ValidateEdit and ResetEditierMode then
    SetzeFocus;
  MouseActivate := maNoActivateAndEat
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.ZeitEditMouseActivate(Sender:TObject; Button:TMouseButton;
            Shift:TShiftState; X,Y,HitTest:Integer; var MouseActivate:TMouseActivate);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  case TimerModus of
    zmUhrZeit,zmStart,zmRun:
    begin
      if ZeitEdit.ValidateEdit and ResetEditierMode then
        SetzeFocus;
      MouseActivate := maNoActivateAndEat
    end
    else ; // zmStop
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.SnrRfidEditMouseWheel(Sender: TObject; Shift: TShiftState;
                                         WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// MouseWheel auch in Zeitnahme-Modus f�r Grid benutzen
// SnrRfidEdit/ZeitEdit hat Focus und muss Focus behalten
// in Zeitnahme-Modus bleiben, Editiermode nicht setzen (EnableOnClick false)
begin
  TztGrid.EnableOnClick := false; // EditierMode nicht setzen
  try
    Handled := TztGrid.DoMouseWheel(Shift,WheelDelta,MousePos);
    SetzeFocus;
  finally
    TztGrid.EnableOnClick := true;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.GridSnrRfidEditMouseWheel(Sender: TObject; Shift: TShiftState;
                                             WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if GridSnrRfidEdit.ValidateEdit then
    Handled := TztGrid.DoMouseWheel(Shift,WheelDelta,MousePos)
  else Handled := true;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.GridZeitEditMouseWheel(Sender: TObject; Shift: TShiftState;
                                              WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if GridZeitEdit.ValidateEdit then
    Handled := TztGrid.DoMouseWheel(Shift,WheelDelta,MousePos)
  else Handled := true;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.GridSnrRfidEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  TztGrid.Invalidate;
  TztGrid.Repaint;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Event Handler - TztGrid                                                 *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.TztGridSelectCell(Sender: TObject; ACol, ARow: Integer;
                                         var CanSelect: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// aufgerufen von TTriaGrid.SelectCell
// ARow,ACol neue Zelle, nicht benutzt
// wenn ColEditMode and CanSelect=true Daten speichern
var Buf : Boolean;
begin
  if Sender = TztGrid then
  with TztGrid do
  begin
    Buf := StopPaint;
    FocusAlt := nil;

    if not ColEditMode then // nur in ColEditMode pr�fen
      CanSelect := true
    else
    begin
      CanSelect := EingabeOk; // ColEdits pr�fen
      if CanSelect and (FocusedItem <> nil) then
      try
        StopPaint := true;
        with TTztObj(FocusedItem) do
          case Col of
            1: begin
                 if RfidModus and (SnrRfid <> GridSnrRfidEdit.Text) or
                    not RfidModus and (StrToIntDef(SnrRfid,0) <> StrToIntDef(GridSnrRfidEdit.Text,0)) then
                 begin
                   TztDatModified := true;
                   SnrRfid := GridSnrRfidEdit.Text
                 end;
                 if (SpalteZahl and (StrToIntDef(TztGridSnrAnzahl(FocusedItem,SnrRfid),0) > RndCheckZahl)) or
                    (SpalteTln and (TztGridSnrName(FocusedItem,SnrRfid)=strSnrUnbekannt)) then
                   MessageBeep(MB_OK);
               end;
            2: if UhrZeitWert(Zeit) <> UhrZeitWert(GridZeitEdit.Text) then
               begin
                 TztDatModified := true;
                 Zeit := GridZeitEdit.Text;
               end;
            else ;
          end;
        ColEditMode := false; // nicht ResetColEditMode, kein Event
        GridSnrRfidEdit.Text  := ''; // damit Modified immer false gesetzt wird
        GridZeitEdit.Text := '';
        BringToFront;
        if (Parent <> nil) and Parent.Visible and // sonst exception wenn Init in create
           Visible and CanFocus then SetFocus;    // kommt aber nicht vor
      finally
        StopPaint := Buf;
      end;
    end;

    if CanSelect then
    begin
      if (TztGrid.ItemCount > 0) and not TTztObj(TztGrid[ItemCount-1]).InitWert then // letzte Zeile nicht leer
      begin
        TTztColl(Collection).AddItem(TTztObj.Create(nil,TztColl,oaNoAdd)); // leeres Item am Ende
        CollectionUpdate; // RowCount gesetzt
        UpdateStatusBar;
      end;
      Invalidate; // ganze Zeile mit Rahmen neu zeichnen
    end;

  end;
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.TztGridSnrText(Item:Pointer): String;
//------------------------------------------------------------------------------
begin
  if Item = nil then
    Result := ''
  else
  with TztGrid do
    if ColEditMode and (TztColl.SortIndexOf(Item)=ItemIndex) and (Col=1) then
    begin
      Result := GridSnrRfidEdit.Text;
      // Format an TztObj.Snr anpassen, sonst nicht in TztColl gefunden
      if not RfidModus then
        Result := AddLeadZero(Result,4); // '0000' wenn S=''
    end else
      Result := TTztObj(Item).SnrRfid;
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.TztGridSnrAnzahl(Item:Pointer;SnrStr:String): String;
//------------------------------------------------------------------------------
// nicht RfidModus
begin
  if StrToIntDef(SnrStr,0) = 0 then Result := '-'
  else
    // SnrZahl entspricht Anzahl in SnrSortList, vor �nderung GridSnrRfidEdit
    if not SameText(SnrStr,TTztObj(Item).SnrRfid) then
      Result := IntToStr(TztColl.SnrSortList.SnrZahl(SnrStr) + 1) // Snr in GridSnrRfidEdit ge�ndert
    else
      Result := IntToStr(TztColl.SnrSortList.SnrZahl(SnrStr));
end;

//------------------------------------------------------------------------------
function TTztHauptDlg.TztGridSnrName(Item:Pointer;SnrStr:String): String;
//------------------------------------------------------------------------------
// nicht RfidModus
var Indx : Integer;
begin
  if (StrToIntDef(SnrStr,0) = 0) or (SnrNameListe.Count = 0) then Result := '-'
  else
    if SnrNameListe.Find(SnrStr,Indx) then
      Result := TNameObj(SnrNameListe.Objects[Indx]).Name
    else
      Result := strSnrUnbekannt;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.TztGridGetColText(Sender: TTriaGrid; Item: Pointer;
                                         ACol: Integer; var Value: string);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with TztGrid do
  begin
    Value := '';
    if Item = nil then Exit;
    case ACol of
      0: if TztColl.SortIndexOf(Item) < TztColl.SortCount-1 then
           Value := IntToStr(TztColl.SortIndexOf(Item)+1)
         else Value := '-';
      1: if RfidModus then
           if Length(TTztObj(Item).SnrRfid) > 0 then
             Value := TTztObj(Item).SnrRfid
           else
           if EditierMode and (ACol=Col) and
              (TztColl.SortIndexOf(Item)=ItemIndex) then
             Value := ''
           else Value := '-'
         else // Snr-Modus
         if StrToIntDef(TTztObj(Item).SnrRfid,0) > 0 then
           Value := Trim(RemLeadZero(TTztObj(Item).SnrRfid))
         else // Value = 0
         if Sender<>nil then Value := ''  // ColEdit
         else // TztGridDrawCell
         if EditierMode and (ACol=Col) and
            (TztColl.SortIndexOf(Item)=ItemIndex) then
           Value := ''
         else Value := '-';
      2: if UhrZeitWert(TTztObj(Item).Zeit) >= 0 then
           Value := TTztObj(Item).Zeit
         else // Value = -1
         if Sender <> nil then Value := ''   // ColEdit
         else // TztGridDrawCell
         if EditierMode and (ACol=Col) and
            (TztColl.SortIndexOf(Item)=ItemIndex) then
           case ZeitFormat of
             zfHundertstel : Value := '__:__:__'+DecTrennZeichen+'__';
             zfZehntel     : Value := '__:__:__'+DecTrennZeichen+'_';
             else            Value := '__:__:__';
           end
         else Value := '-';
      3: if SpalteTln then
           Value := TztGridSnrName(Item,TztGridSnrText(Item))
         else // SpalteZahl
           Value := TztGridSnrAnzahl(Item,TztGridSnrText(Item));
      4: Value := TztGridSnrAnzahl(Item,TztGridSnrText(Item));
    end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.TztGridKeyPress(Sender: TObject; var Key: Char);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Editiermode nicht mehr mit ESC ausschalten wegen remote Zeitnahme
//var Buf : Boolean;
begin
  {with Sender as TTriaGrid do
    if EnableOnClick then
    begin
      Buf := EnableOnClick;
      EnableOnClick := false;
      try
        case Word(Key) of
            VK_ESCAPE	: if (not ColEditMode) and ResetEditierMode  then // SnrRfidEdit focussieren
                        begin
                          SetzeFocus;
                          Key := #0;
                        end;
        end;
      finally
        EnableOnClick := Buf;
      end;
    end;}
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.TztGridMouseDown(Sender:TObject; Button:TMouseButton;
                                        Shift: TShiftState; X, Y: Integer);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var R: TRect;
    Spalte,Zeile: Integer;
begin
  // MousePosition f�r TztGridMouseUp und TztGridDrawCell speichern
  MouseX := X;
  MouseY := Y;
  if (Button = mbLeft) and not (ssDouble in Shift) then
  with TztGrid do
  begin
    MouseToCell(X, Y, Spalte, Zeile);
    if Assigned(ColEdits[Spalte]) then
      if Zeile = 0 then
      begin
        R := CellRect(Spalte,0);  // Col,Row
        TztGridDrawCell(Sender,Spalte,0,R,[gdFixed]); // Button Pressed
      end else
        SetzeEditierMode(Spalte,Zeile);
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTztHauptDlg.TztGridMouseUp(Sender:TObject; Button:TMouseButton;
                                      Shift: TShiftState; X, Y: Integer);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Spalte,Zeile: Integer;
begin
  if (Button = mbLeft) and not (ssDouble in Shift) then
  with TztGrid do
  begin
    // In Zelle (Zeile,Spalte) wurde geklickt
    MouseToCell(MouseX, MouseY, Spalte, Zeile);
    MouseX := -1;
    MouseY := -1;
    if Zeile = 0 then
      // MenuItems als Basis f�r SortMode wegen smFestSortiert
      if Spalte = 1 then
        if SnrAufAction.Checked then SnrAbActionExecute(nil)
                                else SnrAufActionExecute(nil)
      else if Spalte = 2 then
        if ZeitAufAction.Checked then ZeitAbActionExecute(nil)
                                 else ZeitAufActionExecute(nil);
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.TztGridDblClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with TztGrid do
    if ResetColEditMode and // sollte Ok sin
       (Col >= FixedCols) and (Row >= FixedRows) and  // sollte immer der Fall sein
       Assigned(ColEdits[Col]) then
      SetColEditMode; // ColEdits werden gesetzt
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.TztGridPaint(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Rahmen f�r fokussierte Zeile,
// Hintergrund muss vorher, sonst wird Text �berschrieben
  //..............................................................................
  procedure RahmenLinks(ARect: TRect);
  begin
    with TztGrid do
      Canvas.Polyline([Point(ARect.Right+1,ARect.Top-1),
                       Point(ARect.Left,ARect.Top-1),
                       Point(ARect.Left,ARect.Bottom),
                       Point(ARect.Right+1,ARect.Bottom)]);
  end;
  //..............................................................................
  procedure RahmenMitte(ARect: TRect);
  begin
    with TztGrid do
    begin
      Canvas.Polyline([Point(ARect.Left-1,ARect.Top-1),
                       Point(ARect.Right+1,ARect.Top-1)]);
      Canvas.Polyline([Point(ARect.Left-1,ARect.Bottom),
                       Point(ARect.Right+1,ARect.Bottom)]);
    end;
  end;
  //..............................................................................
  procedure RahmenRechts(ARect: TRect);
  begin
    with TztGrid do
      Canvas.Polyline([Point(ARect.Left-1,ARect.Top-1),
                       Point(ARect.Right,ARect.Top-1),
                       Point(ARect.Right,ARect.Bottom),
                       Point(ARect.Left-1,ARect.Bottom)]);
  end;
//..............................................................................
begin
  with TztGrid do
    if ColEditAssigned and
       (Col >= FixedCols) and (Row >= FixedRows) then // nicht �berschrift
    begin
      Canvas.Pen.Width := 1;
      Canvas.Pen.Style := psSolid;
        if (TztColl.Count>0) and
           ((SpalteZahl and(StrToIntDef(GetColText(GetCol(tsZahl),Row),0)>RndCheckZahl)) or
            (SpalteTln and (GetColText(GetCol(tsName),Row)=strSnrUnbekannt)) or
            (RfidModus and not ColEditMode and (GetColText(GetCol(tsSNr),Row) <> '-') and
             not RfidCodeValid(GetColText(GetCol(tsSnr),Row)))) then
         Canvas.Pen.Color := $00EEA8EE //clRed
      else
        Canvas.Pen.Color := $00FBD3B2;

      // Spalte 0
      RahmenLinks(CellRect(0,Row));
      // Spalte 1
      RahmenMitte(CellRect(1,Row));
      // Spalte 2
      if ColCount=3 then
        RahmenRechts(CellRect(2,Row))
      else // > 3
        RahmenMitte(CellRect(2,Row));
      // Spalte 3
      if ColCount = 4 then
        RahmenRechts(CellRect(3,Row))
      else // > 3
        if ColCount > 4 then
          RahmenMitte(CellRect(3,Row));
      // Spalte 4
      if ColCount = 5 then
        RahmenRechts(CellRect(4,Row))
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztHauptDlg.TztGridDrawCell(Sender: TObject; ACol,ARow: Integer;
                                       Rect: TRect; State: TGridDrawState);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//TGridDrawState = set of (gdSelected, gdFocused, gdFixed);
var TztObj : TTztObj;
    Spalte,Zeile : Integer;
    Text : String;
    TextLinks, TextOben,
    PfeilHoehe,
    PfeilLinks,
    PfeilOben:  Integer;

  //..............................................................................
  procedure PfeilAuf;
  begin
    TztGrid.Canvas.Polygon([Point(PfeilLinks + PfeilHoehe,PfeilOben),
                            Point(PfeilLinks + 2*PfeilHoehe,PfeilOben+PfeilHoehe),
                            Point(PfeilLinks,PfeilOben+PfeilHoehe)]);
  end;
  //..............................................................................
  procedure PfeilAb;
  begin
    TztGrid.Canvas.Polygon([Point(PfeilLinks,PfeilOben),
                            Point(PfeilLinks + 2*PfeilHoehe,PfeilOben),
                            Point(PfeilLinks+ PfeilHoehe,PfeilOben+PfeilHoehe)]);
  end;
  //..............................................................................
  procedure PfeilZeichnen;
  var BrushAlt : TColor;
  begin
    BrushAlt := TztGrid.Canvas.Brush.Color;
    TztGrid.Canvas.Brush.Color := clWindowText;
    case TztColl.SortMode of
      smTztZeitAuf : if ACol = 2 then PfeilAuf;
      smTztZeitAb  : if ACol = 2 then PfeilAb;
      smTztSnrAuf  : if ACol = 1 then PfeilAuf;
      smTztSnrAb   : if ACol = 1 then PfeilAb;
    end;
    TztGrid.Canvas.Brush.Color := BrushAlt;
  end;
  //..............................................................................
  function PfeilBreite: Integer;
  begin
    Result := 0;
    case TztColl.SortMode of
      smTztZeitAuf,smTztZeitAb  : if ACol = 2 then Result := 4*PfeilHoehe;
      smTztSnrAuf,smTztSnrAb    : if ACol = 1 then Result := 4*PfeilHoehe;
    end;
  end;
  //..............................................................................
  function BrushColor: TColor;
  begin
    with Sender as TTriaGrid do
      if ARow < FixedRows then // �berschrift
         Result := clBtnFace
      else // Datenzeilen
      if ARow = Row then // Focus
        if ((ACol=1) or (ACol=2)) and
           (ACol = Col) and TztGrid.EditierMode then
          Result := clWindow // weiss
        else
        if (TztColl.Count>0) and
           ((SpalteZahl and(StrToIntDef(GetColText(GetCol(tsZahl),ARow),0)>RndCheckZahl)) or
            (SpalteTln and (GetColText(GetCol(tsName),ARow)=strSnrUnbekannt)) or
            (RfidModus and not ColEditMode and (GetColText(GetCol(tsNr),ARow) <> '-') and
             not RfidCodeValid(GetColText(GetCol(tsSnr),ARow)))) then
          Result := $00FFE0FF // violett, ganze Zeile
        else
          Result := $00FFF6EF // hellblau

      else // kein Focus
        if (ACol = 1) or (ACol = 2) then
          Result := clWindow // weiss
        else
          Result := $00FBFBFB // hellgrau
  end;
  //..............................................................................
  function FontColor: TColor;
  begin
    with Sender as TTriaGrid do
    begin
      if ACol = 0 then
        Result := $00808080 // grau
      else
        Result := clWindowText; // schwarz
      if (ARow >= FixedRows) and (TztColl.Count>0) then // Datenzeilen
        if (ACol=GetCol(tsName)) and SpalteTln and
           (GetColText(GetCol(tsName),ARow)=strSnrUnbekannt) then
          Result := clRed
        else
        if (ACol=GetCol(tsZahl)) and // Spalte Anzahl
           SpalteZahl and (StrToIntDef(GetColText(GetCol(tsZahl),ARow),0) > RndCheckZahl) then
          Result := clRed
        else
        if (ACol=GetCol(tsSnr)) and RfidModus and // Spalte Rfid
           (GetColText(GetCol(tsSNr),ARow) <> '-') and
           not RfidCodeValid(GetColText(GetCol(tsSnr),ARow)) then
         Result := clRed;
    end;
  end;

//..............................................................................
begin
  with Sender as TTriaGrid do
  begin
    // MouseX,MouseY wird in TztGridMouseDown = Mouse-Position(X,Y) gesetzt
    // und in TztGridMouseUp = -1 gesetzt
    MouseToCell(MouseX, MouseY, Spalte, Zeile);
    Text := ''; // dummy leerzeile wenn itemcount = 0

    Canvas.Brush.Color := BrushColor;
    Canvas.Font.Color  := FontColor;

    if ARow < FixedRows then // �berschrift
    begin
      Canvas.FillRect(Rect);
      Canvas.Pen.Color := clWindowText;
      Canvas.Pen.Width := 1;
      Canvas.Pen.Style := psSolid;
      // Font nur vor�bergehend f�r Row=0 umschalten
      Canvas.Font.Name := Font.Name;
      Canvas.Font.Size := AlfFontSize;
      PfeilHoehe := AlfTextHoehe DIV 4;
      TextOben := Rect.Top + (Rect.Bottom-Rect.Top - AlfTextHoehe) DIV 2;
      PfeilOben := TextOben + (AlfTextHoehe - PfeilHoehe) DIV 2;
      case ACol of
        0: Text := 'Nr.';
        1: if RfidModus then
             Text := 'RFID-Code'
           else
             Text := 'Startnr.';
        2: Text := 'Zeit';
        3: if SpalteTln then
             Text := 'Name, Vorname'
           else // SpalteZahl
             Text := 'Anzahl';
        4: Text := 'Anzahl';
      end;
      if (ACol<>1) and (ACol<>2) then // kein Pfeil
      begin
        if (ACol=3) and SpalteTln then // Name, VorName
          TextLinks := Rect.Left + Canvas.TextWidth('0')
        else // zentrieren
          TextLinks := Rect.Left +
                       (Rect.Right-Rect.Left - Canvas.TextWidth(Text)) DIV 2;
        PfeilLinks := 0;
      end else
      begin
        TextLinks := Rect.Left +
                     (Rect.Right-Rect.Left - Canvas.TextWidth(Text) - PfeilBreite) DIV 2;
        PfeilLinks := TextLinks + Canvas.TextWidth(Text) + PfeilHoehe*2;
      end;
      if (ACol<>1) and (ACol<>2) and (ARow=Zeile) and (ACol=Spalte) then  // Mouse pressed
      begin
        Inc(TextOben);
        Inc(TextLinks);
        Canvas.TextOut(TextLinks, TextOben, Text);
        Inc(PfeilOben);
        Inc(PfeilLinks);
        PfeilZeichnen;
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Polyline([Point(Rect.Left, Rect.Bottom-1),
                         Point(Rect.Left,Rect.Top),
                         Point(Rect.Right,Rect.Top)]);
      end else // not pressed
      begin
        Canvas.TextOut(TextLinks, TextOben, Text);
        if (ACol=1) or (ACol=2) then PfeilZeichnen;
        Canvas.Pen.Color := clWindow;
        Canvas.Polyline([Point(Rect.Left, Rect.Bottom-1),
                         Point(Rect.Left,Rect.Top),
                         Point(Rect.Right,Rect.Top)]);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Polyline([Point(Rect.Left+1, Rect.Bottom-1),
                         Point(Rect.Right-1,Rect.Bottom-1),
                         Point(Rect.Right-1,Rect.Top)]);
      end;
      // Font zur�cksetzen
      Canvas.Font.Name := NumFontName;
      Canvas.Font.Size := NumFontSize;
    end
    else // Datenzeilen
    begin
      Canvas.FillRect(Rect); // Hintergrund
      // Text
      if ARow < ItemCount + FixedRows then // FixedRows = 1
        TztObj := Items[ARow - FixedRows]
      else TztObj := nil;
      if TztObj = nil then Exit;
      Text := GetColText(ACol,ARow); // kein Text unter ColEdit
      case ACol of
        0: TextLinks := Rect.Left +
                        (Rect.Right-Rect.Left-Canvas.TextWidth(Text)) DIV 2; // Nr.
        1: if RfidModus then // RFID-Code
             TextLinks := Rect.Left + (Rect.Width - GridSnrRfidEdit.Width) DIV 2  // linksb�ndig
           else // Snr
             TextLinks := Rect.Left + (Rect.Width - GridSnrRfidEdit.Width) DIV 2 +
                          GridSnrRfidEdit.Width - Canvas.TextWidth(Text); // rechtsb�ndig
        2: if Text = '-' then // zentrieren
             TextLinks := Rect.Left +
                          (Rect.Right-Rect.Left-Canvas.TextWidth('-')) DIV 2
           else
             TextLinks := Rect.Left +
                          (Rect.Right-Rect.Left-Canvas.TextWidth(UhrZeitStr(0))) DIV 2;
        3: if SpalteTln then // Spalte TlnName
             TextLinks := Rect.Left + Canvas.TextWidth('0')
           else // Spalte Anzahl
             TextLinks := Rect.Left +
                          (Rect.Right-Rect.Left-Canvas.TextWidth(Text)) DIV 2;
        else // Spalte Anzahl
          TextLinks := Rect.Left +
                       (Rect.Right-Rect.Left-Canvas.TextWidth(Text)) DIV 2;
      end;
      Canvas.TextOut(TextLinks, Rect.Top + TztGrid.TopAbstand, Text);
    end;
  end;
end;


end.
