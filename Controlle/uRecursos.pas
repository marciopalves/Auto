unit uRecursos;

interface

uses
  Classes, SysUtils, Forms, Windows;

procedure Extrair_ArquivosRecurso(pResName : string; pResType : string; pCaminhoExtrair : string);
procedure ExtrairRecursoSQL(const pCaminhoExtracao : String);

implementation

uses
  uFuncoesArquivos;

procedure Extrair_ArquivosRecurso(pResName : string; pResType : string; pCaminhoExtrair : string);
var
  Res : TResourceStream;
Begin
  ForceDirectories(ExtractFilePath(pCaminhoExtrair));
  Res := TResourceStream.Create(Hinstance, pResName, PChar(pResType));
  Try
    if FileExists(pCaminhoExtrair) then
      ApagarArquivo(pCaminhoExtrair);

    Res.SavetoFile(pCaminhoExtrair);//Salva imagem no caminho especificado
  Finally
    FreeAndNil(Res);
  End;
End;

procedure ExtrairRecursoSQL(const pCaminhoExtracao : String);
var
  vNomeRecurso : string;
begin
  vNomeRecurso := ChangeFileExt(ExtractFileName(pCaminhoExtracao), '');
  ForceDirectories(ExtractFilePath(pCaminhoExtracao));
  Extrair_ArquivosRecurso(vNomeRecurso,  'TXT',  pCaminhoExtracao);
end;

end.
