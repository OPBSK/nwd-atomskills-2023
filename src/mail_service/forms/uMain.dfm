object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1089#1077#1088#1074#1077#1088' TechLife'
  ClientHeight = 387
  ClientWidth = 921
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLogin: TPanel
    Left = 0
    Top = 0
    Width = 921
    Height = 169
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object gbSQL: TGroupBox
      Left = 0
      Top = 0
      Width = 353
      Height = 128
      Align = alLeft
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      TabOrder = 0
      object lblSQLStatus: TLabel
        Left = 201
        Top = 102
        Width = 120
        Height = 16
        Caption = #1057#1090#1072#1090#1091#1089' '#1041#1044': '#1074#1085#1077' '#1089#1077#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnSQLLogin: TButton
        Left = 201
        Top = 47
        Width = 140
        Height = 49
        Caption = #1042#1086#1081#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnSQLLoginClick
      end
      object dbehAdminLogin: TDBEditEh
        Left = 10
        Top = 44
        Width = 185
        Height = 24
        ControlLabel.Width = 135
        ControlLabel.Height = 16
        ControlLabel.Caption = #1051#1086#1075#1080#1085' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
        ControlLabel.Font.Charset = DEFAULT_CHARSET
        ControlLabel.Font.Color = clWindowText
        ControlLabel.Font.Height = -13
        ControlLabel.Font.Name = 'Tahoma'
        ControlLabel.Font.Style = []
        ControlLabel.ParentFont = False
        ControlLabel.Visible = True
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = True
      end
      object dbehAdminPass: TDBEditEh
        Left = 10
        Top = 94
        Width = 185
        Height = 24
        ControlLabel.Width = 143
        ControlLabel.Height = 16
        ControlLabel.Caption = #1055#1072#1088#1086#1083#1100' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
        ControlLabel.Font.Charset = DEFAULT_CHARSET
        ControlLabel.Font.Color = clWindowText
        ControlLabel.Font.Height = -13
        ControlLabel.Font.Name = 'Tahoma'
        ControlLabel.Font.Style = []
        ControlLabel.ParentFont = False
        ControlLabel.Visible = True
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        Visible = True
      end
    end
    object pnlStatus: TPanel
      Left = 0
      Top = 128
      Width = 921
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object lblStatus: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 915
        Height = 35
        Align = alClient
        Alignment = taCenter
        Caption = #1057#1090#1072#1090#1091#1089' '#1089#1077#1088#1074#1077#1088#1072': '#1074#1085#1077' '#1089#1077#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 223
        ExplicitHeight = 23
      end
    end
    object GroupBox1: TGroupBox
      Left = 353
      Top = 0
      Width = 368
      Height = 128
      Align = alLeft
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1087#1086#1095#1090#1099
      TabOrder = 2
      object lblEmailStatus: TLabel
        Left = 201
        Top = 99
        Width = 134
        Height = 16
        Caption = #1057#1090#1072#1090#1091#1089' Email: '#1074#1085#1077' '#1089#1077#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnEmailLogin: TButton
        Left = 201
        Top = 44
        Width = 148
        Height = 49
        Caption = #1042#1086#1081#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnEmailLoginClick
      end
      object dbehEmailLogin: TDBEditEh
        Left = 10
        Top = 44
        Width = 185
        Height = 24
        ControlLabel.Width = 75
        ControlLabel.Height = 16
        ControlLabel.Caption = #1051#1086#1075#1080#1085' '#1087#1086#1095#1090#1099
        ControlLabel.Font.Charset = DEFAULT_CHARSET
        ControlLabel.Font.Color = clWindowText
        ControlLabel.Font.Height = -13
        ControlLabel.Font.Name = 'Tahoma'
        ControlLabel.Font.Style = []
        ControlLabel.ParentFont = False
        ControlLabel.Visible = True
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = True
      end
      object dbehEmailPass: TDBEditEh
        Left = 10
        Top = 94
        Width = 185
        Height = 24
        ControlLabel.Width = 160
        ControlLabel.Height = 16
        ControlLabel.Caption = #1055#1072#1088#1086#1083#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103' '#1087#1086#1095#1090#1099
        ControlLabel.Font.Charset = DEFAULT_CHARSET
        ControlLabel.Font.Color = clWindowText
        ControlLabel.Font.Height = -13
        ControlLabel.Font.Name = 'Tahoma'
        ControlLabel.Font.Style = []
        ControlLabel.ParentFont = False
        ControlLabel.Visible = True
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        Visible = True
      end
    end
    object GroupBox2: TGroupBox
      Left = 721
      Top = 0
      Width = 200
      Height = 128
      Align = alLeft
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      TabOrder = 3
      object btnGetEmails: TButton
        AlignWithMargins = True
        Left = 12
        Top = 55
        Width = 176
        Height = 25
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1087#1080#1089#1100#1084#1072
        TabOrder = 0
        OnClick = btnGetEmailsClick
      end
      object btnSendEmails: TButton
        AlignWithMargins = True
        Left = 12
        Top = 20
        Width = 176
        Height = 25
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1080#1089#1100#1084#1072
        TabOrder = 1
        OnClick = btnSendEmailsClick
        ExplicitLeft = 13
      end
    end
  end
  object pnlLogger: TPanel
    Left = 0
    Top = 169
    Width = 921
    Height = 218
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object memoLog: TMemo
      Left = 0
      Top = 0
      Width = 921
      Height = 218
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
end
