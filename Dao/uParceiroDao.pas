unit uParceiroDao;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, uConexao, uParceiroModel;

type
  TParceiroDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Incluir(AClienteModel: TParceiroModel): Boolean;
    function Alterar(AClienteModel: TParceiroModel): Boolean;
    function Excluir(AClienteModel: TParceiroModel): Boolean;
    function GetId(AAutoIncrementar: Integer): Integer;
    function Obter: TFDQuery;
  end;

implementation

{ TClienteDao }

uses uSistemaControl;

function TParceiroDao.Alterar(AClienteModel: TParceiroModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.ExecSQL('update parceiro set nome = :nome, cpfcnpj = :cpfcnpj  where (codigo = :codigo)', [AClienteModel.Nome, AClienteModel.CpfCnpj, AClienteModel.Codigo]);

    Result := True;
  finally
    vQry.Free;
  end;
end;

constructor TParceiroDao.Create;
begin
  FConexao := TSistemaControl.GetInstanceConexao().Conexao;
end;

function TParceiroDao.Excluir(AClienteModel: TParceiroModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.ExecSQL('delete from parceiro where (codigo = :codigo)', [AClienteModel.Codigo]);

    Result := True;
  finally
    vQry.Free;
  end;
end;

function TParceiroDao.GetId(AAutoIncrementar: Integer): Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.Open('select gen_id(Seq_Parceiro, ' + IntToStr(AAutoIncrementar) + ' ) from rdb$database');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TParceiroDao.Incluir(AClienteModel: TParceiroModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into parceiro (codigo, nome, cpfcnpj) values (:codigo, :nome, :cpfcnpj)', [AClienteModel.Codigo, AClienteModel.Nome, AClienteModel.CpfCnpj]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TParceiroDao.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();

  vQry.Open('select codigo, nome from parceiro order by 1');

  Result := vQry;
end;

end.
