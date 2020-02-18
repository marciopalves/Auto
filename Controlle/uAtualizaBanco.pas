unit uAtualizaBanco;

interface

uses System.SysUtils, System.Classes, FireDAC.Comp.Client, Vcl.Forms;

type

  TBanco = Class

  public
    class function AtualizarRecurso(const pNome:String; out pMensagem: TStringList): Boolean;
  private
    class function VerificaObjetoBancoDados(const pNome:string; out pMensagem: TStringList): Boolean;

  end;


implementation

uses
   uRecursos, uSistemaControl, uConexao;

{ TBanco }

class function TBanco.AtualizarRecurso(const pNome:String;
out pMensagem: TStringList): Boolean;
var
  vsMensagem : String;
  vQry : TFDQuery;
  vCaminhoArquivo: String;
  FConexao: TConexao;
begin
  FConexao := TSistemaControl.GetInstanceConexao().Conexao;
  vQry := FConexao.CriarQuery;
  try
    vsMensagem := StringReplace(' Atualizar Recurso  %s Inicio', '%s', pNome, []);
    pMensagem.Add(vsMensagem);
    try
      vCaminhoArquivo := ExtractFilePath(Application.ExeName) + 'ArqRecursos\' + pNome + '.SQL';
      ExtrairRecursoSQL(vCaminhoArquivo);

      vQry.SQL.Clear;
      vQry.SQL.LoadFromFile(vCaminhoArquivo);
      vQry.Execute;
      Result := True;
    except
      on e:Exception do
      begin
        Result := False;
        vsMensagem := StringReplace(' Erro ao Atualizar Recurso  %s Inicio', '%s', pNome, []);
        pMensagem.Add(vsMensagem);
      end;
    end;

  finally
    VerificaObjetoBancoDados(pNome, pMensagem);
    vsMensagem := StringReplace(' Atualizar Recurso  %s Fim', '%s', pNome, []);
    pMensagem.Add(vsMensagem);
    vQry.Close;
    FreeAndNil(vQry);
  end;
end;

class function TBanco.VerificaObjetoBancoDados(const pNome:string;
out pMensagem: TStringList): Boolean;
const
  SQL_VALIDAR = ' select rdb$relation_name, rdb$field_name'+sLineBreak+
                ' from rdb$relation_fields'+sLineBreak+
                ' where RDB$RELATION_NAME = :Objeto;';
var
  vQry : TFDQuery;
  vsMensagem:string;
begin
  vQry := TSistemaControl.GetInstanceConexao().Conexao.CriarQuery;
  try
    vQry.SQL.Clear;
    vQry.SQL.Add(SQL_VALIDAR);
    vQry.ParamByName('Objeto').AsString := pNome;
    vQry.Open;
    Result := not vQry.IsEmpty;
  finally
    if Result then
      vsMensagem := StringReplace(' Objeto %s criado com sucesso! ', '%s', pNome, [])
    else vsMensagem := StringReplace(' Objeto %s não criado! ', '%s', pNome, []);

    pMensagem.Add(vsMensagem);

    vQry.Close;
    FreeAndNil(vQry);
  end;
end;

end.
