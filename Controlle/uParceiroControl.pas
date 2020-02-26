unit uParceiroControl;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uParceiroModel, uEnumerado;

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

{ TParceiroControl }

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
  vParceiroRepository: TParceiroRepository;
begin
  vParceiroRepository := TParceiroRepository.Create;
  try
    Result := vParceiroRepository.GetId(AAutoIncrementar);
  finally
    vParceiroRepository.Free;
  end;
end;


function TParceiroControl.Obter: TFDQuery;
var
  vParceiroRepository: TParceiroRepository;
begin
  vParceiroRepository := TParceiroRepository.Create;
  try
    Result := vParceiroRepository.Obter;
  finally
    vParceiroRepository.Free;
  end;
end;

function TParceiroControl.Salvar: Boolean;
var
  vParceiroReposiyoty: TParceiroRepository;
begin
  Result := False;
  vParceiroReposiyoty := TParceiroRepository.Create;
  try
    case ParceiroModel.Acao of
      uEnumerado.tacIncluir: Result := vParceiroReposiyoty.Incluir(ParceiroModel);
      uEnumerado.tacAlterar: Result := vParceiroReposiyoty.Alterar(ParceiroModel);
      uEnumerado.tacExcluir: Result := vParceiroReposiyoty.Excluir(ParceiroModel);
    end;
    Result := True;
  finally
    vParceiroReposiyoty.Free;
  end;

end;

end.
