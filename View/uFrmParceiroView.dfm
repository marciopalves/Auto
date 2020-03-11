object frmCadastroParceiro: TfrmCadastroParceiro
  Left = 0
  Top = 0
  Caption = 'Cadastro de Parceiros'
  ClientHeight = 331
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgParceiro: TPageControl
    Left = 0
    Top = 65
    Width = 569
    Height = 225
    ActivePage = tsVisualizacao
    Align = alClient
    TabOrder = 0
    ExplicitTop = 112
    ExplicitHeight = 178
    object tsVisualizacao: TTabSheet
      Caption = 'Visualiza'#231#227'o'
      ExplicitHeight = 150
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 561
        Height = 197
        Align = alClient
        DataSource = dsClientes
        DrawingStyle = gdsGradient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyUp = DBGrid1KeyUp
        OnMouseUp = DBGrid1MouseUp
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Visible = True
          end>
      end
    end
    object tsDados: TTabSheet
      Caption = 'Dados'
      ImageIndex = 1
      ExplicitHeight = 150
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 290
    Width = 569
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object btnIncluir: TButton
      Left = 142
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnIncluirClick
    end
    object btnAlterar: TButton
      Left = 263
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnExcluir: TButton
      Left = 384
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnNovo: TButton
      Left = 29
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 3
      OnClick = btnNovoClick
    end
  end
  object pnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 65
    Align = alTop
    TabOrder = 2
    object Label2: TLabel
      Left = 7
      Top = 36
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label1: TLabel
      Left = 9
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label3: TLabel
      Left = 179
      Top = 36
      Width = 17
      Height = 13
      Caption = 'Cpf'
    end
    object edtNome: TEdit
      Left = 46
      Top = 33
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edtCodigo: TEdit
      Left = 48
      Top = 8
      Width = 119
      Height = 21
      TabOrder = 0
    end
    object edtCgc: TEdit
      Left = 201
      Top = 30
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object btnPesquisar: TButton
      Left = 424
      Top = 24
      Width = 75
      Height = 25
      Caption = 'btnPesquisar'
      TabOrder = 3
    end
  end
  object mmTableParceiros: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 528
    Top = 72
    object mmTableParceirosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
    end
    object mmTableParceirosNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 40
      FieldName = 'NOME'
    end
  end
  object dsClientes: TDataSource
    DataSet = mmTableParceiros
    Left = 528
    Top = 16
  end
  object actParceiro: TActionList
    Left = 528
    Top = 144
    object actIncluir: TAction
      Caption = '&Incluir'
      OnExecute = actIncluirExecute
    end
    object actAlterar: TAction
      Caption = '&Alterar'
    end
    object actExcluir: TAction
      Caption = '&Excluir'
    end
    object actPesquisar: TAction
      Caption = '&Pesquisar'
    end
  end
end
