program TriaZeit;

uses
  Vcl.Forms,
  TztMain in 'Source\TztMain.pas' {TztHauptDlg},
  AllgComp in 'Source\AllgComp.pas',
  AllgConst in 'Source\AllgConst.pas',
  AllgFunc in 'Source\AllgFunc.pas',
  AllgObj in 'Source\AllgObj.pas',
  VistaFix in 'Source\VistaFix.pas',
  MruObj in 'Source\MruObj.pas',
  TztAllg in 'Source\TztAllg.pas',
  TztInfoDlg in 'Source\TztInfoDlg.pas' {TZInfoDialog},
  TztHistory in 'Source\TztHistory.pas',
  TztDat in 'Source\TztDat.pas',
  TztStrtLst in 'Source\TztStrtLst.pas' {TztStartListe},
  hh in 'Source\hh.pas',
  hh_funcs in 'Source\hh_funcs.pas',
  TztAbglDlg in 'Source\TztAbglDlg.pas' {AbglDialog},
  TztConfig in 'Source\TztConfig.pas',
  TztDruckDlg in 'Source\TztDruckDlg.pas' {DruckForm},
  TztOptDlg in 'Source\TztOptDlg.pas' {TztOptDialog},
  TztToDo in 'Source\TztToDo.pas',
  TztUpdDlg in 'Source\TztUpdDlg.pas' {UpdateDialog};

//{$R *.RES} ersetzt durch TriaZeitIcon.res mit Vista-Icon
{$R 'TriaZeitIcon.res'}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '';
  Application.CreateForm(TTztHauptDlg, TztHauptDlg);
  Application.CreateForm(TTztStartListe, TztStartListe);
  Application.CreateForm(TDruckForm, DruckForm);
  Application.Run;
end.
