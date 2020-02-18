unit uFuncoesArquivos;

interface
uses
  Classes, IOUtils, Winapi.ShellAPI;

  function ListarArquivos(ADiretorio : string; var Arquivos : TStringList) : Boolean;
  function MoverArquivo(pArquivo: String; pDiretorioDestino: String): Boolean;
  function apagarArquivo(ANomeArquivo : string) : Boolean;
  procedure copiarArquivo(AOrigem : string; ADestino : string);
  procedure apagarArquivosDiretorio(ADiretorio : string);
  procedure MoverArquivosDestino(De, Para, Arq : string);
  function ExisteArquivos(ADiretorio : string) : Boolean;
  procedure ApagarArquivosPasta(const ADiretorio : string);
  procedure ApagarDiretorio(var ADiretorio : string);
function DiretorioEstaVazio(ADiretorio: string): Boolean;

implementation

uses
    Dialogs,
    SysUtils,
    uPCRegistro,
    Windows,
    Vcl.Forms;

function DiretorioEstaVazio(ADiretorio: string): Boolean;
var SR: TSearchRec;
    I: Integer;
begin
  Result := False;

  FindFirst(IncludeTrailingPathDelimiter(ADiretorio) + '*', faAnyFile, SR);
  try
    for I := 1 to 2 do
    begin
      if (SR.Name = '.') or (SR.Name = '..') then
       Result := FindNext(SR) <> 0;
    end;
  finally
    SysUtils.FindClose(SR);
  end;
end;

procedure ApagarDiretorio(var ADiretorio : string);
var
    OpStruc: TSHFileOpStruct;
    FromBuffer, ToBuffer: Array[0..128] of Char;
    vDiretorio : string;
begin
  vDiretorio := Trim(ADiretorio);

  {Remover barra do fim do caminho problema em alguns SO Windows}
  if vDiretorio[vDiretorio.Length] = '\' then
  begin
    vDiretorio[vDiretorio.Length] := ' ';
    vDiretorio := Trim(vDiretorio);
  end;

  if DirectoryExists(vDiretorio) then
  begin
    fillChar( OpStruc, Sizeof(OpStruc), 0 );
    FillChar( FromBuffer, Sizeof(FromBuffer), 0 );
    FillChar( ToBuffer, Sizeof(ToBuffer), 0 );
    StrPCopy( FromBuffer, vDiretorio);

    With OpStruc Do
    Begin
      Wnd := Application.Handle;
      wFunc:=FO_DELETE;
      pFrom:= @FromBuffer;
      pTo:= @ToBuffer;
      fFlags:= FOF_NO_UI;
      fAnyOperationsAborted:=False;
      hNameMappings:=nil;
      ShFileOperation(OpStruc);
    end;
  end;
end;

procedure ApagarArquivosPasta(const ADiretorio : string);
var vListaArquivo : TStringList;
    vArquivo : string;
begin
  vListaArquivo := TStringList.Create;
  try
    ListarArquivos(ADiretorio, vListaArquivo);

    for vArquivo in vListaArquivo do
      apagarArquivo(ADiretorio + vArquivo);

  finally
    FreeAndNil(vListaArquivo);
  end;
end;

procedure copiarArquivo(AOrigem : string; ADestino : string);
begin
  if FileExists(AOrigem) then
  begin
    {Apagando arquivo da pasta de destino}
    if FileExists(ADestino) then
      apagarArquivo(ADestino);

    {Copiando Arquivo de bkp}
    Windows.CopyFile(PWideChar(AOrigem), PWideChar(ADestino), True);
  end;
end;

procedure MoverArquivosDestino(De, Para, Arq : string);
var
   Search : TSearchRec;
   Done : Boolean;
   Contador : Integer;
begin
   // NOTA: De e Para devem terminar com contrabarra (\)
   Done := FindFirst(De + Arq + '*.*', faAnyFile, Search) <> 0;
   Contador := 0;

   while (not Done) and (Contador < 3) do
   begin
      if (Search.Attr and faDirectory) <> faDirectory then
      begin
         try
           if FileExists(Para + Search.Name) then
              ApagarArquivo(Para + Search.Name);

           //uGerarLog.Escrever_LogCx('[MOVER ARQUIVO] De: ' + De + Search.Name + '; Para: ' + Para + Search.Name);
           IOUtils.TFile.Copy(De + Search.Name, Para + Search.Name);

           {Tenta apagar o arquivo após copiar Autor: Hugo Oliveira}
           if IOUtils.TFile.Exists(De + Search.Name) then
             IOUtils.TFile.Delete(De + Search.Name);

           Done := FindNext(Search) <> 0;
         except
           on e: Exception do
           begin
             //uGerarLog.Escrever_LogCx('[ERRO MOVER ARQUIVO] Erro retornado: ' + e.message);
             Done := False;
           end;
         end;
      end;
      Inc(Contador);
   end;
end;

procedure apagarArquivosDiretorio(ADiretorio : string);
var vListaArquivos : TStringList;
    vI : Integer;
begin
  vListaArquivos := TStringList.Create;
  try
    ListarArquivos(ADiretorio, vListaArquivos);

    for vI := 0 to vListaArquivos.Count - 1 do
      apagarArquivo(ADiretorio + vListaArquivos[vI]);

  finally
    FreeAndNil(vListaArquivos);
  end;
end;

function apagarArquivo(ANomeArquivo : string) : Boolean;
begin
  Result := not FileExists(ANomeArquivo);

  if not Result then
    Result := SysUtils.DeleteFile(ANomeArquivo);
end;

function MoverArquivo(pArquivo: String; pDiretorioDestino: String): Boolean;
begin
  result := true;

  try
    if IOUtils.TFile.Exists(pDiretorioDestino + ExtractFileName(pArquivo)) then
      apagarArquivo(pDiretorioDestino + ExtractFileName(pArquivo));

    IOUtils.TFile.Move(pArquivo, pDiretorioDestino + ExtractFileName(pArquivo));
  except
    on e: Exception do
  end;

  {Se arquivo ainda existir no diretório de origem, então não foi possível movê-lo}
  if FileExists(pArquivo) then
  begin
    result := false;
  end;

end;


function ExisteArquivos(ADiretorio : string) : Boolean;
var Ret : Integer;
    Search : TSearchRec;
begin
  Result := False;

  {$WARN SYMBOL_PLATFORM OFF}
    Ret := FindFirst(ADiretorio + '\*.*', faArchive, Search);
  {$WARN SYMBOL_PLATFORM ON}

  try
    if Ret = 0 then
      Result := True;

  finally
    SysUtils.FindClose(Search);
  end;
end;

function ListarArquivos(ADiretorio : string; var Arquivos : TStringList) : Boolean;
var Ret : Integer;
    Search : TSearchRec;
begin
  if not Assigned(Arquivos) then
    Arquivos := TStringList.create();

  Result := False;

  {$WARN SYMBOL_PLATFORM OFF}
    Ret := FindFirst(ADiretorio + '\*.*', faArchive, Search);
  {$WARN SYMBOL_PLATFORM ON}


  try
    while Ret = 0 do
    begin
       Arquivos.Add(Search.Name);
       Result := True;

       Ret := FindNext(Search);

       if Ret <> 0 then
       begin
          //Arquivos.Add(F.Name);
          //Result := True;
          //Break;
       end;
    end;

  finally
    begin
      SysUtils.FindClose(Search);
    end;
  end;
end;
end.
