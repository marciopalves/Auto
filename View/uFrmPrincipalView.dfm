object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Auto System'
  ClientHeight = 379
  ClientWidth = 702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 360
    Width = 702
    Height = 19
    Panels = <
      item
        Width = 70
      end
      item
        Width = 50
      end>
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 702
    Height = 27
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = actParceiro
              end>
            Caption = '&Cadastros'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    Left = 96
    Top = 72
    StyleName = 'Platform Default'
    object actParceiro: TAction
      Category = '&Cadastros'
      Caption = '&Parceiro'
      OnExecute = actParceiroExecute
    end
    object actEmpresa: TAction
      Category = '&Cadastros'
      Caption = '&Empresa'
      OnExecute = actEmpresaExecute
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 512
    Top = 96
  end
  object FDScript1: TFDScript
    SQLScriptFileName = 'C:\marcio\teste\Auto\ArqRecursos\Domain.sql'
    SQLScripts = <
      item
      end>
    Connection = FDConnection1
    Params = <>
    Macros = <>
    Left = 512
    Top = 152
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 568
    Top = 288
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 496
    Top = 232
  end
end
