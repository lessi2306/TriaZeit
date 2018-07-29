unit TztAbglDlg;
// nicht in RfidModus

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, Math,
  AllgConst, AllgObj, AllgComp, TztAllg, Mask, ExtCtrls;

procedure SnrAbgleichen;

type

  TAbglAktion = (aaKein,aaSnrFehlt,aaZeitFehlt,aaSync,aaSnrImpOk,aaSnrImpNOk,aaSnrAbgl);
  
  TAbglObj = class(TTriaObj)
  public
    ImpSnr,
    AktSnr,
    AktZeit : String;
    ImpNr,
    TztNr : Integer;
    Aktion: TAbglAktion;
    constructor Create(Veranst:Pointer;Collection:TTriaObjColl;Add:TOrtAdd);override;
    procedure   SetzeAktion(BlockOk:Boolean);
    function    Komment: String;
    function    AktionsFarbe: TColor;
    function    AktionsHintergrundFarbe: TColor;
    function    ObjSize: Integer; override;
    procedure   OrtCollAdd; override;
    procedure   OrtCollClear(Indx:Integer); override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
  end;

  TAbglColl = class(TTriaObjColl)
  protected
    function    GetPItem(Indx:Integer): TAbglObj;
    procedure   SetPItem(Indx:Integer; Item:TAbglObj);
  public
    constructor Create(Veranst:Pointer;ItemClass:TTriaObjClass);
    function    AddSortItem(Item:Pointer): Integer; override;
    function    SortString(Item:Pointer): String; override;
    procedure   SetzeAktionen;
    function    AktionsZahl(Akt:TAbglAktion): Integer;
    property    PItems[Indx: Integer]: TAbglObj read GetPItem write SetPItem; default;
  end;

  TAbglDialog = class(TForm)
    AbglGrid: TTriaGrid;
    AendernBtn: TButton;
    SnrDateiEdit: TTriaEdit;
    HilfeButton: TButton;
    CancelButton: TButton;
    ImpSnrEdit: TTriaMaskEdit;
    TztSnrEdit: TTriaMaskEdit;
    TztZeitEdit: TUhrZeitEdit;
    StatusGB: TGroupBox;
    SnrIdentLabel: TLabel;
    SnrUebernLabel: TLabel;
    EintrFehltLabel: TLabel;
    SnrIdentZahl: TLabel;
    SnrUebernZahl: TLabel;
    EintrFehltZahl: TLabel;
    AnsichtRG: TRadioGroup;
    SnrPanel: TPanel;
    ZeitPanel: TPanel;
    ZeitDateiLabel: TLabel;
    ZeitDateiEdit: TTriaEdit;
    SnrDateiLabel: TLabel;
    AbglBtn: TButton;

    // Event Handler
    procedure AnsichtRGClick(Sender: TObject);
    procedure AbglGridSelectCell(Sender:TObject;ACol,ARow:Integer;var CanSelect:Boolean);
    procedure AbglGridDrawCell(Sender:TObject;ACol,ARow:Integer;Rect:TRect;State:TGridDrawState);
    procedure GridSnrEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure AbglGridGetColText(Sender:TTriaGrid;Item:Pointer;ACol:Integer;var Value:string);
    procedure AendernBtnClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DateiEditClick(Sender: TObject);
    procedure AbglBtnClick(Sender: TObject);
    procedure AbglGridDblClick(Sender: TObject);
    procedure AbglGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
                                X, Y: Integer);
    procedure AbglGridMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
                              X, Y: Integer);

  protected

  private
    HelpFensterAlt : TWinControl;
    Initialisiert  : Boolean;
    Updating       : Boolean;
    DisableButtons : Boolean;
    TztBuffColl    : TTztColl; // zunächst in Buff ändern um vergleichen zu können
    Rand           : Integer;
    function  EingabeOK: Boolean;
    procedure SetzeStatusGB;
    procedure SetzeButtons;
    procedure Abgleichen(ARow: Integer);
    procedure CMDialogKey(Var Msg: TWMKey); message CM_DIALOGKEY;

  public
    MouseX, MouseY, ColAlt,RowAlt : Integer;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  SnrDatei   : Textfile; // für lesen
  SnrImpColl : TIntegerCollection;
  TztImpColl : TTztColl;
  AbglColl   : TAbglColl;
  AbglDialog : TAbglDialog;

const
  chGridColor = $00FAFAFA; // wann benutzt? default=clWindow
  chSnrImpOk  = $00D0FFD0; // grün
  chSnrImpNOk = $00C0FFFF; // gelb
  chSnrAbgl   = $00FFDBBF; // blau
  chZeitFehlt = $00FFC0FF; // violett
  //chSnrFehlt  = $00D0D0FF; // rot
  //chKein      = $00C0E0FF; // orange
  caZeitFehlt = clRed;
  caSnrImpOk  = clGreen;
  caSnrImpNOk = clYellow;
  caSnrAbgl   = clBlue;

implementation

uses TztMain,TztHistory,TztDat,AllgFunc,VistaFix;

{$R *.dfm}

function  SnrDateiLesen(Pfad:String): Boolean; forward;
function  TztCollLesen: Boolean; forward;
procedure InitAbglColl; forward;
function  AbglInitWert(Item:TAbglObj): Boolean; forward;


//******************************************************************************
function AbglInitWert(Item:TAbglObj): Boolean;
//******************************************************************************
begin
  Result := (Item <> nil) and
            (Item.ImpNr = 0)  and
            (Item.TztNr = 0)  and
            (StrToIntDef(Item.ImpSnr,0) = 0) and
            (StrToIntDef(Item.AktSnr,0) = 0) and
            (UhrZeitWert(Item.AktZeit) < 0);
end;

(******************************************************************************)
procedure SnrAbgleichen;
(******************************************************************************)
var S,Pfad: String;
begin
  if (TztColl.SortCount = 1) and TztColl.SortItems[0].InitWert then
  begin
    TriaMessage('Die Zeitdatei ist leer. Abgleich nicht möglich.', mtInformation,[mbOk]);
    Exit;
  end;

  Pfad := '';
  if TztDatGeladen then S := SysUtils.ExtractFileDir(TztDatName)
                   else Exit; // gibt es nicht
  if OpenFileDialog('trz', //const DefExt: string
                    'TriaZeit Dateien (*.trz)|*.trz|Alle Dateien (*.*)|*.*',//Filter: string
                    S, //InitialDir: string
                    1, // trz-Datei
                    'Öffnen',//Title: string
                    Pfad) then //var FileName: string
  try
    if TztColl.SortMode <> smTztZeitAuf then
      TztHauptDlg.SetSortMode(smTztZeitAuf);
    TztHauptDlg.Refresh;

    SnrImpColl := TIntegerCollection.Create(nil);
    if (Pfad='') or not SysUtils.FileExists(Pfad) or
       not SnrDateiLesen(Pfad) then Exit;

    TztImpColl := TTztColl.Create(nil,TTztObj);
    TztImpColl.SortMode := smTztZeitAuf;
    if not TztCollLesen then Exit;

    // beide Dateien Count > 0
    AbglColl := TAbglColl.Create(nil,TAbglObj);
    InitAbglColl;
    AbglDialog := TAbglDialog.Create(TztHauptDlg);
    with AbglDialog do
    begin
      SnrDateiEdit.Text  := SysUtils.ExtractFileName(Pfad);
      ZeitDateiEdit.Text := SysUtils.ExtractFileName(TztDatName);
      PopupParent := TztHauptDlg; // VistaFix
      ShowModal;
    end;

  finally
    FreeAndNil(AbglDialog);
    FreeAndNil(SnrImpColl);
    FreeAndNil(TztImpColl);
    FreeAndNil(AbglColl);

  end
  else TztHauptDlg.Refresh;
end;

(******************************************************************************)
function SnrDateiLesen(Pfad:String): Boolean;
(******************************************************************************)
// eingelesen in gespeicherte Reihenfolge
// jede beliebige Textdatei mit Startnummer am Anfang, 1 bis 4 Zeichen (0-9999)
// Rest der Zeile ignoriert
var Zeile,
    SnrStr,
    Ext      : String;
    SnrInt,
    i,L      : Integer;
    IOFehler,
    Leer     : Boolean;
