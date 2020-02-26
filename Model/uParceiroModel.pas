unit uParceiroModel;

interface

uses
  uEnumerado, uConexao, FireDAC.Comp.Client, System.SysUtils;

type
  TParceiroModel = class
  private
    FAcao: TAcao;
    FCodigo: Integer;
    FNome: string;
    FCpfCnpj: string;

  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Acao: TAcao read FAcao write FAcao;
    property CpfCnpj : string read FCpfCnpj write FCpfCnpj;
  end;

type
  TParceiroRepository = class
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

{ TParceiroDao }

function TParceiroRepository.Alterar(AClienteModel: TParceiroModel): Boolean;
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

constructor TParceiroRepository.Create;
begin
//  FConexao := TSistemaControl.GetInstanceConexao().Conexao;
end;

function TParceiroRepository.Excluir(AClienteModel: TParceiroModel): Boolean;
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

function TParceiroRepository.GetId(AAutoIncrementar: Integer): Integer;
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

function TParceiroRepository.Incluir(AClienteModel: TParceiroModel): Boolean;
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

function TParceiroRepository.Obter: TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();

  vQry.Open('select codigo, nome from parceiro order by 1');

  Result := vQry;
end;

end.
