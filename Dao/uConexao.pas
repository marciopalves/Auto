unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.FB,
  System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.Script;

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
    function CriarScript: TFDScript;
  end;

  const
    PATH_BANCO: String = 'C:\marcio\teste\Auto\BD\AUTO.FDB';

implementation

uses
  uAtualizaBanco;

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin
  try
    FConn.Params.DriverID := 'FB';
    FConn.Params.Database := PATH_BANCO;
    FConn.Params.UserName := 'SYSDBA';
    FConn.Params.Password := 'masterkey';
    FConn.LoginPrompt     := False;
    FConn.Open();
  except
    raise Exception.Create('Erro ao conectar no banco de dados!');
  end;
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

function TConexao.CriarScript: TFDScript;
var
  vScript : TFDScript;
begin
  vScript := TFDScript.Create(nil);
  vScript.Connection := FConn;
  vScript.Connection.DriverName := 'FB';

  Result := vScript;
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

end.
