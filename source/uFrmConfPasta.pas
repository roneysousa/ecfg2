unit uFrmConfPasta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmConfPasta = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bntOK: TBitBtn;
    btnCancela: TBitBtn;
    Label1: TLabel;
    edtCaminho: TEdit;
    btnLocaliza: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure bntOKClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLocalizaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfPasta: TfrmConfPasta;

implementation

uses uFuncoes, uPrincipalECFG2;

{$R *.dfm}

procedure TfrmConfPasta.bntOKClick(Sender: TObject);
Var
    M_ARCONF : TextFile;
begin
     If not uFuncoes.Empty(edtCaminho.Text) Then
     Begin
        uPrincipalECFG2.M_NMPAST := edtCaminho.Text;
        Try
          try
              DeleteFile('INFOCONF.TXT');
              AssignFile(M_ARCONF,'INFOCONF.TXT');
              Rewrite(M_ARCONF, 'INFOCONF.TXT');
              Append(M_ARCONF);
              WriteLn(M_ARCONF, M_NMPAST);
              //
          finally
              CloseFile(M_ARCONF);
          end;
          //
          Application.MessageBox('Arquivo gravado com sucesso.',
               'Concluido', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
          //
          Close;
        Except
             ShowMessage('Erro na gera��o do arquivo de configura��o de pasta.'); 
        End;
     End;

end;

procedure TfrmConfPasta.btnCancelaClick(Sender: TObject);
begin
      Close;
end;

procedure TfrmConfPasta.FormShow(Sender: TObject);
begin
    edtCaminho.Text := uPrincipalECFG2.M_NMPAST;
end;

procedure TfrmConfPasta.btnLocalizaClick(Sender: TObject);
begin
    if (OpenDialog1.Execute) Then
//       OpenDialog1}
end;

end.
