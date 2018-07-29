object AbglDialog: TAbglDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Startnummern abgleichen'
  ClientHeight = 492
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object ZeitDateiLabel: TLabel
    Left = 297
    Top = 22
    Width = 62
    Height = 15
    HelpContext = 3603
    Caption = 'Zeit-Datei  ('
  end
  object SnrDateiLabel: TLabel
    Left = 19
    Top = 22
    Width = 112
    Height = 15
    HelpContext = 3603
    Caption = 'Startnummer-Datei  ('
  end
  object ZeitPanel: TPanel
    Left = 155
    Top = 204
    Width = 111
    Height = 20
    HelpContext = 305
    BevelKind = bkTile
    BevelOuter = bvNone
    Caption = 'Zeit-Datei'
    TabOrder = 11
  end
  object SnrPanel: TPanel
    Left = 16
    Top = 204
    Width = 81
    Height = 20
    HelpContext = 305
    BevelKind = bkTile
    BevelOuter = bvNone
    Caption = 'Startnr.-Datei'
    TabOrder = 10
  end
  object AendernBtn: TButton
    Left = 242
    Top = 452
    Width = 148
    Height = 25
    HelpContext = 307
    Caption = #196'&nderungen '#252'bernehmen'
    TabOrder = 3
    TabStop = False
    OnClick = AendernBtnClick
  end
  object SnrDateiEdit: TTriaEdit
    Left = 16
    Top = 38
    Width = 262
    Height = 21
    HelpContext = 301
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
    Text = 'Dateiname'
    OnClick = DateiEditClick
  end
  object HilfeButton: TButton
    Left = 481
    Top = 452
    Width = 75
    Height = 25
    HelpContext = 201
    Caption = '&Hilfe'
    TabOrder = 5
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object CancelButton: TButton
    Left = 398
    Top = 452
    Width = 75
    Height = 25
    HelpContext = 202
    Caption = 'Abbrechen'
    TabOrder = 4
    TabStop = False
    OnClick = CancelButtonClick
  end
  object StatusGB: TGroupBox
    Left = 16
    Top = 81
    Width = 262
    Height = 95
    HelpContext = 303
    Caption = #220'bersicht'
    TabOrder = 1
    object SnrIdentLabel: TLabel
      Left = 41
      Top = 20
      Width = 128
      Height = 15
      Caption = 'Startnummern identisch'
    end
    object SnrUebernLabel: TLabel
      Left = 41
      Top = 45
      Width = 138
      Height = 15
      Caption = 'Startnummern abgleichen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EintrFehltLabel: TLabel
      Left = 41
      Top = 70
      Width = 79
      Height = 15
      Caption = 'Eintr'#228'ge fehlen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object SnrIdentZahl: TLabel
      Left = 10
      Top = 20
      Width = 30
      Height = 15
      AutoSize = False
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object SnrUebernZahl: TLabel
      Left = 10
      Top = 45
      Width = 30
      Height = 15
      AutoSize = False
      Caption = '22'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EintrFehltZahl: TLabel
      Left = 10
      Top = 70
      Width = 30
      Height = 15
      AutoSize = False
      Caption = '3333'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object AbglGrid: TTriaGrid
    Left = 16
    Top = 222
    Width = 540
    Height = 215
    HelpContext = 305
    ColCount = 8
    DefaultColWidth = 50
    DefaultRowHeight = 17
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 11
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goTabs, goThumbTracking]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 6
    OnDblClick = AbglGridDblClick
    OnDrawCell = AbglGridDrawCell
    OnMouseDown = AbglGridMouseDown
    OnMouseUp = AbglGridMouseUp
    OnSelectCell = AbglGridSelectCell
    OnGetColText = AbglGridGetColText
  end
  object ImpSnrEdit: TTriaMaskEdit
    Left = 34
    Top = 280
    Width = 45
    Height = 18
    HelpContext = 305
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    TabStop = False
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    EditMask = '9999;0; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 7
    Text = '1234'
    OnChange = GridSnrEditChange
    TriaGrid = AbglGrid
  end
  object TztSnrEdit: TTriaMaskEdit
    Left = 142
    Top = 280
    Width = 45
    Height = 18
    HelpContext = 305
    TabStop = False
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    EditMask = '9999;0; '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 8
    Text = '5678'
    OnChange = GridSnrEditChange
    TriaGrid = AbglGrid
  end
  object TztZeitEdit: TUhrZeitEdit
    Left = 193
    Top = 280
    Width = 100
    Height = 18
    HelpContext = 305
    TabStop = False
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    EditMask = '!90:00:00,00;1;_'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = []
    MaxLength = 11
    ParentFont = False
    TabOrder = 9
    Text = '00:00:00,00'
    TriaGrid = AbglGrid
  end
  object AnsichtRG: TRadioGroup
    Left = 294
    Top = 81
    Width = 262
    Height = 95
    HelpContext = 304
    Caption = 'Ansicht'
    Items.Strings = (
      'Alles zeigen'
      'Nur unterschiedliche Eintr'#228'ge'
      'Nur fehlende Eintr'#228'ge')
    TabOrder = 2
    OnClick = AnsichtRGClick
  end
  object ZeitDateiEdit: TTriaEdit
    Left = 294
    Top = 38
    Width = 262
    Height = 21
    HelpContext = 302
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 12
    Text = 'Dateiname'
    OnClick = DateiEditClick
  end
  object AbglBtn: TButton
    Left = 134
    Top = 452
    Width = 100
    Height = 25
    HelpContext = 306
    Caption = '&Alle abgleichen'
    TabOrder = 13
    OnClick = AbglBtnClick
  end
end
