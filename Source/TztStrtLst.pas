unit TztStrtLst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids;


type
  TTztStartListe = class(TForm)
    StrtLstGrid: TStringGrid;
    procedure StrtLstGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                                  Rect: TRect; State: TGridDrawState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create(AOwner: TComponent); override;
    procedure   Anzeigen;
  end;

var
  TztStartListe: TTztStartListe;

implementation

uses TztAllg,AllgFunc,TztMain;

{$R *.dfm}

//******************************************************************************
constructor TTztStartListe.Create(AOwner: TComponent);
//******************************************************************************
begin
  inherited Create(AOwner);

  with StrtLstGrid do
  begin
    Font.Name   := TztHauptDlg.NumFontName; // nur für Header auf Font.Name umschalten
    Font.Size   := TztHauptDlg.NumFontSizeMin;
    Font.Color  := clWindowText;
    Canvas.Font := Font;
    DefaultRowHeight := 20;
    ColWidths[0] := Canvas.TextWidth('x0000x');
    ColWidths[1] := Canvas.TextWidth('xStartnr.x');
    ColWidths[2] := Canvas.TextWidth('xName, Vorname0123456789');
    Cells[0,0] := ' Nr.';
    Cells[1,0] := ' Startnr.';
    Cells[2,0] := ' Name, Vorname';
  end;
  Constraints.MinWidth := Width - ClientWidth + 20 +
                          StrtLstGrid.ColWidths[0] +
                          StrtLstGrid.ColWidths[1] +
                          StrtLstGrid.ColWidths[2] + 3;
  Width := Constraints.MinWidth;
  Constraints.MaxWidth := Width;
end;

//******************************************************************************
procedure TTztStartListe.Anzeigen;
//******************************************************************************
var i : Integer;
begin
  if not Visible then
  begin
    with StrtLstGrid do
    begin
      RowCount := SnrNameListe.Count + 1;
      for i:=0 to SnrNameListe.Count-1 do
      begin
        Cells[0,i+1] := IntToStr(i+1);
        Cells[1,i+1] := Trim(RemLeadZero(SnrNameListe[i]));
          Cells[2,i+1] := ' '+TNameObj(SnrNameListe.Objects[i]).Name;
      end;
    end;
    Left := Application.MainForm.Left + (Application.MainForm.Width DIV 2) - (Width DIV 2);
    Top  := Application.MainForm.Top + (Application.MainForm.Height DIV 2) - (Height DIV 2);
    Show;
  end else
    BringToFront;
  WindowState := wsNormal;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TTztStartListe.StrtLstGridDrawCell(Sender: TObject; ACol,
                            ARow: Integer; Rect: TRect; State: TGridDrawState);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Text : String;
    SpaceLinks,SpaceTop: Integer;
begin
  with StrtLstGrid do
  begin
    if (ARow=0) or (ACol=0) then
      Canvas.Brush.Color := clBtnFace
    else
      Canvas.Brush.Color := clWindow;
    Canvas.FillRect(Rect); // alter Inhalt wird gelöscht

    if ACol=0 then
      Canvas.Font.Color := $00808080
    else
      Canvas.Font.Color := clWindowText;

    Text := Cells[ACol,ARow];
    SpaceTop   := Rect.Top + (Rect.Bottom-Rect.Top - Canvas.TextHeight('0')) DIV 2;
    if ACol = 2 then
      SpaceLinks := Rect.Left + Canvas.TextWidth(' ')
    else
      SpaceLinks := Rect.Left + (Rect.Right-Rect.Left - Canvas.TextWidth(Text)) DIV 2;

    Canvas.TextOut(SpaceLinks, SpaceTop, Text);

    Canvas.Font.Color := clWindowText;
    Canvas.Brush.Color := clWindow;
  end;
end;


end.
