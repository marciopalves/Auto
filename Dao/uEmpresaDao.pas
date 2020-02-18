unit uEmpresaDao;

interface

uses
  uEmpresaModel, FireDAC.Comp.Client, uSistemaControl, System.SysUtils;

type
  TEmpresaDao = class
  public
    procedure carregar(AEmpresaModel: TEmpresaModel; ACodigo: Integer);
  end;

implementation

{ TEmpresaDao }

procedure TEmpresaDao.carregar(AEmpresaModel: TEmpresaModel; ACodigo: Integer);
var
  vQuery: TFDQuery;
begin
  vQuery := TSistemaControl.GetInstanceConexao().Conexao.CriarQuery;
  try
    vQuery.Open('select codigo, rsocial from empresa where codigo = :codigo ', [ACodigo]);
    try
      AEmpresaModel.Codigo := vQuery.Fields[0].AsInteger;
      AEmpresaModel.RSocial := vQuery.Fields[1].AsString;
    finally
      vQuery.Close;
    end;
  finally
    vQuery.Free;
  end;
end;

end.
