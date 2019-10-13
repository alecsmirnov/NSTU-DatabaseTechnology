object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1085#1086#1084#1077#1088' - 9'
  ClientHeight = 228
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 198
    Width = 163
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1073#1088#1072#1086#1090#1072#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 105
    Height = 47
    Caption = #1047#1072#1087#1088#1086#1089
    TabOrder = 7
  end
  object Button1: TButton
    Left = 127
    Top = 14
    Width = 66
    Height = 41
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 63
    Width = 97
    Height = 129
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object Edit1: TEdit
    Left = 199
    Top = 16
    Width = 76
    Height = 17
    TabOrder = 2
    TextHint = #1048#1079#1076#1077#1083#1080#1077
    Visible = False
  end
  object Edit2: TEdit
    Left = 199
    Top = 34
    Width = 76
    Height = 17
    TabOrder = 3
    TextHint = #1043#1086#1076
    Visible = False
  end
  object RadioButton1: TRadioButton
    Left = 25
    Top = 28
    Width = 25
    Height = 17
    Caption = '1'
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 56
    Top = 28
    Width = 33
    Height = 17
    Caption = '2'
    TabOrder = 5
    OnClick = RadioButton2Click
  end
  object RadioButton3: TRadioButton
    Left = 88
    Top = 28
    Width = 25
    Height = 17
    Caption = '3'
    TabOrder = 6
    OnClick = RadioButton3Click
  end
  object Button2: TButton
    Left = 281
    Top = 14
    Width = 66
    Height = 41
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 8
    Visible = False
    OnClick = Button2Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=Ickejev3;Persist Security Info=True;' +
      'User ID=pmi-b6706;Extended Properties="DSN=PostgreSQL30;DATABASE' +
      '=students;SERVER=students.ami.nstu.ru;PORT=5432;UID=pmi-b6706;PW' +
      'D=Ickejev3;SSLmode=disable;ReadOnly=0;Protocol=7.4;FakeOidIndex=' +
      '0;ShowOidColumn=0;RowVersioning=0;ShowSystemTables=0;ConnSetting' +
      's=;Fetch=100;Socket=4096;UnknownSizes=0;MaxVarcharSize=255;MaxLo' +
      'ngVarcharSize=8190;Debug=0;CommLog=0;Optimizer=0;Ksqo=1;UseDecla' +
      'reFetch=0;TextAsLongVarchar=1;UnknownsAsLongVarchar=0;BoolsAsCha' +
      'r=1;Parse=0;CancelAsFreeStmt=0;ExtraSysTablePrefixes=dd_;LFConve' +
      'rsion=1;UpdatableCursors=1;DisallowPremature=0;TrueIsMinus1=0;BI' +
      '=0;ByteaAsLongVarBinary=0;UseServerSidePrepare=0;LowerCaseIdenti' +
      'fier=0;XaOpt=1"'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 392
    Top = 24
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    Left = 392
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 392
    Top = 120
  end
end
