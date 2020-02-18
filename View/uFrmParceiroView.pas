unit uFrmParceiroView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uParceiroControl, uEnumerado;

type
  TfrmCadastroParceiro = class(TForm)
    edtNome: TEdit;
    Label2: TLabel;
    mmTableParceiros: TFDMemTable;
    DBGrid1: TDBGrid;
    dsClientes: TDataSource;
    mmTableParceirosCODIGO: TIntegerField;
    mmTableParceirosNOME: TStringField;
    btnIncluir: TButton;
    Label1: TLabel;
    edtCodigo: TEdit;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnNovo: TButton;
    Label3: TLabel;
    edtCpfCnpj: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnNovoClick(Sender: TObject);
  private
    FControleCliente: TParceiroControl;

    procedure CarregarClientes;
    procedure CarregarEdits;
  end;

var
  frmCadastroParceiro: TfrmCadastroParceiro;

implementation

{$R *.dfm}

{ TfrmCadastroCliente }

procedure TfrmCadastroParceiro.btnIncluirClick(Sender: TObject);
begin
  FControleCliente.ParceiroModel.Acao   := uEnumerado.tacIncluir;
  FControleCliente.ParceiroModel.Nome   := edtNome.Text;

  if FControleCliente.Salvar() then
    ShowMessage('Incluido com sucesso.');

  Self.CarregarClientes();
end;

procedure TfrmCadastroParceiro.btnAlterarClick(Sender: TObject);
begin
  FControleCliente.ParceiroModel.Acao    := uEnumerado.tacAlterar;
  FControleCliente.ParceiroModel.Codigo  := StrToInt(edtCodigo.Text);
  FControleCliente.ParceiroModel.Nome    := edtNome.Text;
  FControleCliente.ParceiroModel.CpfCnpj := edtCpfCnpj.Text;

  if FControleCliente.Salvar() then
    ShowMessage('Alterado com sucesso.');

  Self.CarregarClientes();
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
      FControleCliente.ParceiroModel.Acao   := uEnumerado.tacExcluir;
      FControleCliente.ParceiroModel.Codigo := StrToInt(edtCodigo.Text);

      if FControleCliente.Salvar() then
        ShowMessage('Excluido com sucesso.');

      Self.CarregarClientes();
    end;
  end;
end;

procedure TfrmCadastroParceiro.btnNovoClick(Sender: TObject);
begin
  FControleCliente.ParceiroModel.Codigo := FControleCliente.GetId(1);
  edtCodigo.Text := FControleCliente.ParceiroModel.Codigo.ToString();
  edtNome.Clear;
  edtNome.SetFocus();
  edtCpfCnpj.Clear;
end;

procedure TfrmCadastroParceiro.CarregarClientes;
var
  VQry: TFDQuery;
begin
  mmTableParceiros.Close;

  VQry := FControleCliente.Obter;
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
  edtCodigo.Text  := mmTableParceiros.Fields[0].AsString;
  edtNome.Text    := mmTableParceiros.Fields[1].AsString;
  edtCpfCnpj.Text := mmTableParceiros.Fields[2].AsString;
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
  FControleCliente := TParceiroControl.Create;
end;

procedure TfrmCadastroParceiro.FormDestroy(Sender: TObject);
begin
  FControleCliente.Free;
end;

procedure TfrmCadastroParceiro.FormShow(Sender: TObject);
begin
  Self.CarregarClientes();

  if mmTableParceiros.RecordCount > 0 then
  begin
    Self.CarregarEdits();
  end;
end;

end.