begin
  Result     := false;
  IOFehler   := false;
  Leer       := true;

  try
    (*$I-*)
    AssignFile(SnrDatei,Pfad);
    SetLineBreakStyle(SnrDatei,tlbsCRLF); // nur beim Schreiben von Bedeutung
    Reset(SnrDatei);
    if IoResult<>0 then begin IOFehler := true; Exit; end;

    Ext := SysUtils.ExtractFileExt(Pfad);
    while not Eof(SnrDatei) do
    begin
      Leer := false;
      ReadLn(SnrDatei,Zeile);
      if IoResult<>0 then begin IOFehler := true; Exit; end;
      L := Length(Zeile);
      if L = 0 then Exit;

      // erste 1 bis 4 Ziffern als Snr einlesen
      SnrStr := '';
      for i:=1 to Min(L,4) do
        if CharInSet(Zeile[i],['0'..'9']) then
          SnrStr := SnrStr + Zeile[i]
        else Break;
      if (SnrStr='') or not TryDecStrToInt(SnrStr,SnrInt) or (SnrInt < 0) then
        Exit
      else // Snr=0 zulassen
        SnrImpColl.Add(SnrInt);
    end;
    if not Leer then Result := true;

  finally
    CloseFile(SnrDatei);
    IoResult;
    (*$I+*)
    if not Result then
      if IOFehler then
        TriaMessage('Fehler beim Lesen der Datei  "'+SysUtils.ExtractFileName(Pfad)+'".',
                     mtInformation,[mbOk])
      else
      if Leer then
        TriaMessage('Die Datei  "'+SysUtils.ExtractFileName(Pfad)+'"  ist leer.',
                     mtInformation,[mbOk])
      else // nicht leer, kein IOFehler
        TriaMessage('Inhalt der Datei  "'+SysUtils.ExtractFileName(Pfad)+'"  ist ungültig.',
                     mtInformation,[mbOk]);
  end;
end;

(******************************************************************************)
function TztCollLesen: Boolean;
(******************************************************************************)
// TztColl in Buffer (TztImpColl) einlesen
var i      : Integer;
    TztObj : TTztObj;
begin
  Result := false;
  try
    for i:= 0 to TztColl.SortCount-2 do  // SortMode = smTztZeitAuf
      with TztColl.SortItems[i] do
      begin
        TztObj := TTztObj.Create(nil,TztImpColl,oaNoAdd);
        TztObj.Init(SnrRfid,Zeit);
        TztImpColl.AddItem(TztObj); // alles einlesen, InitWert sollte nicht vorkommen
      end;
    if (TztColl.SortCount>0) and not TztColl.SortItems[TztColl.SortCount-1].InitWert then // InitWert am Ende ignorieren
      with TztColl.SortItems[TztColl.SortCount-1] do
      begin
        TztObj := TTztObj.Create(nil,TztImpColl,oaNoAdd);
        TztObj.Init(SnrRfid,Zeit);
        TztImpColl.AddItem(TztObj);
      end;

    if TztImpColl.Count > 0 then Result := true;
  except
  end;
end;

(******************************************************************************)
procedure InitAbglColl;
(******************************************************************************)
// SnrImpColl und TztImpColl zusammenführen,
// SnrImpColl und TztImpColl vorher eingelesen
// AbglColl vorher erstellt
var i,SnrIndx,TztIndx,
    Stap,
    SnrStapMax,TztStapMax : Integer;
    SyncGefunden : Boolean;
    //DiffGefunden : Boolean;
    SnrDelta : Integer;

//..............................................................................
  procedure AddAbglItem(SnrNeuIndx,TztNeuIndx:Integer);
  var AbglObj : TAbglObj;
      IntBuf : Integer;
  begin
    AbglObj := TAbglObj.Create(nil,AbglColl,oaNoAdd);
    //ImpNr=0;TztNr=0;ImpSnr='0';AktSnr='0';AktZeit=ZeitInitWert;Aktion=aaKein;

    with AbglObj do
    begin
      if (SnrNeuIndx >= 0) and (SnrNeuIndx < SnrImpColl.Count) then
      begin
        ImpNr := SnrNeuIndx+1; // erste Item mit Nr. 1
        if SnrImpColl[SnrNeuIndx] > 0 then
          ImpSnr := IntToStr(SnrImpColl[SnrNeuIndx])
        else ImpSnr := '0';
      end;
      if (TztNeuIndx >= 0) and (TztNeuIndx < TztImpColl.Count) then
      begin
        TztNr := TztNeuIndx + 1; // erste Item mit Nr. 1
        IntBuf := StrToIntDef(TztImpColl[TztNeuIndx].Snrrfid,0);
        if IntBuf > 0 then
          AktSnr := IntToStr(IntBuf)
        else AktSnr := '0';
        AktZeit := TztImpColl[TztNeuIndx].Zeit;
        //else Snr = '0', Zeit = ZeitInitWert ('  :  :  ' abhängig von ZeitFormat);
      end;
      AbglColl.AddItem(AbglObj);
    end;
  end;

//..............................................................................
  procedure Aufholen(SnrNextIndx,TztNextIndx: Integer);
  // bis nächster Sync oder Ende (Sync = beide Snr gleich)
  begin
    // Aufholen bis Sync
    while (SnrIndx < SnrNextIndx) or (TztIndx < TztNextIndx) do
    begin
      if SnrIndx < SnrNextIndx then
      begin
        if TztIndx < TztNextIndx then // Snr und Tzt vorhanden
        begin
          AddAbglItem(SnrIndx,TztIndx); // gelb Snr abgleichen
          Inc(TztIndx);
        end else // nur Snr vorhanden
          AddAbglItem(SnrIndx,-1);      // violet, ignorieren
        Inc(SnrIndx);
      end else
        if TztIndx < TztNextIndx then // nur Tzt vorhanden
        begin
          AddAbglItem(-1,TztIndx);
          Inc(TztIndx);
        end;
    end;
    // Sync übernehmen
    if (SnrIndx < SnrImpColl.Count) and (TztIndx < TztImpColl.Count) then
      AddAbglItem(SnrIndx,TztIndx);
  end;

//..............................................................................
  function SnrGleich(SnrCollIdx,TztCollIdx:Integer): Boolean;
  begin
    Result := (SnrCollIdx >= 0) and (SnrCollIdx < SnrImpColl.Count) and
              (TztCollIdx >= 0) and (TztCollIdx < TztImpColl.Count) and
              (SnrImpColl[SnrCollIdx] <> 0) and
              (SnrImpColl[SnrCollIdx] = StrToIntDef(TztImpColl[TztCollIdx].SnrRfid,0));
  end;

//..............................................................................
  function SyncZahl(SnrStart,TztStart: Integer): Integer;
  var i,SnrCount,MaxIdx : Integer;
  const cnMaxSyncCount = 5; // nur nächste 5 gültige Einträge berücksichtigen
  begin
    Result   := 0;
    i        := 0;
    SnrCount := 0;
    while (SnrCount < cnMaxSyncCount) and (SnrStart+i < SnrImpColl.Count-1) do
    begin
      Inc(i);
      if SnrImpColl[SnrStart+i] > 0 then Inc(SnrCount);
    end;
    MaxIdx := i;
    i := 0;
    SnrCount := 0;
    while (SnrCount < cnMaxSyncCount) and (TztStart+i < TztImpColl.Count-1) do
    begin
      Inc(i);
      if StrToIntDef(TztImpColl[TztStart+i].SnrRfid,0) > 0 then Inc(SnrCount);
    end;
    MaxIdx := Min(MaxIdx,i);

    // zähle Syncs bis zu cnMaxSyncCount gültige Snr- und Tzt-Einträge
    for i:=1 to MaxIdx do
      if SnrGleich(SnrStart+i,TztStart+i) then Inc(Result);
  end;

