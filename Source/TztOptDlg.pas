unit TztOptDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Math, Mask,StrUtils,
  AllgConst, AllgComp, Buttons;

procedure Optionen;

type
  TTztOptDialog = class(TForm)
    OptPageControl: TPageControl;
    AllgemeinTS: TTabSheet;
      AutoUpdateCB: TCheckBox;
      MruDateiCB: TCheckBox;
    ZeitnahmeTS: TTabSheet;
      ZeitNahmeGB: TGroupBox;
        SnrRB: TRadioButton;
        SnrLabel: TLabel;
        SnrMaxLabel: TLabel;
        SnrEdit: TTriaEdit;
        RfidRB: TRadioButton;
        RfidLabel: TLabel;
        RfidMaxLabel: TLabel;
        LaengeEdit: TTriaMaskEdit;
        LaengeUpDown: TTriaUpDown;
        HexCB: TCheckBox;
      StoppuhrCB: TCheckBox;
      ZeitUngleichCB: TCheckBox;
      BeepSignalCB: TCheckBox;
    ZeitFormatTS: TTabSheet;
      ZeitFormatRG: TRadioGroup;
      TrennZeichenLabel: TLabel;
      TrennZeichenCB: TComboBox;
    SpeichernTS: TTabSheet;
      AutoSpeichernCB: TCheckBox;
      AutoSpeichernLabel: TLabel;
      AutoSpeichernEdit: TTriaMaskEdit;
      AutoSpeichernUpDown: TTriaUpDown;
      BackupCB: TCheckBox;
    AnsichtTS: TTabSheet;
      RndAnzeigeCB: TCheckBox;
        RndWarnungLabel1: TLabel;
        RndWarnungEdit: TTriaMaskEdit;
        RndWarnungUpDown: TTriaUpDown;
        RndWarnungLabel2: TLabel;
      TlnAnzeigeCB: TCheckBox;
        DateiLabel: TLabel;
    VorgabeButton: TButton;
    HilfeButton: TButton;
    CancelButton: TButton;
    OkButton: TButton;
    procedure SetzeVorgabeBtn(Sender: TObject);
    procedure VorgabeButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
    procedure TrennZeichenLabelClick(Sender: TObject);
    procedure ZeitFormatRGClick(Sender: TObject);
    procedure AutoSpeichernCBClick(Sender: TObject);
    procedure AutoSpeichernEditChange(Sender: TObject);
    procedure RndAnzeigeCBClick(Sender: TObject);
    procedure TlnAnzeigeCBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ZeitNahmeGBClick(Sender: TObject);

  private
    TrennZeichenListe : TStringList;
    HelpFensterAlt    : TWinControl;
    Updating          : Boolean;
    DisableButtons    : Boolean;
    procedure Init;
    procedure SetPage(Page:TTabSheet);
    procedure RfidSetzen;
    procedure ZeitFormatSetzen(ZeitFormatNeu:TZeitFormat);
    procedure UpdateAutoSpeichern;
    function  GetZeitFormat: TZeitFormat;
    function  GetTrennZeichen: String;
    procedure UpdateRndWarnung;
    procedure UpdateTlnAnzeige;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  TztOptDialog : TTztOptDialog;

implementation

uses TztAllg,TztMain,TztConfig,TztHistory,TztDat,TztStrtLst,AllgFunc,VistaFix;

{$R *.DFM}

(******************************************************************************)
procedure Optionen;
(******************************************************************************)
// AInit definiert welche Tab angezeigt wird in FormShow
begin
  TztOptDialog := TTztOptDialog.Create(TztHauptDlg);
  try
    TztOptDialog.PopupParent := TztHauptDlg; // VistaFix
    TztOptDialog.ShowModal;
  finally
    FreeAndNil(TztOptDialog);
  end;
end;

{==============================================================================}
constructor TTztOptDialog.Create(AOwner: TComponent);
{==============================================================================}
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Updating       := false;
  DisableButtons := false;
  AllgemeinTS.TabOrder := 0;

  TrennZeichenListe := TStringList.Create;
  TrennZeichenListe.Add(opDecTrennZeichen);
  TrennZeichenListe.Add('.');
  TrennZeichenCB.Items := TrennZeichenListe;
  AutoSpeichernEdit.EditMask := '99;0; ';
  LaengeUpDown.Min := cnRfidZeichenMin;
  LaengeUpDown.Max := cnRfidZeichenMax;

  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  VistaFix.SetzeFonts(Font);
