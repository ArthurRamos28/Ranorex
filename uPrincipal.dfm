object Ranorex: TRanorex
  Left = 0
  Top = 0
  Caption = 'Ranorex'
  ClientHeight = 239
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 411
    Height = 239
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    ExplicitWidth = 553
    ExplicitHeight = 262
    object lblTitulo: TLabel
      Left = 155
      Top = 10
      Width = 79
      Height = 23
      Caption = 'Ranorex'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object btnIniciar: TButton
      Left = 55
      Top = 180
      Width = 297
      Height = 32
      Caption = 'Iniciar'
      TabOrder = 0
      OnClick = btnIniciarClick
    end
    object cbbModulosCadastro: TComboBox
      Left = 193
      Top = 50
      Width = 159
      Height = 21
      TabOrder = 1
      OnChange = cbbModulosCadastroChange
    end
    object cbbModulosProcedimentos: TComboBox
      Left = 193
      Top = 127
      Width = 159
      Height = 21
      TabOrder = 2
      Text = 'cbbModulos'
      OnChange = cbbModulosCadastroChange
    end
    object chkCadastro: TCheckBox
      Left = 55
      Top = 52
      Width = 97
      Height = 17
      Caption = 'Cadastro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      TabOrder = 3
      OnClick = chkCadastroClick
    end
    object chkProcedimento: TCheckBox
      Left = 55
      Top = 129
      Width = 118
      Height = 17
      Caption = 'Procedimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      TabOrder = 4
      OnClick = chkProcedimentoClick
    end
  end
end