//..............................................................................
begin
  if SnrImpColl.Count = 0 then Exit;
  if TztImpColl.Count = 0 then Exit;

  AbglColl.Clear;

  SnrDelta := SnrImpColl.Count - TztImpColl.Count;
  SnrIndx := 0;
  TztIndx := 0;

  while (SnrIndx < SnrImpColl.Count) or (TztIndx < TztImpColl.Count) do
  begin
    SnrStapMax   := SnrImpColl.Count - SnrIndx - 1;
    TztStapMax   := TztImpColl.Count - TztIndx - 1;
    SyncGefunden := false;

    for Stap:=0 to Max(SnrStapMax,TztStapMax) do
    begin

      // zuerst bei gleichem Index auf Sync prüfen
      if SnrGleich(SnrIndx+Stap,TztIndx+Stap) then
      begin
        Aufholen(SnrIndx+Stap,TztIndx+Stap); // Items incl. sync übernehmen
        SyncGefunden := true;
        Break; // for Stap... loop
      end;

      // auf 1-fach Überholung prüfen
      if (Stap > 0) and
         SnrGleich(SnrIndx+Stap,TztIndx+Stap-1) and
         SnrGleich(SnrIndx+Stap-1,TztIndx+Stap) then
      begin
        Aufholen(SnrIndx+Stap,TztIndx+Stap); // Items incl. sync übernehmen
        SyncGefunden := true;
        Break; // for Stap... loop
      end;

      // auf 2-fach Überholung prüfen
      if (Stap > 0) and
         (SnrIndx+Stap+1 < SnrImpColl.Count) and (TztIndx+Stap+1 < TZtImpColl.Count) and
         SnrGleich(SnrIndx+Stap+1,TztIndx+Stap-1) and
         SnrGleich(SnrIndx+Stap,TztIndx+Stap+1) and
         SnrGleich(SnrIndx+Stap-1,TztIndx+Stap) or
         SnrGleich(SnrIndx+Stap+1,TztIndx+Stap) and
         SnrGleich(SnrIndx+Stap,TztIndx+Stap-1) and
         SnrGleich(SnrIndx+Stap-1,TztIndx+Stap+1) then
      begin
        Aufholen(SnrIndx+Stap+1,TztIndx+Stap+1); // Items incl. sync übernehmen
        SyncGefunden := true;
        Break; // for Stap... loop
      end;

      // asymmetrische Syncs suchen
      for i:=1 to Stap do // Stap > 0
      begin
        // Zahl der Datei-Einträge bei Wertung berücksichtigen
        if SnrDelta = 0 then // Bei asymm. Sync wahrscheinlich Überholung oder falsche Snr
          if SnrGleich(SnrIndx+Stap,TztIndx+Stap-i) then
            // nur wenn in den nächsten cnMaxSyncCount Items mehr cnDeltaSync
            // asymmetrische Syncs als neuer Sync werten
            if SyncZahl(SnrIndx+Stap,TztIndx+Stap-i) > SyncZahl(SnrIndx+Stap,TztIndx+Stap) then // neuer Sync, Tzt fehlt
            begin
              Aufholen(SnrIndx+Stap,TztIndx+Stap-i); // Items incl. sync übernehmen
              SyncGefunden := true;
              Break; // for Stap... loop
            end
            else Continue // kein Sync, weitersuchen
          else
          if SnrGleich(SnrIndx+Stap-i,TztIndx+Stap) then
            // nur wenn in den nächsten cnMaxSyncCount Items mehr cnDeltaSync
            // asymmetrische als symmetrische Syncs als Asym Sync werten
            if SyncZahl(SnrIndx+Stap-i,TztIndx+Stap) > SyncZahl(SnrIndx+Stap,TztIndx+Stap) then // neuer Sync, Snr fehlt
            begin
              Aufholen(SnrIndx+Stap-i,TztIndx+Stap); // Items incl. sync übernehmen
              SyncGefunden := true;
              Break; // for Stap... loop
            end
            else Continue // kein Sync, weitersuchen
          else Continue // kein Sync, weitersuchen

        else
        if SnrDelta > 0 then // bei asymm. Sync fehlt wahrscheinlich ZeitEintrag
          if SnrGleich(SnrIndx+Stap,TztIndx+Stap-i) then
            // nur wenn in den nächsten cnMaxSyncCount Items mehr cnDeltaSync-SnrDelta
            // asymmetrische als symmetrische Syncs als Asym Sync werten
            if SyncZahl(SnrIndx+Stap,TztIndx+Stap-i) > SyncZahl(SnrIndx+Stap,TztIndx+Stap)-SnrDelta then // neuer Sync, Tzt fehlt
            begin
              Aufholen(SnrIndx+Stap,TztIndx+Stap-i); // Items incl. sync übernehmen
              SyncGefunden := true;
              Break; // for Stap... loop
            end
            else Continue // kein Sync, weitersuchen
          else
          if SnrGleich(SnrIndx+Stap-i,TztIndx+Stap) then // unwahrscheinlich
            // nur wenn in den nächsten cnMaxSyncCount Items mehr cnDeltaSync+SnrDelta
            // asymmetrische als symmetrische Syncs als Asym Sync werten
            if (SyncZahl(SnrIndx+Stap-i,TztIndx+Stap) > SyncZahl(SnrIndx+Stap,TztIndx+Stap)+SnrDelta) then // neuer Sync, Snr fehlt
            begin
              Aufholen(SnrIndx+Stap-i,TztIndx+Stap); // Items incl. sync übernehmen
              SyncGefunden := true;
              Break; // for Stap... loop
            end
            else Continue // kein Sync, weitersuchen
          else Continue // kein Sync, weitersuchen

        else // SnrDelta < 0,  bei asymm. Sync fehlt wahrscheinlich SnrEintrag
          if SnrGleich(SnrIndx+Stap-i,TztIndx+Stap) then
            // nur wenn in den nächsten cnMaxSyncCount Items mehr cnDeltaSync+SnrDelta
            // asymmetrische als symmetrische Syncs als Asym Sync werten
            if (SyncZahl(SnrIndx+Stap-i,TztIndx+Stap) > SyncZahl(SnrIndx+Stap,TztIndx+Stap)+SnrDelta) then // neuer Sync, Snr fehlt
            begin
              Aufholen(SnrIndx+Stap-i,TztIndx+Stap); // Items incl. sync übernehmen
              SyncGefunden := true;
              Break; // for Stap... loop
            end
            else Continue // kein Sync, weitersuchen
          else
          if SnrGleich(SnrIndx+Stap,TztIndx+Stap-i) then // unwahrscheinlicher
            // nur wenn in den nächsten cnMaxSyncCount Items mehr cnDeltaSync-SnrDelta
            // asymmetrische als symmetrische Syncs als Asym Sync werten
            if SyncZahl(SnrIndx+Stap,TztIndx+Stap-i) > SyncZahl(SnrIndx+Stap,TztIndx+Stap)-SnrDelta then // neuer Sync, Tzt fehlt
            begin
              Aufholen(SnrIndx+Stap,TztIndx+Stap-i); // Items incl. sync übernehmen
              SyncGefunden := true;
              Break; // for Stap... loop
            end
            else Continue // kein Sync, weitersuchen
          else Continue // kein Sync, weitersuchen
      end;

      if SyncGefunden then Break;
    end;

    if SyncGefunden then // nächster Sync suchen
    begin
      Inc(SnrIndx);
      Inc(TztIndx);
    end else // restliche Snr und Tzt übernehmen
      Aufholen(SnrImpColl.Count,TztImpColl.Count);

    SnrDelta := Max(SnrImpColl.Count-SnrIndx,0) - Max(TztImpColl.Count-TztIndx,0);
  end;

  // Am Ende Aktionen definieren
  AbglColl.SetzeAktionen;

end;


(******************************************************************************)
(*                   Methoden von TAbglObj                                    *)
(******************************************************************************)

//******************************************************************************
constructor TAbglObj.Create(Veranst:Pointer; Collection:TTriaObjColl;Add:TOrtAdd);
//******************************************************************************
begin
  inherited Create(Veranst,Collection,oaNoAdd);
  ImpNr   := 0;
  TztNr   := 0;
  ImpSnr  := '0';
  AktSnr  := '0';
  AktZeit := ZeitInitWert;
  Aktion  := aaKein;
end;

