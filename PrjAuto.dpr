program PrjAuto;

{$R 'Recursos.res' 'ArqRecursos\Recursos.rc'}

uses
  Vcl.Forms,
  uFrmPrincipalView in 'View\uFrmPrincipalView.pas' {frmPrincipal},
  uConexao in 'Dao\uConexao.pas',
  uSistemaControl in 'Controlle\uSistemaControl.pas',
  uEmpresaModel in 'Model\uEmpresaModel.pas',
  uEnumerado in 'Model\uEnumerado.pas',
  uParceiroModel in 'Model\uParceiroModel.pas',
  uParceiroControl in 'Controlle\uParceiroControl.pas',
  uFrmParceiroView in 'View\uFrmParceiroView.pas' {frmCadastroParceiro},
  uRecursos in 'Controlle\uRecursos.pas',
  uFuncoesArquivos in 'Controlle\uFuncoesArquivos.pas',
  uAtualizaBanco in 'Controlle\uAtualizaBanco.pas',
  uAutoMovel in 'Model\uAutoMovel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
