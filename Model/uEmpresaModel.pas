unit uEmpresaModel;

interface

uses
  System.SysUtils;

type
  TEmpresaModel = class
  private
    FCodigo: Integer;
    FRSocial: string;

    procedure SetCodigo(const Value: Integer);
    procedure SetRSocial(const Value: string);
  public
    procedure Carregar(ACodigo: Integer);

    property Codigo: Integer read FCodigo write SetCodigo;
    property RSocial: string read FRSocial write SetRSocial;
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

procedure TEmpresaModel.SetRSocial(const Value: string);
begin
  FRSocial := Value;
end;

end.