//******************************************************************************
procedure TAbglObj.SetzeAktion(BlockOk:Boolean);
//******************************************************************************
// ImpSnr als richtig betrachten
// unabhängig von ImpNr,TztNr, weil Felder editiert werden können
begin
  AbglColl.ClearSortItem(Self);
  if UhrZeitWert(AktZeit) < 0 then // Tzt-Eintrag fehlt
    if StrToIntDef(ImpSnr,0) = 0 then // ImpSnr fehlt, löschen
      Aktion := aaKein // kein Eintrag
    else
      Aktion := aaZeitFehlt // Zeit fehlt, löschen

  else // Tzt-Eintrag vorhanden

  if StrToIntDef(ImpSnr,0) = 0 then // ImpSnr fehlt
    Aktion := aaSnrFehlt // Tzt-Eintrag löschen, auch wenn TztSnr vorhanden

  else // Abgleich- und Tzt-Eintrag vorhanden
  if StrToIntDef(ImpSnr,0) = StrToIntDef(AktSnr,0) then
    Aktion := aaSync // Snr identisch, keine Aktion
  else
  if StrToIntDef(AktSnr,0) > 0 then // Tzt-Snr vorhanden
    Aktion := aaSnrAbgl // ImpSnr übernehmen
  else // AktSnr = 0, ImpSnr übernehmen
  if BlockOk then Aktion := aaSnrImpOk
             else Aktion := aaSnrImpNOk;
  AbglColl.AddSortItem(Self)
end;

//******************************************************************************
function TAbglObj.Komment: String;
//******************************************************************************
begin
  case Aktion of
    aaKein      : Result := 'Startnr. und Zeit fehlen';
    aaSnrFehlt  : Result := 'Startnr. fehlt, Eintrag löschen';
    aaZeitFehlt : Result := 'Zeit fehlt, Eintrag löschen';
    aaSync      : Result := 'Startnr. identisch';
    aaSnrImpOk  : Result := 'Startnr. abgleichen';
    aaSnrImpNOk : Result := 'Startnr. abgleichen';
    aaSnrAbgl   : Result := 'Startnr. abgleichen';
  end;
end;

//******************************************************************************
function TAbglObj.AktionsFarbe: TColor;
//******************************************************************************
begin
  case Aktion of
    aaKein,
    aaSnrFehlt,
    aaZeitFehlt   : Result := caZeitFehlt;
    aaSync        : Result := clBtnShadow;
    aaSnrImpOk    : Result := caSnrImpOk;
    aaSnrImpNOk   : Result := caSnrImpNOk;
    else{aaSnrAbgl} Result := caSnrAbgl; // Warnung vermeiden
  end;
end;

//******************************************************************************
function TAbglObj.AktionsHintergrundFarbe: TColor;
//******************************************************************************
begin
  case Aktion of
    aaKein,
    aaSnrFehlt,
    aaZeitFehlt   : Result := chZeitFehlt;
    aaSync        : Result := clWindow;
    aaSnrImpOk    : Result := chSnrImpOk;
    aaSnrImpNOk   : Result := chSnrImpNOk;
    else{aaSnrAbgl} Result := chSnrAbgl; // Warnung vermeiden
  end;
end;

//******************************************************************************
function TAbglObj.ObjSize: Integer;
//******************************************************************************
// Dummy um Compiler-Warnung zu vermeiden
begin
  Result := 0;
end;

//******************************************************************************
procedure TAbglObj.OrtCollAdd;
//******************************************************************************
begin
  // nur um Compilerwarnung zu vermeiden
end;

//******************************************************************************
procedure TAbglObj.OrtCollClear(Indx:Integer);
//******************************************************************************
begin
  // nur um Compilerwarnung zu vermeiden
end;

//******************************************************************************
procedure TAbglObj.OrtCollExch(Idx1,Idx2:Integer);
//******************************************************************************
begin
  // Dummy um Compiler-Warnung zu vermeiden
end;



(******************************************************************************)
(*                 Methoden von TAbglColl                                     *)
(******************************************************************************)

// protected Methoden

//==============================================================================
function TAbglColl.GetPItem(Indx:Integer): TAbglObj;
//==============================================================================
begin
  Result := TAbglObj(inherited GetPItem(Indx));
end;

//==============================================================================
procedure TAbglColl.SetPItem(Indx:Integer; Item:TAbglObj);
//==============================================================================
begin
  inherited SetPItem(Indx,Item);
end;


// public Methoden

//******************************************************************************
constructor TAbglColl.Create(Veranst:Pointer;ItemClass:TTriaObjClass);
//******************************************************************************
begin
  inherited Create(Veranst,ItemClass);
  FSortMode := smAlles;
  FSortItems.Duplicates := true; //damit gleiche Einträge aufgelistet werden
end;

//******************************************************************************
function TAbglColl.AddSortItem(Item:Pointer): Integer;
//******************************************************************************
begin
  Result := -1;
  if (FSortMode=smNichtSortiert) or (Item=nil) then Exit;
  case SortMode of
    smUntersch     : if (TAbglObj(Item).Aktion = aaSync) then Exit;
    smFehler       : if (TAbglObj(Item).Aktion = aaSync) or
                        (TAbglObj(Item).Aktion = aaSnrImpOk) or
                        (TAbglObj(Item).Aktion = aaSnrImpNOk) or
                        (TAbglObj(Item).Aktion = aaSnrAbgl) then Exit;
    else {smAlles}
  end;
  Result := inherited AddSortItem(Item);
end;

//******************************************************************************
function TAbglColl.SortString(Item:Pointer): String;
//******************************************************************************
begin
  Result := Format('%4u',[IndexOf(Item)]);
end;

//******************************************************************************
procedure TAbglColl.SetzeAktionen;
//******************************************************************************
// Sync setzen und alle Aktionen Block nach Block neu definieren
var Indx,
    SyncIndx : integer;
    BlockOk  : Boolean;

//..............................................................................
  function SnrSync(Ix:Integer):Boolean;
  begin
    with GetPItem(Ix) do
      Result := (StrToIntDef(ImpSnr,0) > 0) and
                (StrToIntDef(ImpSnr,0) = StrToIntDef(AktSnr,0));
  end;

//..............................................................................
  function EintragFehlt(Ix:Integer): Boolean;
  begin
    with GetPItem(Ix) do
      Result := (UhrZeitWert(AktZeit) < 0) or // Tzt-Eintrag fehlt
                (StrToIntDef(ImpSnr,0) = 0); // ImpSnr fehlt
  end;

//..............................................................................
begin
  Indx :=0;
  while Indx < Count do
  begin
    // definiere Block: von Indx bis SyncIndx (max Count)
    SyncIndx := Indx; // letzter SyncIndx + 1
    BlockOk := true;
    while (SyncIndx < Count) and not SnrSync(SyncIndx) do
    begin
      if EintragFehlt(SyncIndx) then BlockOk := false;
      Inc(SyncIndx);
    end;
    // Block-Aktionen setzen
    while (Indx<Count) and (Indx <= SyncIndx) do
    begin
      GetPItem(Indx).SetzeAktion(BlockOk);
      Inc(Indx);
    end;
  end;
end;

//******************************************************************************
function TAbglColl.AktionsZahl(Akt:TAbglAktion): Integer;
//******************************************************************************
var i : Integer;
begin
  Result := 0;
  for i:=0 to Count-1 do
    if Akt = GetPItem(i).Aktion then
      Inc(Result);
end;


(******************************************************************************)
(*                Methoden von TAbglDialog                                    *)
(******************************************************************************)

// public Methoden

