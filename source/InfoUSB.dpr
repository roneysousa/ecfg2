program InfoUSB;

uses
  Forms,
  Windows,
  uPrincipalUSB in 'uPrincipalUSB.pas' {frmPrincipalUSB},
  uSobre in 'uSobre.pas' {frmSobre};
{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;         // <==== aqui.
  Application.CreateForm(TfrmPrincipalUSB, frmPrincipalUSB);
  Showwindow(application.handle,sw_hide);    // <== Este oculta da TaskBar
  Application.Run;
end.
