unit uFrmPrincipalView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConexao, Vcl.StdCtrls, uSistemaControl, Vcl.ComCtrls, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls, Vcl.ActnMenus,
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI;

type
  TfrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    ActionManager1: TActionManager;
    actParceiro: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    FDConnection1: TFDConnection;
    FDScript1: TFDScript;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    actEmpresa: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actParceiroExecute(Sender: TObject);
    procedure actEmpresaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uFrmParceiroView;

procedure TfrmPrincipal.actEmpresaExecute(Sender: TObject);
begin
//
end;

procedure TfrmPrincipal.actParceiroExecute(Sender: TObject);
begin
  if frmCadastroParceiro = nil then
    Application.CreateForm(TfrmCadastroParceiro, frmCadastroParceiro);
  try
    frmCadastroParceiro.ShowModal;
  finally
    frmCadastroParceiro.Release;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  TSistemaControl.GetInstanceConexao();
  //TSistemaControl.GetInstanceConexao().AtualizaBancoDados;
  TSistemaControl.GetInstanceConexao().CarregarEmpresa(1);

  StatusBar1.Panels[0].Text := 'Vers�o: 1.0';

  StatusBar1.Panels[1].Text := 'Empresa: ' + FormatFloat('00', TSistemaControl.GetInstanceConexao().EmpresaModel.Codigo) + ' - ' +
  TSistemaControl.GetInstanceConexao().EmpresaModel.RSocial;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  TSistemaControl.GetInstanceConexao().Destroy();
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
