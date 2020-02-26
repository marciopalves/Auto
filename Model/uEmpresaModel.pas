unit uEmpresaModel;

interface

uses
  System.SysUtils;

type
  TEmpresaModel = class
  private
    FCodigo: Integer;
    FRazaoSocial: string;

    procedure SetCodigo(const Value: Integer);
    procedure SetRazaoSocial(const Value: string);
  public
    procedure Carregar(ACodigo: Integer);

    property Codigo: Integer read FCodigo write SetCodigo;
    property RSocial: string read FRazaoSocial write SetRazaoSocial;
  end;

implementation

{ TEmpresa }

uses uEmpresaDao;

procedure TEmpresaModel.Carregar;
var
  vEmpresaDao: TEmpresaDao;
begin
  vEmpresaDao := TEmpresaDao.Create;
  try
    vEmpresaDao.carregar(Self, ACodigo);
  finally
    vEmpresaDao.Free;
  end;
end;

procedure TEmpresaModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TEmpresaModel.SetRazaoSocial(const Value: string);
begin
  FRazaoSocial := Value;
end;

end.
