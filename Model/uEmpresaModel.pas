unit uEmpresaModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client;

type
  TEmpresaModel = class
  private
    FCodigo: Integer;
    FRazaoSocial: string;

  public
    procedure Carregar(ACodigo: Integer);

    property Codigo: Integer read FCodigo write FCodigo;
    property RSocial: string read FRazaoSocial write FRazaoSocial;
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