//******************************************************************************
constructor TAbglDialog.Create(AOwner: TComponent);
//******************************************************************************
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Initialisiert  := false;
  Updating       := true;
  DisableButtons := false;
  TztBuffColl    := TTztColl.Create(nil,TTztObj);
  TztBuffColl.SortMode := smTztZeitAuf; // gleich TztColl

  Top  := TztHauptDlg.Top + 20;
  Left := TztHauptDlg.Left + 20;
  Rand := 16;
  //Constraints.MinWidth  := Width;
  Constraints.MinHeight := AbglGrid.Top + 165;

  SnrDateiLabel.Caption  := 'Startnummer-Datei ( ' +
                             IntToStr(SnrImpColl.Count) + ' Einträge )';
  ZeitDateiLabel.Caption := 'Zeit-Datei ( ' +
                             IntToStr(TztImpColl.Count) + ' Einträge )';

  SetzeStatusGB;

  SnrDateiEdit.TabStop := false;
  StatusGB.TabStop     := false;
  AnsichtRG.TabStop    := false; // hilft nicht
  AendernBtn.TabStop   := false;
  CancelButton.TabStop := false;
  HilfeButton.TabStop  := false;
  AbglGrid.TabStop     := true;
  ImpSnrEdit.TabStop   := true;
  TztSnrEdit.TabStop   := true;
  TztZeitEdit.TabStop  := true;
  TztZeitEdit.InitEditMask;

  ImpSnrEdit.Align       := alCustom;
  TztSnrEdit.Align       := alCustom;
  TztZeitEdit.Align      := alCustom;
  ImpSnrEdit.BorderStyle := bsNone;
  TztSnrEdit.BorderStyle := bsNone;
  TztZeitEdit.BorderStyle:= bsNone;
  ImpSnrEdit.Color       := clWindow;
  TztSnrEdit.Color       := clWindow;
  TztZeitEdit.Color      := clWindow;

  Font.Name          := TztHauptDlg.AlfFontName;
  Font.Size          := TztHauptDlg.AlfFontSizeDefault;
  Font.Color         := clWindowText;
  Canvas.Font.Name   := TztHauptDlg.AlfFontName;
  Canvas.Font.Size   := TztHauptDlg.AlfFontSizeDefault;
  Canvas.Font.Color  := clWindowText;
  Canvas.Brush.Color := clWindowText;
  Canvas.Pen.Color   := clWindowText;

  with AbglGrid do
  begin
    BringToFront;
    // kein goRowSelect, damit bei Click Col richtig gesetzt wird
    Options           := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goTabs,goThumbTracking];
    EditierMode       := true;
    TopAbstand        := TztHauptDlg.TztGrid.TopAbstand;

    Font.Name          := TztHauptDlg.AlfFontName;
    Font.Size          := TztHauptDlg.AlfFontSizeDefault;
    Font.Color         := clWindowText;
    Canvas.Font.Name   := TztHauptDlg.NumFontName; // nur für Header auf Font.Name umschalten
    Canvas.Font.Size   := TztHauptDlg.NumFontSizeMin;
    Canvas.Font.Color  := clWindowText;
    Canvas.Brush.Color := clWindowText;
    Canvas.Pen.Color   := clWindowText;

    FixedRows         := 1;
    FixedCols         := 0;
    ColCount          := 8;
    AktionsSpalte     := 2;

    ColAlign[0]       := taCenter;        // ImpNr
    ColAlign[1]       := taRightJustify;  // ImpSnr
    ColAlign[2]       := taCenter;        // Aktion
    ColAlign[3]       := taCenter;        // TztNr
    ColAlign[4]       := taRightJustify;  // AktSnr
    ColAlign[5]       := taCenter;        // AktZeit
    ColAlign[6]       := taCenter;        // rand
    ColAlign[7]       := taLeftJustify;   // Beschreibung

    ColEdits[1]       := ImpSnrEdit;
    ColEdits[4]       := TztSnrEdit;
    ColEdits[5]       := TztZeitEdit;

    ColEditFontName    := TztHauptDlg.NumFontName; // nach dem Assign von ColEdit
    ColEditFontSize    := TztHauptDlg.NumFontSizeMin;
    ColEditFontColor   := clWindowText;

    ColWidths[0]      := Canvas.TextWidth(' 0000 ');
    ColWidths[1]      := Canvas.TextWidth('Startnr. ');
    ColWidths[2]      := Canvas.TextWidth(' Aktion ');
    ColWidths[3]      := ColWidths[0];
    ColWidths[4]      := ColWidths[1];
    case ZeitFormat of
      zfHundertstel : ColWidths[5] := Canvas.TextWidth('x00:00:00.00x');
      zfZehntel     : ColWidths[5] := Canvas.TextWidth('x00:00:00.0x');
      else            ColWidths[5] := Canvas.TextWidth('x00:00:00x');
    end;
    ColWidths[6]      := Canvas.TextWidth('0');
    ColWidths[7]      := Self.Canvas.TextWidth('xStartnr. fehlt, Eintrag löschenx');
    ClientWidth       := ColWidths[0] + ColWidths[1] + ColWidths[2] +
                         ColWidths[3] + ColWidths[4] + ColWidths[5] + ColWidths[6] +
                         ColWidths[7] + 8;
    DefaultRowHeight  := Canvas.TextHeight('0') + 2*AbglGrid.TopAbstand;
    Color := chGridColor;

    SnrPanel.Left   := Left;
    SnrPanel.Width  := ColWidths[0] + ColWidths[1] + 5;
    ZeitPanel.Left  := Left + ColWidths[0] + ColWidths[1] + ColWidths[2] + 4;
    ZeitPanel.Width := ColWidths[3] + ColWidths[4] + ColWidths[5] + 5;
  end;

  ClientWidth          := 2*Rand + AbglGrid.Width;
  Constraints.MinWidth := Width;
  SnrDateiEdit.Width   := (ClientWidth - 3*Rand) DIV 2;
  StatusGB.Width       := SnrDateiEdit.Width;
  ZeitDateiEdit.Width  := ClientWidth - 3*Rand - SnrDateiEdit.Width;
  AnsichtRG.Width      := ZeitDateiEdit.Width;
  ZeitDateiEdit.Left   := 2*Rand + SnrDateiEdit.Width;
  AnsichtRG.Left       := ZeitDateiEdit.Left;
  ZeitDateiLabel.Left  := ZeitDateiEdit.Left + 3;
  HilfeButton.Left     := ClientWidth - Rand - HilfeButton.Width;
  CancelButton.Left    := HilfeButton.Left - 8 - CancelButton.Width;
  AendernBtn.Left      := CancelButton.Left - 8 - AendernBtn.Width;
  AbglBtn.Left         := AendernBtn.Left - 8 - AbglBtn.Width;

  MouseX := -1;
  MouseY := -1;
  ColAlt := -1;
  RowAlt := -1;
  AnsichtRG.ItemIndex := 0; // smAlles, AbglColl und EditColl müssen gültig sein
  //AnsichtRG bekommt Focus, deshalb AbglGrid.SetFocus in OnShow-Event


  Updating       := false;
  HelpFensterAlt := HelpFenster;
  HelpFenster    := Self;
  VistaFix.SetzeFonts(Font);
end;

//******************************************************************************
destructor TAbglDialog.Destroy;
//******************************************************************************
begin
  HelpFenster := HelpFensterAlt;
  FreeAndNil(TztBuffColl);
  inherited Destroy;
end;


// private Methoden

//------------------------------------------------------------------------------
function TAbglDialog.EingabeOK: Boolean;
//------------------------------------------------------------------------------
// Bei Enter (AendBtn=default) und Pfeiltasten wird ValidateEdit
// nicht automatisch ausgefführt, deshalb diese Funktion
// Nach Fehlermeldung wird Focus durch ValidateEdit zurückgesetzt, damit mit
// ESC-Taste korrigiert werden kann
// ValidateEdit funktioniert nur wenn geändert wurde (Modified=true), nicht bei InitWert
begin
  with AbglGrid do
    if ColEditMode then
      case Col of
        1  : Result := ImpSnrEdit.ValidateEdit;
        4  : Result := TztSnrEdit.ValidateEdit;
        5  : Result := TztZeitEdit.ValidateEdit;
        else Result := true; // keine Prüfung notwendig
      end
    else Result := true;
end;

//------------------------------------------------------------------------------
procedure TAbglDialog.SetzeStatusGB;
//------------------------------------------------------------------------------
begin
  SnrIdentZahl.Caption   := IntToStr(AbglColl.AktionsZahl(aaSync));
  SnrUebernZahl.Caption  := IntToStr(AbglColl.AktionsZahl(aaSnrImpOk)+
                                     AbglColl.AktionsZahl(aaSnrImpNOk)+
                                     AbglColl.AktionsZahl(aaSnrAbgl));
  EintrFehltZahl.Caption := IntToStr(AbglColl.AktionsZahl(aaZeitFehlt)+
                                     AbglColl.AktionsZahl(aaSnrFehlt)+
                                     AbglColl.AktionsZahl(aaKein));
