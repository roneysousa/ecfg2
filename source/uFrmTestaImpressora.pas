unit uFrmTestaImpressora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmTestarImpressora = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblData: TLabel;
    lblSerie: TLabel;
    lblFirmware: TLabel;
    lblDLL: TLabel;
    BitBtn2: TBitBtn;
    bntLeituraX: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure bntLeituraXClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar;
  public
    { Public declarations }
  end;

var
  frmTestarImpressora: TfrmTestarImpressora;
  W_CDMODE : INTEGER;

implementation

uses uFiscal, uFuncoes, uPrincipalECFG2, uUrano, uElgin, uSweda;

{$R *.dfm}

procedure TfrmTestarImpressora.BitBtn1Click(Sender: TObject);
begin
     Limpar;
     //
     If (uFiscal.FISCAL('VersaoFirmware', W_CDMODE ,'','','','','','','','','','','','') = 1) Then
     begin
         lblFirmware.Caption :=  uFiscal.aFirmware;
         //uFiscal.aStatus := '';
         uFiscal.FISCAL('VersaoDll', W_CDMODE ,'','','','','','','','','','','','');
         lblDLL.Caption := uFiscal.aVersao;
         //uFiscal.FISCAL('NumeroSerie', W_CDMODE ,'','','','','','','','','','','','');
         //lblSerie.Caption := uFiscal.aNumSerie;
         uFiscal.FISCAL('DataMovimento', W_CDMODE ,'','','','','','','','','','','','');
         lblData.Caption := uFiscal.aDataMovimento;
     End
     Else
         ShowMessage('Erro de comunicação!!!');
end;

procedure TfrmTestarImpressora.FormShow(Sender: TObject);
begin
     Limpar;
end;

procedure TfrmTestarImpressora.Limpar;
begin
       lblSerie.Caption := '';
       lblData.Caption   := '';
       lblDLL.Caption := '';
       lblFirmware.Caption   := '';
end;

procedure TfrmTestarImpressora.BitBtn2Click(Sender: TObject);
Var
    aDesc : String;
    iRet : Integer;
begin
     aDesc := InputBox('Forma de pagamento','Informe a forma de pagamento','');
     //
     try
        If not uFuncoes.Empty(aDesc) Then
          begin
              iRet := uFiscal.FISCAL('ProgramaFormasPagamento', uPrincipalECFG2.M_CDMODE, aDesc, '', '', '', '', '', '', '', '', '', '', '');
              //
              If (iRet = 1) Then
                  ShowMessage(aDesc + ' cadastrado com sucesso.')
              Else
                  ShowMessage('Retorno : ' + InttoStr(iRet));
          End;
     Except
           raise Exception.Create('Erro ao tentar cadastrar forma de pagamento.');
     End;
end;

procedure TfrmTestarImpressora.bntLeituraXClick(Sender: TObject);
Var
    iRetorno : integer;
  strDestino, strImprimeBitmap: String;
  bSucesso: Boolean;
  x : integer;
  Buffer: TStrings;
begin
      case uPrincipalECFG2.M_CDMODE of
                1:begin  // Bematech
                      iRetorno := 1;
                End;
                2:begin  // Daruma
                      iRetorno := 1;
                End;
                3:begin  // sweda
                       iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                       if (iRetorno = 1) Then
                           iRetorno := uSweda.ECF_LeituraX;
                End;
                4:begin  // Elgin MFD Fit 1E
                      strDestino := 'I';
                      bSucesso := True;
                      If (not frmMainEcFG2.TrataErro(EmiteLeituraX(nPorta, strDestino, strImprimeBitmap, '', Buffer))) Then
                           bSucesso := False;

                      If(bSucesso) Then
                        Application.MessageBox('Operação Executada com Sucesso!', 'Demo Fit');
                End;
                5:begin  // Mecaf
                            iRetorno := 1;
                End;
                6:begin  // Urano/1FIT - LOGGER
                      strDestino := 'I';
                      bSucesso := True;

                      strImprimeBitmap := 'False';

                      //Executa o comando
                      If (not TrataErro(uUrano.EmiteLeituraX(nPorta, strDestino, strImprimeBitmap, '1', Buffer))) Then
                      begin
                          bSucesso := False;
                          //
                          iRetorno := 1;
                               //
                               try
                                   uUrano.DLLG2_LimpaParams(0);
                                   uUrano.DLLG2_AdicionaParam(0, 'Avanco', '200', 4);
                                   uUrano.DLLG2_ExecutaComando(0, 'AvancaPapel');
                                   iRetorno := 1;
                               Except
                                  iRetorno := 0;
                               End;
                      End;
                      //
                      If(bSucesso) Then
                        Application.MessageBox('Operação Executada com Sucesso!', 'InfoECF');
                End;
        End;   // fim-do-case
{      iRetorno := uUrano.EmiteLeituraX(nPorta, 'I', 'False', '', Buffer);
      //
      if (iRetorno = 1) Then
        ShowMessage('Operação Executada com Sucesso!');}
end;

procedure TfrmTestarImpressora.BitBtn3Click(Sender: TObject);
begin
  If Application.MessageBox('Tem certeza que deseja emitir Redução Z?',
     'ATENÇÃO', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = idYes then
     begin
         uFiscal.FISCAL('ReducaoZ', uPrincipalECFG2.M_CDMODE, '', '', '', '',
                                '', '', '', '', '', '', '', '');
     End;                          
end;

end.
