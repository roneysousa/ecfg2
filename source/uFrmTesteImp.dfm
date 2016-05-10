object frmTesteImp: TfrmTesteImp
  Left = 341
  Top = 241
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmTesteImp'
  ClientHeight = 263
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 112
    Top = 16
    Width = 75
    Height = 25
    Caption = 'LeituraX'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 18
    Top = 74
    Width = 295
    Height = 152
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