end;

(*============================================================================*)
destructor TTztOptDialog.Destroy;
(*============================================================================*)
begin
  HelpFenster := HelpFensterAlt;
  TrennZeichenListe.Free;
  inherited Destroy;
end;

(*----------------------------------------------------------------------------*)
procedure TTztOptDialog.Init;
(*----------------------------------------------------------------------------*)
begin
  Updating := true;

  AutoUpdateCB.Checked   := AutoUpdate;
  MruDateiCB.Checked     := MruDateiOeffnen;
  BackupCB.Checked       := Backuperstellen;
  StoppUhrCB.Checked     := TimerModus <> zmUhrZeit;
  ZeitUngleichCB.Checked := ZeitGleich = zgGleichNok;
  BeepSignalCB.Checked   := BeepSignal;
  if DecTrennZeichen = opDecTrennZeichen then TrennZeichenCB.ItemIndex := 0
                                         else TrennZeichenCB.ItemIndex := 1;
  if RfidModus then RfidRB.Checked := true
               else SnrRB.Checked := true;
  RfidSetzen;
  ZeitFormatSetzen(ZeitFormat);
  if TztHauptDlg.AutoSpeichernInterval > 0 then AutoSpeichernCB.Checked := true
                                           else AutoSpeichernCB.Checked := false;
  UpdateAutoSpeichern;

  if not RfidRB.Checked then
    RndAnzeigeCB.Checked := SpalteZahl;
  UpdateRndWarnung;

  if SnrNameListe.Count > 0 then
    DateiLabel.Hide
  else
    DateiLabel.Show;
  UpdateTlnAnzeige;

  Updating := false;
  SetzeVorgabeBtn(nil);
end;

(*----------------------------------------------------------------------------*)
procedure TTztOptDialog.SetPage(Page:TTabSheet);
(*----------------------------------------------------------------------------*)
begin
  if Page = OptPageControl.ActivePage then Exit  // damit nicht neu Focussiert wird
  else
  OptPageControl.ActivePage := Page;
  //Taborder bestimmt welcher Focussiert wird
  if AutoUpdateCB.CanFocus then AutoUpdateCB.SetFocus;       // AllgemeinTS
  if RfidRB.Checked then                                     // ZeitnahmeTS
    if RfidRB.CanFocus then RfidRB.SetFocus
    else
  else
    if SnrRB.CanFocus then SnrRB.SetFocus;
  if ZeitFormatRG.CanFocus then ZeitFormatRG.SetFocus;       // ZeitFormatTS
  if AutoSpeichernCB.CanFocus then AutoSpeichernCB.SetFocus; // SpeichernTS
  if RndAnzeigeCB.CanFocus then RndAnzeigeCB.SetFocus;       // AnzeigeTS
end;


//------------------------------------------------------------------------------
procedure TTztOptDialog.RfidSetzen;
//------------------------------------------------------------------------------
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := Updating;
  Updating := true;
  if RfidRB.Checked then
  begin
    LaengeEdit.Enabled := true;
    LaengeEdit.Text := IntToStr(Rfidzeichen);
    LaengeUpDown.Enabled := true;
    RfidLabel.Enabled := true;
    RfidMaxLabel.Enabled := true;
    HexCB.Enabled := true;
    HexCB.Checked := RfidHex;
    if LaengeEdit.CanFocus then LaengeEdit.SetFocus;
    RndAnzeigeCB.Enabled := false;
    RndAnzeigeCB.Checked := false;
    UpdateRndWarnung;
    UpdateTlnAnzeige;
  end else
  begin
    LaengeEdit.Enabled := false;
    LaengeEdit.Text := '';
    LaengeUpDown.Enabled := false;
    RfidLabel.Enabled := false;
    RfidMaxLabel.Enabled := false;
    HexCB.Enabled := false;
    HexCB.Checked := false;
    RndAnzeigeCB.Enabled := true;
    RndAnzeigeCB.Checked := SpalteZahl;
    UpdateRndWarnung;
    UpdateTlnAnzeige;
  end;
  Updating := UpdatingAlt;
  SetzeVorgabeBtn(nil);
