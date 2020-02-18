unit uParceiroControl;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uParceiroModel, uParceiroDao, uEnumerado;

type
  TParceiroControl = class
  private
    FParceiroModel: TParceiroModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Salvar: Boolean;
    function Obter: TFDQuery;
    function GetId(AAutoIncrementar: Integer): Integer;

    property ParceiroModel: TParceiroModel read FParceiroModel write FParceiroModel;
  end;

implementation

{ TClienteControl }

constructor TParceiroControl.Create;
begin
  FParceiroModel := TParceiroModel.Create;
end;

destructor TParceiroControl.Destroy;
begin
  FParceiroModel.Free;

  inherited;
end;

function TParceiroControl.GetId(AAutoIncrementar: Integer): Integer;
var
  vParceiroDao: TParceiroDao;
begin
  vParceiroDao := TParceiroDao.Create;
  try
    Result := vParceiroDao.GetId(AAutoIncrementar);
  finally
    vParceiroDao.Free;
  end;
end;


function TParceiroControl.Obter: TFDQuery;
var
  vParceiroDao: TParceiroDao;
begin
  vParceiroDao := TParceiroDao.Create;
  try
    Result := vParceiroDao.Obter;
  finally
    vParceiroDao.Free;
  end;
end;

function TParceiroControl.Salvar: Boolean;
var
  vParceiroDao: TParceiroDao;
begin
  Result := False;
  vParceiroDao := TParceiroDao.Create;
  try
    case ParceiroModel.Acao of
      uEnumerado.tacIncluir: Result := vParceiroDao.Incluir(ParceiroModel);
      uEnumerado.tacAlterar: Result := vParceiroDao.Alterar(ParceiroModel);
      uEnumerado.tacExcluir: Result := vParceiroDao.Excluir(ParceiroModel);
    end;
    Result := True;
  finally
    vParceiroDao.Free;
  end;

end;

end.