end;

//------------------------------------------------------------------------------
procedure TAbglDialog.SetzeButtons;
//------------------------------------------------------------------------------
var i : Integer;
    TztObj : TTztObj;
    DatenGeAendert : Boolean;
begin
  // AbglBtn
  with AbglColl do
    if AktionsZahl(aaSnrImpOk) +
       AktionsZahl(aaSnrImpNOk) +
       AktionsZahl(aaSnrAbgl) +
       AktionsZahl(aaSnrFehlt) > 0 then AbglBtn.Enabled := true
                                   else AbglBtn.Enabled := false;

  // AendernBtn
  TztBuffColl.Clear;
  for i:=0 to AbglColl.Count-1 do
  with AbglColl[i] do
    if (TztNr > 0) or
       (StrToIntDef(AktSnr,0)>0) or (UhrZeitWert(AktZeit) >= 0) then // abgeleitet von TztColl
    begin
      TztObj := TTztObj.Create(nil,TztBuffColl,oaNoAdd);
      TztObj.SnrRfid := AktSnr;
      TztObj.Zeit    := AktZeit;
      TztBuffColl.AddItem(TztObj);
    end;
  DatenGeAendert := false;
  if (TztColl.SortCount>0) and TztColl.SortItems[TztColl.SortCount-1].InitWert and  // leeres Item am Ende TztColl
     (TztBuffColl.SortCount <> TztColl.SortCount-1) or
     (TztColl.SortCount>0) and not TztColl.SortItems[TztColl.SortCount-1].InitWert and  // sollte nicht vorkommen
     (TztBuffColl.SortCount <> TztColl.SortCount) then
    DatenGeAendert := true
  else
    for i:=0 to TztBuffColl.SortCount-1 do
      if (TztBuffColl.SortItems[i].SnrRfid <> TztColl.SortItems[i].SnrRfid) or
         (TztBuffColl.SortItems[i].Zeit <> TztColl.SortItems[i].Zeit) then
      begin
        DatenGeAendert := true;
        Break;
      end;
  if DatenGeAendert then AendernBtn.Enabled := true
                    else AendernBtn.Enabled := false;
end;

//------------------------------------------------------------------------------
procedure TAbglDialog.Abgleichen(ARow: Integer);
//------------------------------------------------------------------------------
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons     := true;
    AbglGrid.StopPaint := true;

    if not AbglGrid.ResetColEditMode then Exit; // Eingaben prüfen und ggf. speichern

    if (ARow > 0) and (ARow <= AbglColl.SortCount) then
      with TAbglObj(AbglColl.SortItems[ARow-1]) do
        case Aktion of
          aaSnrImpOk,aaSnrImpNOk,aaSnrAbgl: // übernehmen
            AktSnr := ImpSnr;
          aaSnrFehlt,aaZeitFehlt,aaKein: // Eintrag löschen
            AbglColl.ClearItem(AbglColl.SortItems[ARow-1]);
          else ; //aaSync: keine Aktion
        end;

    AbglGrid.CollectionUpdate; // Rowcount gesetzt (>= 2)
    AbglGrid.Invalidate;
    AbglColl.SetzeAktionen;
    SetzeStatusGB;
    SetzeButtons;

  finally
    AbglGrid.StopPaint := false;
    DisableButtons     := false;
  end;
end;

//------------------------------------------------------------------------------
procedure TAbglDialog.CMDialogKey(var Msg: TWMKEY);
//------------------------------------------------------------------------------
// VK_TAB in ColEdits hier abfangen, sonst wird nächster Control in Form fokussiert
// mit Charcode=0 landet VK_TAB in CustomEdit.Keydown und dann in TTriaGrid.KeyDown
begin
  if (Msg.Charcode = VK_TAB) and AbglGrid.ColEditMode and
     ((ActiveControl = ImpSnrEdit) or
      (ActiveControl = TztSnrEdit) or (ActiveControl = TztZeitEdit)) then
    Msg.Charcode := 0;  // damit weiter von TCustomGrid.Keydown in TTriaGrid.Keydown
  inherited;
end;

// Eventhandler

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.DateiEditClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if AbglGrid.CanFocus then AbglGrid.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AnsichtRGClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Ptr : Pointer;
begin
  if not Updating then
  with AbglGrid do
    if ResetColEditMode then // Prüfung geschieht vorher in Exit
    begin
      Ptr := FocusedItem;
      case AnsichtRG.ItemIndex of
        0: TAbglColl(Collection).Sortieren(smAlles);
        1: TAbglColl(Collection).Sortieren(smUntersch);
        2: TAbglColl(Collection).Sortieren(smFehler);
        else
      end;
      CollectionUpdate;
      FocusedItem := Ptr;
      if CanFocus then SetFocus;
      Refresh;
    end;
end; 

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AbglGridGetColText(Sender: TTriaGrid; Item: Pointer;
                                         ACol: Integer; var Value: string);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with AbglGrid do
  begin
    Value := '';
    if Item = nil then Exit;
    case ACol of
      0: if TAbglObj(Item).ImpNr > 0 then
           Value := IntToStr(TAbglObj(Item).ImpNr)
         else Value := '-'; // DrawCell
      1: if StrToIntDef(TAbglObj(Item).ImpSnr,0) > 0 then
           Value := RemLeadZero(TAbglObj(Item).ImpSnr)
         else
         if Sender <> nil then Value := '0'  // ColEdit
         else // DrawCell
         if (ACol=Col) and
            (AbglColl.SortIndexOf(Item)=ItemIndex) then Value := '0'
         else Value := '-';
      3: if TAbglObj(Item).TztNr > 0 then
           Value := IntToStr(TAbglObj(Item).TztNr)
         else Value := '-'; // DrawCell
      4: if StrToIntDef(TAbglObj(Item).AktSnr,0) > 0 then
           Value := Trim(RemLeadZero(TAbglObj(Item).AktSnr))
         else
         if Sender <> nil then Value := '0'  // ColEdit
         else // DrawCell
         if (ACol=Col) and
            (AbglColl.SortIndexOf(Item)=ItemIndex) then Value := '0'
         else Value := '-';
      5: if UhrZeitWert(TAbglObj(Item).AktZeit) >= 0 then
           Value := TAbglObj(Item).AktZeit
         else // Value = -1
         if Sender <> nil then Value := ''   // ColEdit
         else // AbglGridDrawCell
         if (ACol=Col) and
            (AbglColl.SortIndexOf(Item)=ItemIndex) then
           case ZeitFormat of
             zfHundertstel : Value := '__:__:__'+DecTrennZeichen+'__';
             zfZehntel     : Value := '__:__:__'+DecTrennZeichen+'_';
             else            Value := '__:__:__';
           end
         else Value := '-';
       7: Value := TAbglObj(Item).Komment; // DrawCell
      else ;
    end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AbglGridMouseDown(Sender: TObject; Button: TMouseButton;
                                        Shift: TShiftState; X, Y: Integer);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var R: TRect;
    Spalte,Zeile: Integer;
begin
  // MousePosition für AbglGridMouseUp und AbglGridDrawCell speichern
  MouseX := X;
  MouseY := Y;
  if (Button = mbLeft) and not (ssDouble in Shift) then
  with AbglGrid do
  begin
    MouseToCell(X, Y, Spalte, Zeile);
    if (Spalte = AktionsSpalte) and (Zeile > 0)  then
    begin
      R := CellRect(Spalte,Zeile);  // Col,Row
      AbglGridDrawCell(Sender,Spalte,Zeile,R,[gdFixed]); // Button Pressed
    end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AbglGridMouseUp(Sender: TObject; Button: TMouseButton;
                                      Shift: TShiftState; X, Y: Integer);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Spalte,Zeile: Integer;
