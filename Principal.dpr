program Principal;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Ranorex},
  LibUtil in 'LibUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRanorex, Ranorex);
  Application.Run;
end.
