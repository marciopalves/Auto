unit uSistemaControl;

interface

uses
  System.SysUtils, uConexao, uEmpresaModel;

type
  TSistemaControl = class
  private
    FConexao     : TConexao;
    FEmpresaModel: TEmpresaModel;

    class var FInstance: TSistemaControl;
    constructor Create();
  public

    destructor Destroy; override;

    procedure AtualizaBancoDados;

    procedure CarregarEmpresa(ACodigoEmpresa: Integer);

    class function GetInstanceConexao: TSistemaControl;

     property Conexao: TConexao read FConexao write FConexao;
     property EmpresaModel: TEmpresaModel read FEmpresaModel write FEmpresaModel;
  end;

implementation

{ TSistemaControl }

Uses System.Classes, uAtualizaBanco;

procedure TSistemaControl.CarregarEmpresa(ACodigoEmpresa: Integer);
begin
  EmpresaModel.Carregar(ACodigoEmpresa);
end;

constructor TSistemaControl.Create();
begin
  FConexao     := TConexao.Create;
  EmpresaModel := TEmpresaModel.Create();
end;

destructor TSistemaControl.Destroy;
begin
  FEmpresaModel.Free;
  FConexao.Free;

  inherited;
end;

class function TSistemaControl.GetInstanceConexao: TSistemaControl;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance := TSistemaControl.Create();
  end;

  Result := Self.FInstance;
end;

procedure TSistemaControl.AtualizaBancoDados;
var
  vMsg: TStringList;
begin
  vMsg := TStringList.Create();
  try
    uAtualizaBanco.TBanco.AtualizarRecurso('Domain', vMsg);
    uAtualizaBanco.TBanco.AtualizarRecurso('Sequence', vMsg);
    uAtualizaBanco.TBanco.AtualizarRecurso('Empresa', vMsg);
    uAtualizaBanco.TBanco.AtualizarRecurso('Parceiro', vMsg);
  finally
    //ForceDirectories(ExtractFilePath(Application.ExeName) + 'Log\AtualizarRecurso');
    FreeAndNil(vMsg);
  end;
end;

end.
