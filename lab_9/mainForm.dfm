object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1088#1086#1089' 1, 2'
  ClientHeight = 223
  ClientWidth = 851
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
  object Label1: TLabel
    Left = 8
    Top = 194
    Width = 117
    Height = 13
    Caption = #1047#1072#1087#1080#1089#1077#1081' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1086': 0'
  end
  object Label2: TLabel
    Left = 548
    Top = 194
    Width = 117
    Height = 13
    Caption = #1047#1072#1087#1080#1089#1077#1081' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1086': 0'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 219
    Height = 13
    Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1080', '#1075#1076#1077' '#1087#1088#1086#1094#1077#1085#1090' '#1085#1077' '#1084#1077#1085#1100#1096#1077':'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 27
    Width = 534
    Height = 161
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
  end
  object DBGrid2: TDBGrid
    Left = 548
    Top = 27
    Width = 294
    Height = 161
    DataSource = DataSource2
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Edit1: TEdit
    Left = 233
    Top = 8
    Width = 29
    Height = 16
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '50'
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 781
    Top = 193
    Width = 61
    Height = 18
    Caption = #1047#1072#1087#1088#1086#1089' 3'
    TabOrder = 3
    OnClick = Button1Click
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
    Top = 219
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    SQL.Strings = (
      
        'SELECT izd.year, izd.name, izd.max_post, izd.total_sum_post, ROU' +
        'ND(izd.total_sum_post * 100 / total.sum::numeric, 2) AS percent'
      
        'FROM (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, ' +
        'pmib6706.j.name, MAX(pmib6706.spj.kol) AS max_post, SUM(pmib6706' +
        '.spj.kol * pmib6706.spj.cost) AS total_sum_post'
      '            FROM pmib6706.spj'
      '            JOIN pmib6706.j'
      '            ON pmib6706.spj.n_izd = pmib6706.j.n_izd'
      '            GROUP BY year, pmib6706.j.name'
      '           ) izd'
      
        'JOIN (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, ' +
        'SUM(pmib6706.spj.kol * pmib6706.spj.cost) AS sum'
      '          FROM pmib6706.spj'
      '          GROUP BY year'
      '         ) total'
      'ON izd.year = total.year'
      'ORDER BY izd.year, percent;')
    Left = 208
    Top = 219
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 128
    Top = 219
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'year'
        Size = -1
        Value = Null
      end
      item
        Name = 'name'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT post.n_spj, post.sum, post.cost - avg.avg_price AS differ' +
        'ence'
      
        'FROM (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, ' +
        'pmib6706.spj.n_izd, pmib6706.spj.n_spj, SUM(pmib6706.spj.kol * p' +
        'mib6706.spj.cost), pmib6706.spj.cost'
      '            FROM pmib6706.spj'
      
        '            WHERE EXTRACT(year FROM pmib6706.spj.date_post) = :y' +
        'ear'
      '            AND pmib6706.spj.n_izd = (SELECT pmib6706.j.n_izd'
      
        '                                                         FROM pm' +
        'ib6706.j'
      
        '                                                         WHERE p' +
        'mib6706.j.name = :name)'
      
        '            GROUP BY year, pmib6706.spj.n_izd, pmib6706.spj.n_sp' +
        'j, pmib6706.spj.cost'
      '           ) post'
      
        'JOIN (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, ' +
        'pmib6706.spj.n_izd, ROUND(AVG(pmib6706.spj.cost), 2) AS avg_pric' +
        'e'
      '          FROM pmib6706.spj'
      '          GROUP BY year, pmib6706.spj.n_izd'
      '         ) avg'
      'ON post.year = avg.year AND post.n_izd = avg.n_izd;')
    Left = 208
    Top = 275
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 128
    Top = 275
  end
  object ADOConnection2: TADOConnection
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
    Top = 275
  end
end