begin
  if (Button = mbLeft) and not (ssDouble in Shift) then
  with AbglGrid do
  begin
    // In Zelle (Zeile,Spalte) wurde geklickt
    // nicht berücksichtigt wo Maus losgelassen wird (X,Y)
    MouseToCell(MouseX, MouseY, Spalte, Zeile);
    MouseX := -1;
    MouseY := -1;
    if (Spalte = AktionsSpalte) and (Zeile > 0)  then
    begin
      Abgleichen(Zeile);
      // aktuelle Zelle  fokussieren
      Refresh;
      if (ColAlt >= 0) and (RowCount > 1) then
        if Zeile < RowCount then
          FocusZelle(ColAlt,Zeile)
        else
          FocusZelle(ColAlt,RowCount-1);
    end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AbglGridSelectCell(Sender: TObject; ACol, ARow: Integer;
                                         var CanSelect: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// aufgerufen von SelectCell und SetColEdit(false)
// ARow,ACol neue Zelle nach Änderung: nicht benutzt
// nur wenn CanSelect Daten speichern
var Buf : Boolean;
begin
  with Sender as TTriaGrid do
  begin
    Buf := StopPaint;
    FocusAlt := nil;

    if not ColEditMode then // nur in ColEditMode prüfen
      CanSelect := true
    else
    begin
      CanSelect := EingabeOk; // ColEdits prüfen
      if CanSelect and (FocusedItem <> nil) then
      try
        StopPaint := true;
        // Daten aus Edits übernehmen bevor neue Cell gesetzt wird
        with TAbglObj(FocusedItem) do // Edit speichern
          case Col of // aktuelle Zelle
            1: begin
                 ImpSnr := Trim(RemLeadZero(ImpSnrEdit.Text));
                 if ImpSnr = '' then ImpSnr := '0';
               end;
            4: begin
                 AktSnr := Trim(RemLeadZero(TztSnrEdit.Text));
                 if AktSnr = '' then AktSnr := '0';
               end;
            5: AktZeit := TztZeitEdit.Text;
            else ;
          end;
        ColEditMode := false;    // nicht SetEditMode, kein Event
        ImpSnrEdit.Text  := '';  // immer Modified false
        TztSnrEdit.Text  := '';
        TztZeitEdit.Text := '';
        AbglColl.SetzeAktionen;
        CollectionUpdate; // Rowcount gesetzt
        SetzeButtons;
        SetzeStatusGB;
        BringToFront;
        if (Parent <> nil) and Parent.Visible and // sonst exception wenn Init in create
           Visible and CanFocus then SetFocus;    // kommt aber nicht vor
      finally
        StopPaint := Buf;
      end;
    end;

    if CanSelect then // auch wenn not ColEditMode
    begin
      Invalidate; // ganze Zeile mit Rahmen neu zeichnen
      if Assigned(ColEdits[ACol]) then
      begin
        ColAlt := ACol;
        RowAlt := ARow;
      end;
    end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AbglGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                                       Rect: TRect; State: TGridDrawState);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Text : String;
    AbglObj: TAbglObj;
    SpaceLinks,SpaceTop: Integer;
//..............................................................................
  procedure ZeichneAktion(Aktion:TAbglAktion);
  var Vert,Hor,Spalte,Zeile : Integer;
  begin
    with Sender as TTriaGrid{.Canvas} do
    begin
      Canvas.Brush.Color := clWindowText; //$00606060;
      Canvas.Pen.Width   := 1;
      Canvas.Pen.Style   := psSolid;
      Canvas.Pen.Color   := clWindowText; //$00606060;
      with Rect do
      begin
        Vert := Top  + (Bottom-Top) DIV 2;
        Hor  := Left + (Right-Left) DIV 2;
      end;

      // MouseX,MouseY wird in AbglGridMouseDown = Mouse-Position(X,Y) gesetzt
      // und in AbglGridMouseUp = -1 gesetzt
      MouseToCell(MouseX, MouseY, Spalte, Zeile);
      if (ACol>0) and (ARow=Zeile)and(ACol=Spalte) then  // Mouse pressed
      begin
        Inc(Vert);
        Inc(Hor);
        //Canvas.TextOut(TextLinks, TextOben, Text);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Polyline([Point(Rect.Left, Rect.Bottom-1),
                         Point(Rect.Left,Rect.Top),
                         Point(Rect.Right,Rect.Top)]);
      end else // Mouse not pressed
      begin
        //Canvas.TextOut(TextLinks, TextOben, Text);
        //Canvas.Brush.Color := clWindowText;
        //if ACol > 0 then PfeilZeichnen;
        Canvas.Pen.Color := clWindow;
        Canvas.Polyline([Point(Rect.Left, Rect.Bottom-1),
                         Point(Rect.Left,Rect.Top),
                         Point(Rect.Right,Rect.Top)]);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Polyline([Point(Rect.Left+1, Rect.Bottom-1),
                         Point(Rect.Right-1,Rect.Bottom-1),
                         Point(Rect.Right-1,Rect.Top)]);
      end;

      Canvas.Pen.Color   := clWindowText;
      Canvas.Brush.Color := AbglObj.AktionsFarbe;
      case AbglObj.Aktion of
        aaSnrImpOk,aaSnrImpNOk,aaSnrAbgl:        // übernehmen
          Canvas.Polygon([Point(Hor-10,Vert-2),
                          Point(Hor-10,Vert+1),
                          Point(Hor,Vert+1),
                          Point(Hor,Vert+5),
                          Point(Hor+10,Vert),
                          Point(Hor+10,Vert-1),
                          Point(Hor,Vert-6),
                          Point(Hor,Vert-2)]);
        aaSync:                                  // keine Aktion
          Canvas.Polygon([Point(Hor-6,Vert-2),
                          Point(Hor-6,Vert+1),
                          Point(Hor+6,Vert+1),
                          Point(Hor+6,Vert-2)]);
        aaSnrFehlt,aaZeitFehlt,aaKein:           // Eintrag löschen
          Canvas.Polygon([Point(Hor-8,Vert-6),
                          Point(Hor-4,Vert-6),
                          Point(Hor,Vert-2),
                          Point(Hor+4,Vert-6),
                          Point(Hor+8,Vert-6),
                          Point(Hor+2,Vert),
                          Point(Hor+8,Vert+6),
                          Point(Hor+4,Vert+6),
                          Point(Hor,Vert+2),
                          Point(Hor-4,Vert+6),
                          Point(Hor-8,Vert+6),
                          Point(Hor-2,Vert)]);
      end;

    end;
  end;

