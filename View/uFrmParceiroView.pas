unit uFrmParceiroView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uParceiroControl, uEnumerado,
  Vcl.ExtCtrls, Vcl.ComCtrls, System.Actions, Vcl.ActnList;

type
  TfrmCadastroParceiro = class(TForm)
    mmTableParceiros: TFDMemTable;
    dsClientes: TDataSource;
    mmTableParceirosCODIGO: TIntegerField;
    mmTableParceirosNOME: TStringField;
    pgParceiro: TPageControl;
    tsVisualizacao: TTabSheet;
    tsDados: TTabSheet;
    pnlBotoes: TPanel;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnNovo: TButton;
    DBGrid1: TDBGrid;
    pnlPesquisa: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    edtNome: TEdit;
    edtCodigo: TEdit;
    edtCgc: TEdit;
    btnPesquisar: TButton;
    actParceiro: TActionList;
    actIncluir: TAction;
    actAlterar: TAction;
    actExcluir: TAction;
    actPesquisar: TAction;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnNovoClick(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
  private
    FControleParceiro: TParceiroControl;

    procedure CarregarParceiros;
    procedure CarregarEdits;
    procedure LimparCampos;
  end;

var
  frmCadastroParceiro: TfrmCadastroParceiro;

implementation

{$R *.dfm}

{ TfrmCadastroCliente }

procedure TfrmCadastroParceiro.btnIncluirClick(Sender: TObject);
begin
  FControleParceiro.ParceiroModel.Acao   := uEnumerado.tacIncluir;
  FControleParceiro.ParceiroModel.Nome   := edtNome.Text;

  if FControleParceiro.Salvar() then
    ShowMessage('Incluido com sucesso.');

  Self.CarregarParceiros();
end;

procedure TfrmCadastroParceiro.actIncluirExecute(Sender: TObject);
begin
  FControleParceiro.ParceiroModel.Codigo := FControleParceiro.GetId(1);
  edtCodigo.Text := FControleParceiro.ParceiroModel.Codigo.ToString();
  LimparCampos;
  edtNome.SetFocus();
end;

procedure TfrmCadastroParceiro.btnAlterarClick(Sender: TObject);
begin
  FControleParceiro.ParceiroModel.Acao   := uEnumerado.tacAlterar;
  FControleParceiro.ParceiroModel.Codigo := StrToInt(edtCodigo.Text);
  FControleParceiro.ParceiroModel.Nome   := edtNome.Text;
  FControleParceiro.ParceiroModel.Cgc    := edtCgc.Text;

  if FControleParceiro.Salvar() then
    ShowMessage('Alterado com sucesso.');

  Self.CarregarParceiros();
end;

procedure TfrmCadastroParceiro.btnExcluirClick(Sender: TObject);
var
  VCodigo: String;
begin
  VCodigo := InputBox('Excluir', 'Digite o código do Cliente', EmptyStr);

  if VCodigo.Trim <> EmptyStr then
  begin
    if (Application.MessageBox(PChar('Deseja excluir o registro?'), 'Confirmação', MB_YESNO
      + MB_DEFBUTTON2 + MB_ICONQUESTION) = mrYes) then
    begin
      FControleParceiro.ParceiroModel.Acao   := uEnumerado.tacExcluir;
      FControleParceiro.ParceiroModel.Codigo := StrToInt(edtCodigo.Text);

      if FControleParceiro.Salvar() then
        ShowMessage('Excluido com sucesso.');

      Self.CarregarParceiros();
    end;
  end;
end;

procedure TfrmCadastroParceiro.btnNovoClick(Sender: TObject);
begin
  //
end;

procedure TfrmCadastroParceiro.CarregarParceiros;
var
  VQry: TFDQuery;
begin
  mmTableParceiros.Close;

  VQry := FControleParceiro.Obter;
  try
    VQry.FetchAll;
    mmTableParceiros.Data := VQry.Data;
  finally
    VQry.Close;
    VQry.Free;
  end;
end;

procedure TfrmCadastroParceiro.CarregarEdits;
begin
  edtCodigo.Text := mmTableParceiros.Fields[0].AsString;
  edtNome.Text   := mmTableParceiros.Fields[1].AsString;
  edtCgc.Text    := mmTableParceiros.Fields[2].AsString;
end;

procedure TfrmCadastroParceiro.DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Self.CarregarEdits();
end;

procedure TfrmCadastroParceiro.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Self.CarregarEdits();
end;

procedure TfrmCadastroParceiro.FormCreate(Sender: TObject);
begin
  FControleParceiro := TParceiroControl.Create;
end;

procedure TfrmCadastroParceiro.FormDestroy(Sender: TObject);
begin
  FControleParceiro.Free;
end;

procedure TfrmCadastroParceiro.FormShow(Sender: TObject);
begin
  Self.CarregarParceiros();

  if mmTableParceiros.RecordCount > 0 then
  begin
    Self.CarregarEdits();
  end;
end;

procedure TfrmCadastroParceiro.LimparCampos;
begin
  edtNome.Clear;
  edtCgc.Clear;
end;

end.
