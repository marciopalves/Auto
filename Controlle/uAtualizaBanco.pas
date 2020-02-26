unit uAtualizaBanco;

interface

uses System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Comp.Script,
     Vcl.Forms;

type

  TBanco = Class

  public
    ///  <summary>Método que atualiza objetos do Banco de dados </summary>
    ///  <param name="pNome">Nome do recurso que vai atualizar</param>
    ///  <param name="pMensagem">Mensagens referente ao processo/etapas </param>
    ///  <returns>True se o processamento foi ok e False para possíveis exceções</returns>
    class function AtualizarRecurso(const pNome:String; out pMensagem: TStringList): Boolean;
  private
    ///  <summary>Método Verifica a existencia do objeto no banco de dados </summary>
    ///  <param name="pNome">Nome do recurso que vai atualizar</param>
    ///  <param name="pMensagem">Mensagens se encontrou o objeto ou não </param>
    ///  <returns>True se encontrou o objeot no banco de dados e False caso não encontre</returns>
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
  vScript : TFDScript;
  vCaminhoArquivo: String;
  FConexao: TConexao;
begin
  FConexao := TSistemaControl.GetInstanceConexao().Conexao;
  vScript  := FConexao.CriarScript;
  try
    vsMensagem := StringReplace(' Atualizar Recurso  %s Inicio', '%s', pNome, []);
    pMensagem.Add(vsMensagem);
    try
      vCaminhoArquivo := ExtractFilePath(Application.ExeName) + 'ArqRecursos\' + pNome + '.SQL';
      ExtrairRecursoSQL(vCaminhoArquivo);

      vScript.SQLScripts.Clear;
      vScript.SQLScriptFileName := vCaminhoArquivo;

      vScript.ValidateAll;
      vScript.ExecuteAll;

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
    FreeAndNil(vScript);
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
