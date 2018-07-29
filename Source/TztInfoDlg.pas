unit TztInfoDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, jpeg;

procedure ZeigeInfo;

  type
  TTZInfoDialog = class(TForm)
    OkButton: TButton;
    InfoPanel: TPanel;
    TriaZeitImage: TImage;
    TztLabel: TLabel;
    VersionLabel: TLabel;
    CopyRightLabel: TLabel;
    NameLabel: TLabel;
    DownLoadText: TLabel;
    procedure DownLoadTextClick(Sender: TObject);
    procedure LinkMouseEnter(Sender: TObject);
    procedure LinkMouseLeave(Sender: TObject);
    procedure LinkMouseDown(Sender: TObject; Button: TMouseButton;
                            Shift: TShiftState; X, Y: Integer);
    procedure LinkMouseUp(Sender: TObject; Button: TMouseButton;
                          Shift: TShiftState; X, Y: Integer);
    //procedure EMailTextClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  TZInfoDialog: TTZInfoDialog;

implementation

uses TztHistory,AllgConst,VistaFix,TztMain;

{$R *.dfm}
             

(******************************************************************************)
procedure ZeigeInfo;
(******************************************************************************)
begin
  TZInfoDialog := TTZInfoDialog.Create(TztHauptDlg);
  try
    TZInfoDialog.PopupParent := TztHauptDlg; // VistaFix
    TZInfoDialog.ShowModal;
  finally
    FreeAndNil(TZInfoDialog);
  end;
end;

(*============================================================================*)
constructor TTZInfoDialog.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);
  //TztLabel.Caption      := Application.Title;
  VersionLabel.Caption   := 'Version  '+cnVersionsNummer;
  CopyRightLabel.Caption := 'Copyright � 1990 - '+cnVersionsJahr;
  VistaFix.SetzeFonts(Font);
  VistaFix.SetzeFonts(TztLabel.Font);
  VistaFix.SetzeFonts(DownLoadText.Font);
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTZInfoDialog.DownLoadTextClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  ShellExecute(Application.Handle,'open',PChar(cnHomePage),
               nil,nil, sw_ShowNormal);
  // keine Fehlermeldung (wenn Result <= 32)
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTZInfoDialog.LinkMouseEnter(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Screen.Cursor := crHandPoint;    { Cursor als HandZeiger }
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTZInfoDialog.LinkMouseLeave(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Screen.Cursor := CursorAlt;  { Alten Zustand wiederherstellen }
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTZInfoDialog.LinkMouseDown(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with Sender as TLabel do Font.Color := clRed;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TTZInfoDialog.LinkMouseUp(Sender: TObject; Button: TMouseButton;
                                  Shift: TShiftState; X, Y: Integer);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with Sender as TLabel do Font.Color := clBlue;
end;


end.


