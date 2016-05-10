unit uFrmMemoriaFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ToolEdit, Buttons;

type
  TfrmMemoriaFiscal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edtDTINIC: TDateEdit;
    edtDTFINA: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    btnImprimir: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtDTINICExit(Sender: TObject);
    procedure edtDTFINAExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMemoriaFiscal: TfrmMemoriaFiscal;

implementation

uses uFuncoes, uElgin, uPrincipalECFG2, uUrano;

{$R *.dfm}

procedure TfrmMemoriaFiscal.BitBtn1Click(Sender: TObject);
begin
     Close;
end;

procedure TfrmMemoriaFiscal.btnImprimirClick(Sender: TObject);
Var
    cTipo, aMensagem, cDataInicial, cDataFinal : String;
    iResultado, iRetorno : Integer;
    iCodErro: integer;
    strErroMsg, strDestino, strSimplificada: string;
    bSucesso : boolean;
    Buffer: TStrings;
    //
begin
      If (edtDTINIC.Text = '  /  /    ') Then
        begin
              edtDTINIC.SetFocus;
              Exit;
        End;
      If (edtDTFINA.Text = '  /  /    ') Then
       begin
            edtDTFINA.SetFocus;
            Exit;
       End;
       //
       If (edtDTFINA.Date < edtDTINIC.Date) Then
       begin
            ShowMessage('Coloque um período final superior ou igual ao inicial.');
            edtDTFINA.Clear;
            edtDTFINA.SetFocus;
            Exit;
       End;
       //
       If (RadioGroup1.ItemIndex = 0) Then
           cTipo := 's'
       Else
           cTipo := 'c';
       //
       cDataInicial := edtDTINIC.Text;
       cDataFinal   := edtDTFINA.Text;
       //
       case uPrincipalECFG2.M_CDMODE of
                1:begin  // Bematech
                      iRetorno := 1;
                End;
                2:begin  // Daruma
                      iRetorno := 1;
                End;
                3:begin  // sweda
                            iRetorno := 1;
                End;
                4:begin  // Elgin MFD Fit 1E
                     iResultado := Elgin_LeituraMemoriaFiscalData( pchar ( cDataInicial ), pchar( cDataFinal ), pchar( cTipo ) );
                     //
                     Case iResultado of
                       0: aMensagem := 'indica erro na execução da função.';
                       1: aMensagem := 'indica que nenhum erro ocorreu.';
                      -2: aMensagem := 'Parâmetro inválido.';
                      -4: aMensagem := 'Arquivo ini não encontrado ou parâmetro inválido para o nome da porta.';
                      -5: aMensagem := 'Erro ao abrir a porta de comunicação.';
                      -50: aMensagem := 'Número de série inválido.';
                     End;
                     //
                   If (iResultado <> 1) Then
                   begin
                       strErroMsg := StringOfChar(' ',100);
                       Elgin_RetornoImpressora( iCodErro, strErroMsg );
                       Application.MessageBox(  Pchar('Erro Nº '+inttostr(iCodErro)+chr(13)+chr(10)+strErroMsg),'Erro',MB_IconError + MB_OK);
                       //
                       ShowMessage('Mensagem: '+ aMensagem);
                    End;
                End;
                5:begin  // Mecaf
                            iRetorno := 1;
                End;
                6:begin  // Urano/1FIT - LOGGER
                       strDestino := 'I';
                       bSucesso := True;
                       strSimplificada := 'True';

                       if (RadioGroup1.ItemIndex = 1) then
                           strSimplificada := 'False';

                       //Executa o comando
                       If Not (frmMainEcFG2.TrataErro(uUrano.EmiteLeituraMF(nPorta, cDataInicial, cDataFinal, strDestino, strSimplificada, Buffer))) Then
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

                       If(bSucesso) Then
                         Application.MessageBox('Operação Executada com Sucesso!', 'InfoECF');
                End;
       End;


end;

procedure TfrmMemoriaFiscal.edtDTINICExit(Sender: TObject);
begin
    If (edtDTINIC.Text <> '99/99/9999') Then
      try
          StrToDate(edtDTINIC.Text);
      except
          on EConvertError do
            ShowMessage ('Data Inválida!');
      end;
end;

procedure TfrmMemoriaFiscal.edtDTFINAExit(Sender: TObject);
begin
    If (edtDTFINA.Text <> '99/99/9999') Then
      try
          StrToDate(edtDTFINA.Text);
      except
          on EConvertError do
            ShowMessage ('Data Inválida!');
      end;
end;

end.