end;

//------------------------------------------------------------------------------
procedure TTztOptDialog.ZeitFormatSetzen(ZeitFormatNeu:TZeitFormat);
//------------------------------------------------------------------------------
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := Updating;
  Updating := true;
  case ZeitFormatNeu of
    zfHundertstel:
    begin
      ZeitFormatRG.ItemIndex    := 2;
      TrennZeichenLabel.Enabled := true;
      TrennZeichenCB.Enabled    := true;
    end;
    zfZehntel:
    begin
      ZeitFormatRG.ItemIndex    := 1;
      TrennZeichenLabel.Enabled := true;
      TrennZeichenCB.Enabled    := true;
    end;
    else
    begin
      ZeitFormatRG.ItemIndex    := 0;
      TrennZeichenLabel.Enabled := false;
      TrennZeichenCB.Enabled    := false;
    end;
  end;
  Updating := UpdatingAlt;
  SetzeVorgabeBtn(nil);
end;

//------------------------------------------------------------------------------
procedure TTztOptDialog.UpdateAutoSpeichern;
//------------------------------------------------------------------------------
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := Updating;
  Updating := true;
  if AutoSpeichernCB.Checked then
  begin
    AutoSpeichernLabel.Enabled  := true;
    AutoSpeichernEdit.Enabled   := true;
    AutoSpeichernUpDown.Enabled := true;
    with TztHauptDlg do
      if AutoSpeichernInterval > 0 then // Interval in msek
        AutoSpeichernEdit.Text := IntToStr(AutoSpeichernInterval DIV 1000)
      else AutoSpeichernEdit.Text := IntToStr(opAutoSpeichernTrz);
  end else
  begin
    AutoSpeichernLabel.Enabled  := false;
    AutoSpeichernEdit.Enabled   := false;
    AutoSpeichernUpDown.Enabled := false;
    AutoSpeichernEdit.Text      := '';
  end;
  Updating := UpdatingAlt;
end;

//------------------------------------------------------------------------------
function TTztOptDialog.GetZeitFormat: TZeitFormat;
//------------------------------------------------------------------------------
begin
  case ZeitFormatRG.ItemIndex of
    1  : Result := zfZehntel;
    2  : Result := zfHundertstel;
    else Result := zfSek;
  end;
end;

//------------------------------------------------------------------------------
function TTztOptDialog.GetTrennZeichen: String;
//------------------------------------------------------------------------------
begin
  if GetZeitFormat = zfSek then
    Result := ','
  else
    case TrennZeichenCB.ItemIndex of
      1  : Result := '.';
      else Result := ',';
    end;
end;

//------------------------------------------------------------------------------
procedure TTztOptDialog.UpdateRndWarnung;
//------------------------------------------------------------------------------
// RndAnzeigeCB: Enabled und Checked vorher gesetzt
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := Updating;
  Updating := true;
  if RndAnzeigeCB.Checked then
  begin
    RndWarnungLabel1.Enabled := true;
    RndWarnungLabel2.Enabled := true;
    RndWarnungEdit.Enabled   := true;
    RndWarnungUpDown.Enabled := true;
    RndWarnungEdit.Text := IntToStr(Max(1,RndCheckZahl));
    if RndWarnungEdit.CanFocus then RndWarnungEdit.SetFocus;
  end else
  begin
    RndWarnungLabel1.Enabled := false;
    RndWarnungLabel2.Enabled := false;
    RndWarnungEdit.Enabled   := false;
    RndWarnungUpDown.Enabled := false;
    RndWarnungEdit.Text      := '';
  end;
  Updating := UpdatingAlt;
end;

