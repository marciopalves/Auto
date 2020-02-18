unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait, System.Classes;

type
  TConexao = class
  private
    FConn: TFDConnection;

    procedure ConfigurarConexao;
  public

    destructor Destroy; override;
    constructor Create;

    function GetConn: TFDConnection;
    function CriarQuery: TFDQuery;
    Procedure AtualizaBancoDados;
  end;

  const
    PATH_BANCO: String = 'C:\marcio\teste\Auto\BD\AUTO.FDB';//'E:\MVC_DELPHI\MVC_DELPHI\DB_MVC.FDB';

implementation

uses
  uAtualizaBanco;

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin
  FConn.Params.DriverID := 'FB';
  FConn.Params.Database := PATH_BANCO;
  FConn.Params.UserName := 'SYSDBA';
  FConn.Params.Password := 'masterkey';
  FConn.LoginPrompt     := False;
  FConn.Open();

  //Atualizar Banco de Dados
  AtualizaBancoDados;
end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);
  Self.ConfigurarConexao();
end;

function TConexao.CriarQuery: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  vQry.Connection := FConn;

  Result := vQry;
end;

destructor TConexao.Destroy;
begin
  FConn.Free;

  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConn;
end;

procedure TConexao.AtualizaBancoDados;
var
  vMsg: TStringList;
begin
  vMsg := TStringList.Create();
  try
    uAtualizaBanco.TBanco.AtualizarRecurso('Domain', vMsg);
    uAtualizaBanco.TBanco.AtualizarRecurso('Sequence', vMsg);
    uAtualizaBanco.TBanco.AtualizarRecurso('Parceiro', vMsg);
  finally
    FreeAndNil(vMsg);
  end;
end;

end.
