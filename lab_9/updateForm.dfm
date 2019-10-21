object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1088#1086#1089' 3'
  ClientHeight = 322
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 175
    Width = 117
    Height = 13
    Caption = #1047#1072#1087#1080#1089#1077#1081' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1086': 0'
  end
  object Label3: TLabel
    Left = 608
    Top = 13
    Width = 88
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1087#1086#1089#1090#1072#1074#1082#1080': '
  end
  object Label4: TLabel
    Left = 608
    Top = 32
    Width = 73
    Height = 13
    Caption = #1062#1077#1085#1072' '#1076#1077#1090#1072#1083#1080': '
  end
  object GroupBox1: TGroupBox
    Left = 600
    Top = 8
    Width = 163
    Height = 81
    TabOrder = 3
    object Label1: TLabel
      Left = 102
      Top = 5
      Width = 6
      Height = 13
      Caption = '0'
    end
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 586
    Height = 161
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Edit1: TEdit
    Left = 700
    Top = 29
    Width = 55
    Height = 21
    TabOrder = 1
    TextHint = '0'
  end
  object Button1: TButton
    Left = 699
    Top = 55
    Width = 57
    Height = 24
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    SQL.Strings = (
      'SELECT pmib6706.spj.*'
      'FROM pmib6706.spj')
    Left = 200
    Top = 200
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 120
    Top = 200
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <
      item
        Name = 'cost'
        Size = -1
        Value = Null
      end
      item
        Name = 'n_spj'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'UPDATE pmib6706.spj '
      'SET cost = :cost'
      'WHERE pmib6706.spj.n_spj = :n_spj')
    Left = 280
    Top = 200
  end
  object ADOConnection1: TADOConnection
    Connected = True
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
    Left = 32
    Top = 200
  end
end