//------------------------------------------------------------------------------
procedure TTztOptDialog.UpdateTlnAnzeige;
//------------------------------------------------------------------------------
// RfidRB muss vorher gesetzt werden
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := Updating;
  Updating := true;
  if RfidRB.Checked then
  begin
    TlnAnzeigeCB.Enabled := false;
    TlnAnzeigeCB.Checked := false;
  end else
  if SnrNameListe.Count > 0 then
  begin
    TlnAnzeigeCB.Enabled := true;
    TlnAnzeigeCB.Checked := SpalteTln;
  end else
  begin
    TlnAnzeigeCB.Enabled := false;
    TlnAnzeigeCB.Checked := false;
  end;
  Updating := UpdatingAlt;
end;


// Event Handler

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztOptDialog.FormShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  Init;
  SetPage(AllgemeinTS);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.ZeitFormatRGClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if not Updating then ZeitFormatSetzen(GetZeitFormat);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

procedure TTztOptDialog.TrennZeichenLabelClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if TrennZeichenCB.CanFocus then TrennZeichenCB.SetFocus;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.AutoSpeichernCBClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  UpdateAutoSpeichern;
  if AutoSpeichernCB.Checked then
    if AutoSpeichernEdit.CanFocus then AutoSpeichernEdit.SetFocus;
  if not Updating then SetzeVorgabeBtn(nil);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.AutoSpeichernEditChange(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if not Updating then SetzeVorgabeBtn(nil);
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztOptDialog.ZeitNahmeGBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then RfidSetzen;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztOptDialog.RndAnzeigeCBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  UpdateRndWarnung;
  if not Updating then SetzeVorgabeBtn(nil);
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztOptDialog.TlnAnzeigeCBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then SetzeVorgabeBtn(nil);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.SetzeVorgabeBtn(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if not Updating then
    if (AutoUpdateCB.Checked   = opAutoUpdate) and
       (MruDateiCB.Checked     = opMruDateiOeffnenTrz) and
       (SnrRB.Checked) and
       (not StoppuhrCB.Checked) and
       (not ZeitUngleichCB.Checked) and
       (BeepSignalCB.Checked   = opBeepSignal) and
       (BackupCB.Checked       = opBackupErstellenTrz) and
       (AutoSpeichernCB.Checked and (StrToIntDef(AutoSpeichernEdit.Text,0)=opAutoSpeichernTrz)) and
       (ZeitFormatRG.ItemIndex = 0) and // TrennzeichenCB unwichtig weil disabled
       (not RndAnzeigeCB.Checked) and // RndWarnungCB unwichtig weil disabled
       (not TlnAnzeigeCB.Checked) then
      VorgabeButton.Enabled := false
    else VorgabeButton.Enabled := true;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.VorgabeButtonClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    Updating := true;
    AutoUpdateCB.Checked      := opAutoUpdate;
    MruDateiCB.Checked        := opMruDateiOeffnenTrz;
    SnrRB.Checked             := true;
    StoppUhrCB.Checked        := false;
    ZeitUngleichCB.Checked    := false;
    BeepSignalCB.Checked      := opBeepSignal;
    BackupCB.Checked          := opBackupErstellenTrz;
    if opAutoSpeichernTrz > 0 then
    begin
      AutoSpeichernCB.Checked     := true;
      AutoSpeichernLabel.Enabled  := true;
      AutoSpeichernEdit.Enabled   := true;
      AutoSpeichernUpDown.Enabled := true;
      AutoSpeichernEdit.Text      := IntToStr(opAutoSpeichernTrz);
    end else
    begin
      AutoSpeichernCB.Checked     := false;
      AutoSpeichernLabel.Enabled  := false;
      AutoSpeichernEdit.Enabled   := false;
      AutoSpeichernUpDown.Enabled := false;
      AutoSpeichernEdit.Text      := '';
    end;
    ZeitFormatRG.ItemIndex    := 0;
    TrennZeichenCB.ItemIndex  := 0;
    RfidSetzen;
    RndAnzeigeCB.Checked      := false;
    UpdateRndWarnung;
    TlnAnzeigeCB.Checked      := false;
  finally
    Updating := false;
    SetzeVorgabeBtn(nil);
    DisableButtons := false;
  end;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.CancelButtonClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  ModalResult := mrCancel;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.OkButtonClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var S1,S2 : String;
    i : Integer;
    SnrGueltig : Boolean;
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    TztHauptDlg.Repaint;

    // Validate wird nicht automatisch ausgef�hrt bei ENTER-Taste
    if not LaengeEdit.ValidateEdit then Exit;
    if not AutoSpeichernEdit.ValidateEdit then Exit;
    if not RndWarnungEdit.ValidateEdit then Exit;

    if (RfidModus <> RfidRB.Checked) or
       (RfidRB.Checked and (RfidZeichen <> StrToIntDef(LaengeEdit.Text,0))) or
       (RfidRB.Checked and (RfidHex <> HexCB.Checked)) then
    begin
      // Snr l�nger als 4 verhindern, sonst alles zulassen
      if RfidModus and not RfidRB.Checked and // Wechsel zum Snr-Modus: Zeichenl�nge pr�fen
         (TztHauptDlg.TztGrid.ItemCount > 1) or
         ((TztHauptDlg.TztGrid.ItemCount = 1) and not TTztObj(TztHauptDlg.TztGrid[0]).InitWert) then
      begin
        SnrGueltig := true;
        for i:=0 to TztColl.Count-1 do
          if (Length(TztColl[i].SnrRfid) > 4) or
             (Length(TztColl[i].SnrRfid) > 0)and(StrToIntDef(TztColl[i].SnrRfid,0)=0) then
          begin
            SnrGueltig := false;
            Break;
          end;
        if not SnrGueltig then // Zeichenl�nge > 4
          if TriaMessage(Self,'Der Eingabe-Modus wurde von RFID-Code in Startnummer ge�ndert.'+#13+
                         'Ung�ltige Startnummern werden gel�scht.',
                         mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          begin
            OptPageControl.ActivePage := ZeitNahmeTS;
            if RfidRB.CanFocus then RfidRB.SetFocus;
            Exit;
          end else
          begin
            TztHauptDlg.StopPaint := true;
            for i:=TztColl.Count-1 downto 0 do // ung�ltige + LeerItems l�schen
              if (Length(TztColl[i].SnrRfid) > 4) or
                 (Length(TztColl[i].SnrRfid) > 0)and(StrToIntDef(TztColl[i].SnrRfid,0)=0) then
                TztColl.ClearIndex(i);
            TztColl.AddItem(TTztObj.Create(nil,TztColl,oaNoAdd)); // leeres Item am Ende

            TztDatModified := true;
            TztHauptDlg.TztGrid.CollectionUpdate;
            TztHauptDlg.UpdateStatusBar;
            TztHauptDlg.StopPaint := false;
          end;
      end;

      with TztHauptDlg do    // leerzeile anpassen
      begin
        SnrRfidEdit.Text := ''; // immer zur�cksetzen
        RfidModus := RfidRB.Checked;
        if RfidModus then // sonst nicht �ndern
        begin
          RfidZeichen := StrToIntDef(LaengeEdit.Text,0);
          RfidHex := HexCB.Checked;
        end;
      end;

      //InitWerte anpassen, nach setzen von RfidModus
      for i:=0 to TztColl.Count-1 do
        if Rfidmodus then
        begin
          S1 := TztColl[i].SnrRfid;
          while (Length(S1) > 0) and (S1[1] = '0') do
            Delete(S1,1,1);
          TztColl[i].SnrRfid := S1;
        end
        else // ung�ltige Snr vorher gel�scht
        if (TztColl[i].SnrRfid = '') then
          TztColl[i].SnrRfid := '0000';
    end;

    if GetZeitFormat <> ZeitFormat then  // ZeitFormat ge�ndert
    begin
      if ((TztHauptDlg.TztGrid.ItemCount <> 1) or
           not TTztObj(TztHauptDlg.TztGrid[0]).InitWert) and
         (ZeitFormat > GetZeitFormat) then // geringere Genauigkeit
      begin
        if GetZeitFormat = zfZehntel then // ZeitFormat = zfHundertstel
        begin
          S1 := 'Zehntel-Sekunden';
          S2 := 'Hundertstel';
        end else // GetZeitFormat = zfSek
        if ZeitFormat = zfZehntel then
        begin
          S1 := 'Sekunden';
          S2 := 'Zehntel';
        end else // ZeitFormat = zfHundertstel
        begin
          S1 := 'Sekunden';
          S2 := 'Dezimalen';
        end;
        if TriaMessage(Self,'Zeitformat wirklich auf ' + S1 + ' umstellen?' + #13 +
                       'Bei allen bereits erfassten Zeiten werden die '+ S2 + ' endg�ltig gel�scht.',
                       mtConfirmation,[mbOk,mbCancel]) <> mrOk then
        begin
          SetPage(ZeitFormatTS);
          Refresh;
          if ZeitFormatRG.CanFocus then ZeitFormatRG.SetFocus;
          Exit;
        end;
      end;
    end;

    ZeitFormat := GetZeitFormat;
    DecTrennZeichen := GetTrennZeichen;

    AutoUpdate := AutoUpdateCB.Checked;
    MruDateiOeffnen := MruDateiCB.Checked;
    if AutoSpeichernCB.Checked then // Bereichspr�fung
    begin
      if not AutoSpeichernEdit.ValidateEdit then Exit;
      TztHauptDlg.AutoSpeichernInterval := DWord(StrToIntDef(AutoSpeichernEdit.Text,0) * 1000) //sek==>msek
    end else
      TztHauptDlg.AutoSpeichernInterval := 0;

    BackupErstellen := BackupCB.Checked;


    if (TimerModus <> zmUhrZeit) and not StoppUhrCB.Checked then
      if (TztHauptDlg.TztGrid.ItemCount=0) or // gibt es nicht
         (TztHauptDlg.TztGrid.ItemCount = 1) and TTztObj(TztHauptDlg.TztGrid[0]).InitWert or
         (TriaMessage(Self,'Es wurden bereits Zeiten im Stoppuhr-Modus erfasst.'+#13+
                      'M�chten Sie trotzdem zum Uhrzeit-Modus wechseln?',
                      mtConfirmation,[mbOk,mbCancel]) = mrOk) then
      begin
        TztHauptDlg.SetzeTimerModus(zmUhrZeit);
        SpeichereKonfiguration; // Modus und StartUhrzeit in Ini-Datei
      end else
      begin
        SetPage(AllgemeinTS);
        Refresh;
        if StoppUhrCB.CanFocus then StoppUhrCB.SetFocus;
        Exit;
      end
    else
    if (TimerModus = zmUhrZeit) and StoppUhrCB.Checked then
      if (TztHauptDlg.TztGrid.ItemCount=0) or // gibt es nicht
         (TztHauptDlg.TztGrid.ItemCount = 1) and TTztObj(TztHauptDlg.TztGrid[0]).InitWert or
         (TriaMessage(Self,'Es wurden bereits Zeiten im Uhrzeit-Modus erfasst.'+#13+
                      'M�chten Sie trotzdem zum Stoppuhr-Modus wechseln?',
                      mtConfirmation,[mbOk,mbCancel]) = mrOk) then
      begin
        TztHauptDlg.SetzeTimerModus(zmStop);
        SpeichereKonfiguration; // Modus und StartUhrzeit in Ini-Datei
      end else
      begin
        SetPage(AllgemeinTS);
        Refresh;
        if StoppUhrCB.CanFocus then StoppUhrCB.SetFocus;
        Exit;
      end;

    if ZeitUngleichCB.Checked then ZeitGleich := zgGleichNok
                              else ZeitGleich := zgGleichOk;

    BeepSignal := BeepSignalCB.Checked;

    SpalteZahl := RndAnzeigeCB.Checked;
    RndCheckZahl := StrToIntDef(RndWarnungEdit.Text,1);

    if TlnAnzeigeCB.Enabled then
    begin
      if TlnAnzeigeCB.Checked and not SpalteTln then
        TztStartliste.Anzeigen;
      SpalteTln := TlnAnzeigeCB.Checked;
    end;

    TztHauptDlg.UpdateLayout;
    ModalResult := mrOk;

  finally
    DisableButtons := false;
  end;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TTztOptDialog.HilfeButtonClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
    Application.HelpContext(0600);  // Optionen
end;


end.
