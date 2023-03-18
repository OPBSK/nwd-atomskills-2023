program mail_server;

uses
  Vcl.Forms,
  uMain in 'forms\uMain.pas' {frmMain},
  uDM in 'DM\uDM.pas' {dm: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