//..............................................................................
begin
  with Sender as TTriaGrid do
  begin
    Text := ''; // dummy leerzeile wenn itemcount = 0

    if ARow < FixedRows then // Überschrift
    begin
      //DefaultDrawing := true;
      // Font nur vorübergehend für Row=0 umschalten
      Canvas.Font.Name := Font.Name;
      Canvas.Font.Size := Font.Size;
      Canvas.Brush.Color := clBtnFace;
      Canvas.FillRect(Rect);

      case ACol of
        0,3 : Canvas.Font.Color := $00808080;
        else  Canvas.Font.Color := clWindowText;
      end;
      case ACol of
        0: Text := 'Nr.';
        1: Text := 'Startnr. '; // extra Blank weil RightJustify
        2: Text := 'Aktion';
        3: Text := 'Nr.';
        4: Text := 'Startnr. ';
        5: Text := 'Zeit';
        6: Text := '';
        7: Text := 'Beschreibung';
      end;
      SpaceTop   := Rect.Top + (Rect.Bottom-Rect.Top - Canvas.TextHeight('0')) DIV 2;
      if ACol = 7 then
        SpaceLinks := Rect.Left + Canvas.TextWidth(' ')
      else
        SpaceLinks := Rect.Left + (Rect.Right-Rect.Left - Canvas.TextWidth(Text)) DIV 2;
      Canvas.TextOut(SpaceLinks, SpaceTop, Text);

      // Rahmen, muss nach Text
      Canvas.Pen.Width := 1;
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := clBtnShadow;
      // Rand unten
      Canvas.Polyline([Point(Rect.Left,Rect.Bottom-1),Point(Rect.Right,Rect.Bottom-1)]);

      // Font zurücksetzen
      Canvas.Font.Name := TztHauptDlg.NumFontName;
      Canvas.Font.Size := TztHauptDlg.NumFontSizeMin;
    end

    else // ARow >= FixedRows oder EditGrid
    begin

      if ARow < ItemCount + FixedRows then // FixedRows = 1
        AbglObj := TAbglObj((Sender as TTriaGrid)[ARow - FixedRows])
      else AbglObj := nil;

      if AbglObj = nil then
      begin
        Canvas.Brush.Color := clWindow;
        Canvas.FillRect(Rect);
        Exit;
      end;

      case ACol of
        0,3 : Canvas.Font.Color := $00808080;
        else  Canvas.Font.Color := clWindowText;
      end;
      // Farbe Hintergrund setzen
      if ACol = AktionsSpalte then
        Canvas.Brush.Color := clBtnFace
      else
      if (ACol=Col) and (ARow=Row) and Assigned(ColEdits[ACol]) then
         Canvas.Brush.Color := clWindow // Hintergrund weiß
      else
      if (AbglObj.Aktion = aaSync) and not Assigned(ColEdits[ACol]) then
        if ACol=6 then
          Canvas.Brush.Color := clBtnFace
        else
          Canvas.Brush.Color := $00FAFAFA // Hintergrund hellgrau
      else
        Canvas.Brush.Color := AbglObj.AktionsHintergrundFarbe;

      Canvas.FillRect(Rect);

      if not ColEditMode or (ARow<>Row) or (ACol<>Col) then // kein Text unter ColEdit
        AbglGridGetColText(nil,AbglObj,ACol,Text);

      case ACol of
        0,3,7:
        begin
          if ACol=7 then
          begin
            // Font nur vorübergehend umschalten
            Canvas.Font.Name := Font.Name;
            Canvas.Font.Size := Font.Size;
            SpaceLinks :=  Rect.Left + Canvas.TextWidth(' ')
          end else
            SpaceLinks := Rect.Left +
                          (Rect.Right-Rect.Left-Canvas.TextWidth(Text)) DIV 2;
          SpaceTop := (DefaultRowHeight - Canvas.TextHeight('0')) DIV 2;
          Canvas.TextOut(SpaceLinks, Rect.Top + SpaceTop, Text);
          // Font zurücksetzen
          Canvas.Font.Name := TztHauptDlg.NumFontName;
          Canvas.Font.Size := TztHauptDlg.NumFontSizeMin;
        end;
        1,4:
        begin
          SpaceLinks  := Rect.Left +
                         (Rect.Right-Rect.Left-Canvas.TextWidth('0000')) DIV 2 +
                         Canvas.TextWidth('0000') - Canvas.TextWidth(Text); // rechts ausrichten
          Canvas.TextOut(SpaceLinks, Rect.Top + TopAbstand, Text);
        end;
        5:
        begin
          if Text = '-' then // zentrieren
            SpaceLinks := Rect.Left +
                          (Rect.Right-Rect.Left-Canvas.TextWidth('-')) DIV 2
          else
            SpaceLinks := Rect.Left +
                         (Rect.Right-Rect.Left-Canvas.TextWidth(UhrZeitStr(0))) DIV 2;
          Canvas.TextOut(SpaceLinks, Rect.Top + TopAbstand, Text);
        end;
        2: ZeichneAktion(AbglObj.Aktion);
        else ; // 6
      end;
    end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.GridSnrEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with (Sender as TTriaMaskEdit) do
    if Length(Text) = 0 then Text := '0';
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.FormResize(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  AbglGrid.Height  := ClientHeight - AbglGrid.Top - 57;
  AbglBtn.Top      := AbglGrid.Top + AbglGrid.Height + 16;
  AendernBtn.Top   := AbglBtn.Top;
  CancelButton.Top := AbglBtn.Top;
  HilfeButton.Top  := AbglBtn.Top;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.FormShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
// Windows does not send WM_HELP messages (which
// the VCL uses to trigger the context help) if the control clicked on is one
// that has the WS_EX_CONTROLPARENT extended window style. Panels and
// groupboxes have this style set. You can remove it using SetWindowLong:
  SetWindowLong( StatusGB.handle,
                 GWL_EXSTYLE,
                 GetWindowLong( StatusGB.handle, GWL_EXSTYLE )
                 AND NOT WS_EX_CONTROLPARENT );

  with AbglGrid do
  begin
    SetFocus;
    // AbglColl vorher Initialisiert
    Init(AbglColl,smSortiert,ssVertical,nil);
    ResetColEditMode;
    if ItemCount > 0 then
      ItemIndex := 0;
    SetzeButtons;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AbglBtnClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Abgleich in AbglColl übernehmen
var i   : Integer;
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;

    if not AbglGrid.ResetColEditMode then Exit; // Eingaben prüfen und ggf. speichern

    AbglGrid.StopPaint := true;
    for i:=AbglColl.Count-1 downto 0 do
      with AbglColl[i] do
        case Aktion of
          aaSnrImpOk,aaSnrImpNOk,aaSnrAbgl: // übernehmen
            AktSnr := ImpSnr;
          aaSnrFehlt,aaZeitFehlt,aaKein: // Eintrag löschen
            AbglColl.ClearItem(AbglColl[i]);
          else ; //aaSync: keine Aktion
        end;

    AbglColl.SetzeAktionen;
    SetzeButtons;
    SetzeStatusGB;
    AbglGrid.CollectionUpdate; // Rowcount gesetzt
    AbglGrid.Refresh;
    AbglGrid.StopPaint := false;

  finally
    DisableButtons := false;
  end;

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AbglGridDblClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if AbglGrid.ResetColEditMode then AbglGrid.SetColEditMode;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.AendernBtnClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// AbglColl in Zeit-Datei übernehmen und speichern
var i : Integer;
    TztObj : TTztObj;
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;

    if not AbglGrid.ResetColEditMode then Exit; // Eingaben prüfen und ggf. speichern

    // in SetzeButtons Daten in TztBuffColl gespeichert
    TztDatModified := true;
    TztHauptDlg.Refresh;
    TztHauptDlg.TztGrid.StopPaint := true;
    TztColl.Clear;
    TztColl.AddItem(TTztObj.Create(nil,TztColl,oaNoAdd)); // leere Zeile am Ende
    TztBuffColl.Clear;
    // zunächst in TztBuffColl und dann in zeitlicher Reihenfolge in TztColl,
    // damit Nr. stimmt
    for i:=0 to AbglColl.Count-1 do
      with AbglColl[i] do
      if (TztNr > 0) or
         (StrToIntDef(AktSnr,0)>0) or (AktZeit<>ZeitInitWert) then // abgeleitet von TztColl
      begin
        TztObj := TTztObj.Create(nil,TztBuffColl,oaNoAdd);
        TztObj.SnrRfid := AktSnr;
        TztObj.Zeit    := AktZeit;
        TztBuffColl.AddItem(TztObj);
        TztNr := TztBuffColl.IndexOf(TztObj)+1; // zunächst Index statt SortIndex
      end;
    // Index korrigieren, TztBuffColl.SortIndex entspricht TztColl.Index
    for i:=0 to AbglColl.Count-1 do
      with AbglColl[i] do
      if TztNr > 0 then TztNr := TztBuffColl.SortIndexOf(TztBuffColl[TztNr-1])+1;
    // in TztColl übernehmen
    for i:=0 to TztBuffColl.SortCount-1 do
      with TztBuffColl.SortItems[i] do
      begin
        TztObj := TTztObj.Create(nil,TztColl,oaNoAdd);
        TztObj.SnrRfid := SnrRfid;
        TztObj.Zeit    := Zeit;
        TztColl.AddItem(TztObj);
      end;
    AbglColl.SetzeAktionen;
    TztHauptDlg.TztGrid.CollectionUpdate;
    TztHauptDlg.TztGrid.StopPaint := false;
    TztHauptDlg.TztGrid.Refresh;

    AbglGrid.Refresh;
    SetzeButtons;
    SetzeStatusGB;
    ZeitDateiLabel.Caption := 'Zeit-Datei ( '+IntToStr(TztColl.Count-1)+' Einträge )';
  finally
    DisableButtons := false;
  end;

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if AbglGrid.ResetColEditMode then // Eingaben prüfen und ggf. speichern
    CanClose := true
  else CanClose := false;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.CancelButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  ModalResult := mrCancel; (* Prüfung in FormCloseQuery *)
end;


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAbglDialog.HilfeButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if AbglGrid.ResetColEditMode then  // Eingaben prüfen und ggf. speichern
    Application.HelpContext(0800);
end;

end.
