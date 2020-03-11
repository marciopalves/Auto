unit uEmpresaModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uEnumerado;

type
  TEmpresaModel = class
  private
    FCodigo: Integer;
    FRazaoSocial: string;
    FNomeFantasia: string;
    FCgc: string;
    FIe: string;
    FEmail: String;
    FTelefone: String;
    FTelefone2: String;
    FEndereco: String;
    FCidade: string;
    FComplementeo: String;
    FBairro: String;
    FUF: string;
    FCep: String;
    FAtivo: Boolean;
    FTipoEmpresa: TEmpresa;
    FAcao: TAcao;

  public
    procedure Carregar(ACodigo: Integer);
    property Codigo: Integer read FCodigo write FCodigo;
    property RSocial: string read FRazaoSocial write FRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property Cgc: string read Fcgc write Fcgc;
    property Ie: string read Fie write Fie;
    property Email: String read FEmail write FEmail;
    property Telefone : String read FTelefone write FTelefone;
    property Telefone2: String read FTelefone2 write FTelefone2;
    property Endereco: String read FEndereco write FEndereco;
    property Cidade: string read FCidade write FCidade;
    property Complementeo: String read FComplementeo write FComplementeo;
    property Bairro: String read FBairro write FBairro;
    property UF: string read FUF write FUF;
    property Cep: String read FCep write FCep;
    property Ativo: Boolean read FAtivo write FAtivo;
    property TipoEmpresa: TEmpresa read FTipoEmpresa write FTipoEmpresa;
    property Acao: TAcao read FAcao write FAcao;

  end;

  type
  TEmpresaRepository = class
  public
    procedure carregar(AEmpresaModel: TEmpresaModel; ACodigo: Integer);
  end;

implementation

{ TEmpresa }

uses uSistemaControl;

procedure TEmpresaModel.Carregar;
var
  vEmpresaRepository: TEmpresaRepository;
begin
  vEmpresaRepository := TEmpresaRepository.Create;
  try
    vEmpresaRepository.carregar(Self, ACodigo);
  finally
    vEmpresaRepository.Free;
  end;
end;

{ TEmpresaRepository }

procedure TEmpresaRepository.carregar(AEmpresaModel: TEmpresaModel; ACodigo: Integer);
var
  vQuery: TFDQuery;
begin
  vQuery := TSistemaControl.GetInstanceConexao().Conexao.CriarQuery;
  try
    vQuery.Open('select id_Empresa, rsocial from empresa where codigo = :codigo ', [ACodigo]);
    try
      AEmpresaModel.Codigo  := vQuery.Fields[0].AsInteger;
      AEmpresaModel.RSocial := vQuery.Fields[1].AsString;
    finally
      vQuery.Close;
    end;
  finally
    vQuery.Free;
  end;
end;

end.
