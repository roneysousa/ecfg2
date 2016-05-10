unit uSobre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, shellapi, Printers, Mask,
  ToolEdit, CurrEdit, Buttons ;

type
  TfrmSobre = class(TForm)
    pnlSuperior: TPanel;
    Image2: TImage;
    pnlCental: TPanel;
    Image1: TImage;
    lbl_CFPAST: TLabel;
    Label1: TLabel;
    Image3: TImage;
    edtPasta: TEdit;
    cmbImpressora: TComboBox;
    cbxLog: TCheckBox;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    imgSair: TImage;
    Label4: TLabel;
    Label6: TLabel;
    Image4: TImage;
    Label7: TLabel;
    procedure AtivaLink(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DesativaLink(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClickLink(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Label2Click(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
       procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    { Private declarations }
  public
  procedure JumpTo(const aAdress: String);
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

uses uPrincipalECFG2, uFrmTesteImp, uFrmConfPasta, uFuncoes,
  uFrmTestaImpressora;

{$R *.DFM}

procedure TfrmSobre.AtivaLink(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 TLabel(Sender).Font.Color:=clRed;
end;

procedure TfrmSobre.DesativaLink(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 TLabel(Sender).Font.Color:=$FF8080;
end;

procedure TfrmSobre.ClickLink(Sender: TObject);
var
   Mail : String;
begin
    Mail := 'mailto: infog2@globo.com ';
    ShellExecute(GetDesktopWindow,'open',pchar(Mail),nil,nil,sw_ShowNormal);
end;

procedure TfrmSobre.JumpTo(const aAdress: String);
var
     buffer: String;
begin
     buffer := 'http://' + aAdress;
     ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmSobre.Label5Click(Sender: TObject);
begin
        JumpTo('www.infog2.com.br');
end;

procedure TfrmSobre.WMMove(var Msg: TWMMove);
begin
  // Impedir que o form seja arrastado para fora das margens da tela.
  if Left < 0 then
        Left := 0;
  if Top < 0 then
          Top := 0;
  if Screen.Width - (Left + Width) < 0 then
          Left := Screen.Width - Width;
  if Screen.Height - (Top + Height) < 0 then
          Top := Screen.Height - Height;
end;

procedure TfrmSobre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case key of
        vk_Escape: frmSobre.close;
    end;
End;

procedure TfrmSobre.Label2Click(Sender: TObject);
var
   Mail : String;
begin
    Mail := 'mailto: sac@infog2.com.br ';
    ShellExecute(GetDesktopWindow,'open',pchar(Mail),nil,nil,sw_ShowNormal);
end;

procedure TfrmSobre.imgSairClick(Sender: TObject);
begin
     Application.Terminate;
end;

procedure TfrmSobre.btnOkClick(Sender: TObject);
Var
    M_ARCONF : TextFile;
    iModelo : Integer;
begin
     If not uFuncoes.Empty(edtPasta.Text) Then
     Begin
        if (copy(edtPasta.Text,length(edtPasta.Text),1) = '\') then
            edtPasta.Text := copy(edtPasta.Text,1,length(edtPasta.text)-1);

        uPrincipalECFG2.M_NMPAST := edtPasta.Text;
        //
        Case cmbImpressora.ItemIndex of
             0 : iModelo := 1;   // Bematech MP20/MP25/MP2000
             1 : iModelo := 2;   // Daruma FS345/FS600
             2 : iModelo := 3;   // Sweda ST120
             3 : iModelo := 4;   // Elgin MFD Fit 1E
             4 : iModelo := 5;   // Mecaf
             5 : iModelo := 6;   // Urano/1FIT - LOGGER
        End;
        //
        uPrincipalECFG2.M_CDMODE := iModelo;
        //
        Try
          try
              DeleteFile('INFOCONF.TXT');
              AssignFile(M_ARCONF,'INFOCONF.TXT');
              Rewrite(M_ARCONF, 'INFOCONF.TXT');
              Append(M_ARCONF);
              WriteLn(M_ARCONF, uPrincipalECFG2.M_NMPAST);             // pasta
              WriteLn(M_ARCONF, InttoStr(iModelo));   // modelo da impressora
              if (cbxLog.Checked) Then
               begin
                    WriteLn(M_ARCONF, 'S');             // log
                    uPrincipalECFG2.M_FLXLOG := 'S';
               End
               Else
               begin
                   WriteLn(M_ARCONF, 'N');             // log
                   uPrincipalECFG2.M_FLXLOG := 'N';
               End;
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
             ShowMessage('Erro na geração do arquivo de configuração de pasta.'); 
        End;
     End;

end;

procedure TfrmSobre.FormShow(Sender: TObject);
begin
    edtPasta.Text := uPrincipalECFG2.M_NMPAST;
    //
    Case uPrincipalECFG2.M_CDMODE of
             1 : cmbImpressora.ItemIndex := 0;   // Bematech MP20/MP25/MP2000
             2 : cmbImpressora.ItemIndex := 1;   // Daruma FS345/FS600
             3 : cmbImpressora.ItemIndex := 2;   // Sweda ST120
             4 : cmbImpressora.ItemIndex := 3;   // Elgin MFD Fit 1E
             5 : cmbImpressora.ItemIndex := 4;   // Mecaf
             6 : cmbImpressora.ItemIndex := 5;   // Urano
    End;
    //
    if (uPrincipalECFG2.M_FLXLOG = 'S') Then
       cbxLog.Checked := True
    Else
       cbxLog.Checked := False;
    //
    If (uPrincipalECFG2.M_CDMODE = 6) Then
    begin
         Label7.Caption := M_NMPORT;
    End
    Else
        Label7.Caption := '';
end;

procedure TfrmSobre.Image4Click(Sender: TObject);
begin
      frmTestarImpressora := TfrmTestarImpressora.Create(Application);
      try
          uFrmTestaImpressora.W_CDMODE := uPrincipalECFG2.M_CDMODE;
          frmTestarImpressora.ShowModal;
      Finally
          frmTestarImpressora.Release;
          frmTestarImpressora := NIL;
      End;
end;

end.
