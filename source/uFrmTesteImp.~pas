unit uFrmTesteImp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmTesteImp = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTesteImp: TfrmTesteImp;

implementation

uses uFiscal;

{$R *.dfm}

procedure TfrmTesteImp.Button1Click(Sender: TObject);
Var
    Resposta : integer;
begin
        Resposta:= uFiscal.FISCAL('LeituraX',3);
        Memo1.Lines.Add('');
        Memo1.Lines.Add('Leitura X:'+inttostr(Resposta));
        Memo1.Lines.Add('');
end;

end.
