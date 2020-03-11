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
    FCgc: string;
    FRg: string;
    FNascimento: TDateTime;
    FEmail: String;
    FTelefone: String;
    FTelefone2: String;
    FNomeConjuge: String;
    FCpfConjuge: String;
    FEndereco: String;
    FComplemento: String;
    FBairro: String;
    FCidade: String;
    FUf: String;
    FCep: String;
    FAtivo: Boolean;

  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Acao: TAcao read FAcao write FAcao;
    property Cgc : string read FCgc write FCgc;
    property Rg: string read FRg write FRg;
    property Nascimento: TDateTime read FNascimento write FNascimento;
    property Email: String read FEmail write FEmail;
    property Telefone : String read FTelefone  write FTelefone;
    property Telefone2: String read FTelefone2 write FTelefone2;
    property NomeConjuge: String read FNomeConjuge write FNomeConjuge;
    property CpfConjuge: String read FCpfConjuge write FCpfConjuge;
    property Endereco: String read FEndereco write FEndereco;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property Cidade: String read FCidade write FCidade;
    property Uf: String read FUf write FUf;
    property Cep: String read FCep write FCep;
    property Ativo: Boolean read FAtivo write FAtivo;
  end;

type
  TParceiroRepository = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Incluir(pParceiroModel: TParceiroModel): Boolean;
    function Alterar(pParceiroModel: TParceiroModel): Boolean;
    function Excluir(pParceiroModel: TParceiroModel): Boolean;
    function GetId(AAutoIncrementar: Integer): Integer;
    function Obter: TFDQuery;
    function Pesquisar(const pNome: string; const pCgc: string; const pCodigo: Integer): TFDQuery;
  end;

implementation

{ TParceiroRepository }


constructor TParceiroRepository.Create;
begin

end;

function TParceiroRepository.Alterar(pParceiroModel: TParceiroModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.ExecSQL('update parceiro set nome = :nome, cgc = :cgc, rg = :rg, nascimento = :nascimento,'+
                 ' email = :email, telefone = :telefone, telefone2 = :telefone2,'+
                 ' NomeConjuge = :NomeConjuge, CpfConjuge = :CpfCOnjuge, Endereco = :Endereco, '+
                 ' Complemento = :Complemento, Bairro = :Bairro, Cidade = :Cidade, '+
                 ' UF = :UF, Cep = :Cep, Ativo = :Ativo '+
                 'where (id_Parceiro = :codigo)',
    [pParceiroModel.Nome, pParceiroModel.Cgc, pParceiroModel.Rg, pParceiroModel.Nascimento,
     pParceiroModel.Email, pParceiroModel.Telefone, pParceiroModel.Telefone2, pParceiroModel.NomeConjuge,
     pParceiroModel.CpfConjuge, pParceiroModel.Endereco, pParceiroModel.Uf, pParceiroModel.Cep, pParceiroModel.Ativo,
     pParceiroModel.Codigo]);

    Result := True;
  finally
    vQry.Free;
  end;
end;

function TParceiroRepository.Excluir(pParceiroModel: TParceiroModel): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.ExecSQL('Delete from parceiro where (id_Parceiro = :codigo)', [pParceiroModel.Codigo]);

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
    vQry.Open('select gen_id(Seq_Parceiro, '+ IntToStr(AAutoIncrementar) + ' ) from rdb$database');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;

function TParceiroRepository.Incluir(pParceiroModel: TParceiroModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into parceiro (id_Parceiro, nome, cgc, nascimento, email,'+
                 '            telefone1, telefone2, nomeconjuge, cpfconjuge, ativo,'+
                 '            endereco, complemento, bairro, cidade, uf, cep) '+
                 'values (:codigo, :nome, :cgc, :nascimento, :email, :telefone1, '+
                 '      :telefone2, :nomeconjuge, :cpfconjuge, :ativo, :logradouro, '+
                 '      :complemento, :bairro, :cidade, :uf, :cep)',
                [pParceiroModel.Codigo, pParceiroModel.Nome, pParceiroModel.Cgc, pParceiroModel.Nascimento, pParceiroModel.Email,
                 pParceiroModel.Telefone, pParceiroModel.Telefone2, pParceiroModel.NomeConjuge, pParceiroModel.CpfConjuge, pParceiroModel.Ativo,
                 pParceiroModel.Endereco, pParceiroModel.Complemento, pParceiroModel.Bairro, pParceiroModel.Cidade, pParceiroModel.Uf, pParceiroModel.Cep]);

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

  vQry.Open('select id_Parceiro, nome, cgc from parceiro order by 1');

  Result := vQry;
end;

function TParceiroRepository.Pesquisar(const pNome, pCgc: string;
  const pCodigo: Integer): TFDQuery;
var
  vQry: TFDQuery;
  vWhere: string;
begin
  vQry := FConexao.CriarQuery();
  vQry.SQL.Text:= ' select id_Parceiro, nome, cgc, nascimento, email,'+
                  '        telefone1, telefone2, nomeconjuge, cpfconjuge, ativo,'+
                  '        endereco, complemento, bairro, cidade, uf, cep '+
                  ' from parceiro ';
  if pCodigo > 0 then
  begin
    vQry.SQL.Add('Where Id_Parceiro = :Codigo');
    vQry.ParamByName('Codigo').AsFloat := pCodigo;
  end
  else
  begin
    if pNome <> EmptyStr then
    begin
      vWhere := 'Where nome like '':nome%'' ';
      vQry.SQL.Add(vWhere);
      vQry.ParamByName('nome').AsString := pNome;
    end;

    if pCgc <> EmptyStr then
    begin
      if vWhere <> EmptyStr then
        vWhere := ' And cgc like '':cgc%'' '
      else vWhere := ' Where cgc like '':cgc%'' ';
      vQry.ParamByName('cgc').AsString := pCgc;
    end;
  end;
  vQry.Open();

  Result := vQry;
end;

end.
