object MainFormObj: TMainFormObj
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1088#1086#1089' 1, 2'
  ClientHeight = 221
  ClientWidth = 932
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object task1_row_count_label: TLabel
    Left = 8
    Top = 194
    Width = 117
    Height = 13
    Caption = #1047#1072#1087#1080#1089#1077#1081' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1086': 0'
  end
  object task2_row_count_label: TLabel
    Left = 630
    Top = 194
    Width = 117
    Height = 13
    Caption = #1047#1072#1087#1080#1089#1077#1081' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1086': 0'
  end
  object percent_text_label: TLabel
    Left = 8
    Top = 8
    Width = 219
    Height = 13
    Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1080', '#1075#1076#1077' '#1087#1088#1086#1094#1077#1085#1090' '#1085#1077' '#1084#1077#1085#1100#1096#1077':'
  end
  object task1_grid: TDBGrid
    Left = 8
    Top = 27
    Width = 616
    Height = 161
    DataSource = task1_data_source
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = task1_gridDrawColumnCell
  end
  object task2_grid: TDBGrid
    Left = 630
    Top = 27
    Width = 294
    Height = 161
    DataSource = task2_data_source
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object percent_edit: TEdit
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
    OnChange = percent_editChange
  end
  object update_form_show_button: TButton
    Left = 864
    Top = 194
    Width = 61
    Height = 18
    Caption = #1047#1072#1087#1088#1086#1089' 3'
    TabOrder = 3
    OnClick = update_form_show_buttonClick
  end
  object task1_query: TADOQuery
    Connection = UpdateFormObj.fpmi_connection
    CursorType = ctStatic
    AfterScroll = task1_queryAfterScroll
    Parameters = <>
    SQL.Strings = (
      
        'SELECT posts.year AS "'#1043#1086#1076'", posts.n_izd AS "'#1053#1086#1084#1077#1088' '#1080#1079#1076#1077#1083#1080#1103'", post' +
        's.name AS "'#1053#1072#1079#1074#1072#1085#1080#1077' '#1080#1079#1076#1077#1083#1080#1103'", COALESCE(info.max_post, 0) AS "'#1052#1072#1082 +
        #1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1087#1086#1089#1090#1072#1074#1082#1072'", COALESCE(info.total_sum_post, 0) AS "'#1057#1091#1084#1084#1072' ' +
        #1087#1086#1089#1090#1072#1074#1086#1082'", COALESCE(info.percent, 0) AS "'#1055#1088#1086#1094#1077#1085#1090'"'
      'FROM (SELECT years.year, izds.n_izd, izds.name'
      
        '      FROM (SELECT DISTINCT EXTRACT(year FROM pmib6706.spj.date_' +
        'post) AS year '
      '            FROM pmib6706.spj'
      '           ) years'
      '      CROSS JOIN (SELECT pmib6706.j.n_izd, pmib6706.j.name'
      '                  FROM pmib6706.j'
      '                 ) izds'
      '     ) posts'
      
        'LEFT JOIN (SELECT izd.year, izd.n_izd, izd.max_post, izd.total_s' +
        'um_post, ROUND(izd.total_sum_post * 100 / total.sum::numeric, 2)' +
        ' AS percent'
      
        '           FROM (SELECT EXTRACT(year FROM pmib6706.spj.date_post' +
        ') AS year, pmib6706.spj.n_izd, MAX(pmib6706.spj.kol) AS max_post' +
        ', SUM(pmib6706.spj.kol * pmib6706.spj.cost) AS total_sum_post'
      '                 FROM pmib6706.spj'
      '                 GROUP BY year, pmib6706.spj.n_izd'
      '                ) izd'
      
        '           JOIN (SELECT EXTRACT(year FROM pmib6706.spj.date_post' +
        ') AS year, SUM(pmib6706.spj.kol * pmib6706.spj.cost) AS sum'
      '                 FROM pmib6706.spj'
      '                 GROUP BY year'
      '                ) total'
      '           ON izd.year = total.year'
      '          ) info'
      'ON posts.year = info.year AND posts.n_izd = info.n_izd'
      'ORDER BY posts.year, info.percent NULLS FIRST;')
    Left = 136
    Top = 219
  end
  object task1_data_source: TDataSource
    DataSet = task1_query
    Left = 40
    Top = 219
  end
  object task2_query: TADOQuery
    Connection = UpdateFormObj.fpmi_connection
    CursorType = ctStatic
    Parameters = <
      item
        Name = #1043#1086#1076
        Size = -1
        Value = Null
      end
      item
        Name = #1053#1086#1084#1077#1088' '#1080#1079#1076#1077#1083#1080#1103
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT post.n_spj AS "'#1053#1086#1084#1077#1088' '#1087#1086#1089#1090#1072#1074#1082#1080'", post.sum AS "'#1057#1091#1084#1084#1072'", post' +
        '.cost - avg.avg_price AS "'#1056#1072#1079#1085#1086#1089#1090#1100'"'
      
        'FROM (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, ' +
        'pmib6706.spj.n_izd, pmib6706.spj.n_spj, SUM(pmib6706.spj.kol * p' +
        'mib6706.spj.cost), pmib6706.spj.cost'
      '            FROM pmib6706.spj'
      
        '            WHERE EXTRACT(year FROM pmib6706.spj.date_post) = :'#1043 +
        #1086#1076
      '            AND pmib6706.spj.n_izd = :"'#1053#1086#1084#1077#1088' '#1080#1079#1076#1077#1083#1080#1103'"'
      
        '            GROUP BY year, pmib6706.spj.n_izd, pmib6706.spj.n_sp' +
        'j, pmib6706.spj.cost'
      '           ) post'
      
        'JOIN (SELECT EXTRACT(year FROM pmib6706.spj.date_post) AS year, ' +
        'pmib6706.spj.n_izd, ROUND(AVG(pmib6706.spj.cost), 2) AS avg_pric' +
        'e'
      '          FROM pmib6706.spj'
      '          GROUP BY year, pmib6706.spj.n_izd'
      '         ) avg'
      'ON post.year = avg.year AND post.n_izd = avg.n_izd;'
      ''
      '')
    Left = 328
    Top = 219
  end
  object task2_data_source: TDataSource
    DataSet = task2_query
    Left = 232
    Top = 219
  end
end
