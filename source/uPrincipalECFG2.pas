unit uPrincipalECFG2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Gradient, RXShell, Menus,  shellapi,
  ImgList, Printers, QuickRpt, QRCtrls, Buttons;

type
  TfrmMainEcFG2 = class(TForm)
    pnlSuperior: TPanel;
    pnlCentral: TPanel;
    pnlInferior: TPanel;
    Image1: TImage;
    Image2: TImage;
    RxTrayIcon1: TRxTrayIcon;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    pmnConfiguraPastaItem: TMenuItem;
    Sair1: TMenuItem;
    Label2: TLabel;
    Label3: TLabel;
    imgSair: TImage;
    lbl_CFPAST: TLabel;
    ImageList1: TImageList;
    mnuAbrirItem: TMenuItem;
    Timer1: TTimer;
    N1: TMenuItem;
    mnuSobreItem: TMenuItem;
    MemriaFiscal1: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure lbl_CFPASTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure mnuAbrirItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PrinterSetupDialog1Close(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pmnConfiguraPastaItemClick(Sender: TObject);
    procedure mnuSobreItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MemriaFiscal1Click(Sender: TObject);
  private
    procedure JumpTo(const aAdress: String);
    Procedure IMPRIMIR;
    Procedure IMPRIMIR_02;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    { Private declarations }
  public
    { Public declarations }
    function Tamanho_Fonte() : Integer;
    function Empty(inString:String): Boolean;
    Procedure AbreForm(aClasseForm: TComponentClass; aForm : TForm);
    Function LerArquivo(aArqNome: String) : Boolean;
    Function Enviar_Comando(aComando, cParam1, cParam2, cParam3, cParam4, cParam5,
                            cParam6, cParam7, cParam8, cParam9, cParam10, cParam11, cTextoTef : String) : integer;
    Function TrataErro( lCodErro: Longint): Boolean;
  end;

var
  frmMainEcFG2: TfrmMainEcFG2;
  M_NMPAST, M_NMARQU : String;
  M_ARCONF : TextFile;
  H : HWnd;
  M_LINHA,M_TEXTO, M_FLXLOG : String;
  X, M_NRPAGI :integer;
  aParam1, aParam2, aParam3, aParam4, aParam5, aTextoTef : String;
  aParam6, aParam7, aParam8, aParam9, aParam10, aParam11 : String;
  M_CDMODE : integer;
  M_NMPORT : String;

implementation

uses uSobre, uFiscal, uFuncoes, uFrmConfPasta, uBematech, ufrmNewSobre, uFrmTestaImpressora,
  uUrano, uFrmMemoriaFiscal;

const
  MSG_EXECUCAO_SUCESSO : string = 'Operação executada com Sucesso!';

{$R *.dfm}

Function TfrmMainEcFG2.TrataErro( lCodErro: Longint): Boolean;
var
  strNomeErro: string;
  strCircunstancia: String;
begin
    TrataErro := True;
    if(lCodErro>0) then
    begin
      strNomeErro := ObtemNomeErro(nPorta);
      strCircunstancia := ObtemCircunstancia(nPorta);
      aMensagem := 'Erro Nº '+ inttostr(lCodErro) + ' - ' + strNomeErro + PChar(strCircunstancia);
      uFiscal.aMensagem := aMensagem;
      //Application.MessageBox(  Pchar('Erro Nº '+ inttostr(lCodErro) + ' - ' + strNomeErro),PChar(strCircunstancia),MB_IconError + MB_OK);
      TrataErro := False;
    end;
end;

procedure TfrmMainEcFG2.Timer1Timer(Sender: TObject);
Var
    Hwnd: Thandle;
begin
     //
     If (FileExists(M_NMPAST+'\'+M_NMARQU)) Then
     Begin
          //
          Timer1.Enabled := False;
          // Ler arquivo
          If Not (LerArquivo(M_NMPAST+'\'+M_NMARQU)) Then
             Raise Exception.Create('Erro na leitura do arquivo.');
          //
          Timer1.Enabled := True;
     End;
     //
end;

procedure TfrmMainEcFG2.lbl_CFPASTClick(Sender: TObject);
Var
     InputString: string;
begin
     InputString := InputBox('Digite o caminho da pasta', 'Caminho', M_NMPAST);
     If not Empty(InputString) Then
     Begin
          M_NMPAST := InputString;
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
     End;
     //
end;

procedure TfrmMainEcFG2.FormCreate(Sender: TObject);
Type
      TRegisterServiceProcess = function (dwProcessID, dwType:DWord) : DWORD; stdcall;
  var
      Handle: THandle;
      RegisterServiceProcess: TRegisterServiceProcess;
      M_LINHA, param1, param2, pasta_aplicacao : String;
      Cont , iRet : integer;

begin
     DecimalSeparator := '.';
     M_NMARQU := 'g2_envia.cmd';
     //
     If Not (FileExists('INFOCONF.TXT')) Then      // Cria arquivo de configuração
     begin
          try
              pasta_aplicacao := ExtractFilePath( Application.ExeName );
              M_NMPAST :=  Copy(pasta_aplicacao,1, length(pasta_aplicacao) - 1);
              AssignFile(M_ARCONF, 'INFOCONF.TXT');
              Rewrite(M_ARCONF, 'INFOCONF.TXT');
              Append(M_ARCONF);
              WriteLn(M_ARCONF, M_NMPAST);
              WriteLn(M_ARCONF, '1');
              WriteLn(M_ARCONF, 'N');
              WriteLn(M_ARCONF, 'COM1');
              //
              M_CDMODE := 1;
              M_FLXLOG := 'N';
          finally
              CloseFile(M_ARCONF);
          end;
     End
     Else
     begin         //  le arquivo de configuração
          try
              AssignFile(M_ARCONF, 'INFOCONF.TXT');
              Reset(M_ARCONF, 'INFOCONF.TXT');
              ReadLn(M_ARCONF, M_LINHA);
              M_NMPAST := M_LINHA;
              //
              param1 := '';
              param2 := '';
              //
              Cont := 1;
              While not Eof ( M_ARCONF ) do
                begin
                     ReadLn(M_ARCONF, M_LINHA);
                     //
                     Case Cont of
                         1: param1 := M_LINHA;
                         2: param2 := M_LINHA;
                     End;
                     //
                     Cont := Cont + 1;
                End;
          finally
              CloseFile(M_ARCONF);
          end;
          //  modelo da impressora
          M_CDMODE := StrtoInt(param1);
          //
          if not uFuncoes.Empty(param2) Then
              M_FLXLOG := param2
          Else
              M_FLXLOG := 'N';
     End;
     //
     iRet := Enviar_Comando('AbrePortaSerial', '', '', '', '', '', '', '', '', '', '', '', '');
     //
     If (M_CDMODE < 6) Then
     begin
         If (iRet <> 1) Then
            ShowMessage('Erro na abertura da porta serial.');
     End
     Else
         If (iRet < 0) Then
            ShowMessage('Erro na abertura da porta serial.');
     //
     //
     Timer1.Enabled := True;
end;

procedure TfrmMainEcFG2.FormActivate(Sender: TObject);
begin
     H := FindWindow(Nil,'InfoUSB');
     if H <> 0 then ShowWindow(H,SW_HIDE);
end;

procedure TfrmMainEcFG2.Sair1Click(Sender: TObject);
begin
     If Application.MessageBox('Sair do Programa?',
         'ATENÇÃO', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = idYes then
     begin
          If (Timer1.Enabled = True) Then
             Timer1.Enabled := False;
          Application.Terminate;
     End;
end;

function TfrmMainEcFG2.Empty(inString: String): Boolean;
{Testa se a variavel está vazia ou não}
Var
  index : Byte;
Begin
  index := 1;
  Empty := True;
  while (index <= Length(inString))and (index <> 0) do
  begin
  if inString[index] = ' ' Then
  begin
inc(index)
  end
  else
Begin
  Empty := False;
  index := 0
end;
  end;

end;

procedure TfrmMainEcFG2.Label2Click(Sender: TObject);
var
   Mail : String;
begin
    Mail := 'mailto: sac@infog2.com.br ';
    ShellExecute(GetDesktopWindow,'open',pchar(Mail),nil,nil,sw_ShowNormal);
end;

procedure TfrmMainEcFG2.Label5Click(Sender: TObject);
begin
        JumpTo('www.infog2.com.br');
end;

procedure TfrmMainEcFG2.JumpTo(const aAdress: String);
var
     buffer: String;
begin
     buffer := 'http://' + aAdress;
     ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMainEcFG2.mnuAbrirItemClick(Sender: TObject);
begin
      //Application.ShowMainForm := True;
      //Showwindow(application.handle,sw_show);    // <== Este oculta da TaskBar
end;

procedure TfrmMainEcFG2.FormShow(Sender: TObject);
begin
    H := FindWindow(Nil,'InfoUSB'); //troque project1 pelo nome do seu projeto)
    if H <> 0 then ShowWindow(H,SW_HIDE);
end;

procedure TfrmMainEcFG2.IMPRIMIR;
var
    M_INFOG2 : TextFile;
    M_NRLINH, M_NRCOLU, M_TAMANH : integer;
    M_TEXTO, M_Somatx : String;
begin
  Try
     //
     AssignFile(M_INFOG2,M_NMPAST+'\INFOG2.IMP');
     Reset(M_INFOG2);
     //
     Printer.Canvas.Font.Size := 10;
     //  'MS Sans Serif', 'Courier'
     Printer.Canvas.Font.Name := 'Courier New';
     Printer.Begindoc; {inicializa a impressora}
     M_NRLINH := 40;
     M_NRCOLU := 40;
     //
     While not Eof (M_INFOG2) do
     begin
         // Le linha
         Readln(M_INFOG2,M_LINHA);
         //
         M_NRCOLU := 40;
         M_TAMANH := Printer.Canvas.TextWidth('a');
         M_TEXTO  := '';
         //
         For X := 1 to Length(M_LINHA) do
         Begin
              //
              M_Somatx := 'S';
              // Teste se tem algo para imprimir
              If (M_LINHA[X+1]= CHR(15)) or (M_LINHA[X+1]= CHR(18)) Then
              begin
                  If (not Empty(M_TEXTO)) Then
                  begin
                       // Imprimi texto
                       Printer.Canvas.TextOut(M_NRCOLU,M_NRLINH, M_TEXTO+M_LINHA[X]);
                       M_TAMANH := M_TAMANH+Length(M_TEXTO);
                       // Nova alteração
                       M_NRCOLU := M_NRCOLU - Printer.Canvas.Font.Height + Printer.Canvas.TextWidth(M_TEXTO);
                       //
                       M_TEXTO  := '';
                       M_Somatx := 'N';
                  End;
              End;
              // comprimido
              If (M_LINHA[X]= CHR(15)) Then
              begin
                  Printer.Canvas.Font.Size  := 6;
                  //Printer.Canvas.Font.Color := clBlue;
                  M_Somatx := 'N';
                  //
              End;
              // normal
              If (M_LINHA[X]= CHR(18)) Then
              begin
                  Printer.Canvas.Font.Size := 10;
                  //Printer.Canvas.Font.Color := clBlack;
                  M_Somatx := 'N';
                  //
              End;
              // Soma o Texto
              If (M_Somatx = 'S') then
                 M_TEXTO := M_TEXTO + M_LINHA[X];
              //
         End;        // Fim-do-para
         //
         If (not Empty(M_TEXTO)) and (X >= Length(M_LINHA)) Then
         begin
              // Imprimi texto
              Printer.Canvas.TextOut(M_NRCOLU,M_NRLINH, M_TEXTO);
              M_TAMANH := M_TAMANH+Length(M_TEXTO);
              M_TEXTO := '';
         End;
         //
         M_NRLINH := M_NRLINH - Printer.Canvas.Font.Height + 5 ;
         //
         If M_NRLINH > Printer.PageHeight-40 then
         Begin
              Printer.NewPage;
              M_NRLINH := 40;
         end;
         //
     End;     // Fim-do-enquanto
     //
     CloseFile(M_INFOG2);
     //
     Printer.Enddoc;   // Finaliza Impressão
     //
     If (FileExists(M_NMPAST+'\INFOG2.IMP')) Then
       // Apaga o arquivo
       DeleteFile(M_NMPAST+'\INFOG2.IMP');
     //
  Except
     CloseFile(M_INFOG2);
     //
     Printer.Enddoc;   // Finaliza Impressão
     //
     ShowMessage('Erro na impressão!!!'+#13+'Verifique a Impressora.');
  End;
  //
end;

procedure TfrmMainEcFG2.PrinterSetupDialog1Close(Sender: TObject);
begin
     // Habilita o relegio
     Timer1.Enabled := True;
end;

procedure TfrmMainEcFG2.FormKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = Char(67)) or (Key = Char(99)) Then
     begin
          Key := #0;
          lbl_CFPASTClick(Sender);
     End;
     //
     If (Key=#27) and (Printer.Printing) then
     begin
          Key := #0;
          Printer.Abort;
          MessageDlg('Impressão abortada', mtInformation, [mbOK],0);
     End;

end;

procedure TfrmMainEcFG2.IMPRIMIR_02;
var
    M_INFOG2, M_TAMFON : TextFile;
    M_NRLINH, M_NRCOLU, M_TAMANH : integer;
    M_TEXTO, M_Somatx, M_TAMANHO : String;
begin
  //
  M_TAMANHO := InttoStr(Tamanho_Fonte());
  Try
     //
     AssignFile(M_INFOG2,M_NMPAST+'\INFOG2.IMP');
     Reset(M_INFOG2);
     //
     //Printer.Canvas.Font.Size := 7;
     // NOVO
     Printer.Canvas.Font.Size := StrtoInt(M_TAMANHO);
     //  'MS Sans Serif', 'Courier'
     Printer.Canvas.Font.Name := 'Courier New';
     Printer.Begindoc; {inicializa a impressora}
     M_NRLINH := 40;
     M_NRCOLU := 40;
     //
     While not Eof (M_INFOG2) do
     begin
         // Le linha
         Readln(M_INFOG2,M_LINHA);
         //
         If (UpperCase(M_LINHA)= '<SP>') Then
         begin
              // Nova Pagina
              Printer.NewPage;
              M_NRLINH := 40;
         End
         Else
         begin
              // Imprimi Linha
              Printer.Canvas.TextOut(M_NRCOLU,M_NRLINH, M_LINHA);
              //
               M_NRLINH := M_NRLINH - Printer.Canvas.Font.Height + 7 ;
         End;
     End;     // Fim-do-enquanto
     //
     CloseFile(M_INFOG2);
     //
     Printer.Enddoc;   // Finaliza Impressão
     //
     If (FileExists(M_NMPAST+'\INFOG2.IMP')) Then
       // Apaga o arquivo
       DeleteFile(M_NMPAST+'\INFOG2.IMP');
     //
  Except
     CloseFile(M_INFOG2);
     //
     Printer.Enddoc;   // Finaliza Impressão
     //
     ShowMessage('Erro na impressão!!!'+#13+'Verifique a Impressora.');
  End;
  //
end;

procedure TfrmMainEcFG2.WMSysCommand(var Msg: TWMSysCommand);
begin
     if (Msg.CmdType = SC_MINIMIZE)or (Msg.CmdType = SC_MAXIMIZE) then
     begin
          MessageBeep(0);
     End;

     DefaultHandler(Msg);
end;

function TfrmMainEcFG2.Tamanho_Fonte: Integer;
Var
    M_TAMFON : TextFile;
    M_TAMANHO : String;
begin
  try
     AssignFile(M_TAMFON,M_NMPAST+'\Fonte.txt');
     //
     If (FileExists(M_NMPAST+'\Fonte.txt')) Then
      Begin
           Reset(M_TAMFON);
      End
      Else
      begin
           Rewrite(M_TAMFON);
           Write(M_TAMFON, '6');
          //M_TAMANHO := '6';
      End;
      //
      readln(M_TAMFON, M_TAMANHO);
      //
      Result := StrtoInt(M_TAMANHO);
  Finally
      CloseFile(M_TAMFON);
  End;
end;

procedure TfrmMainEcFG2.AbreForm(aClasseForm: TComponentClass;
  aForm: TForm);
begin
      Application.CreateForm(aClasseForm, aForm);
      try
          aForm.ShowModal;
      Finally
          aForm.Free;
      End;
end;

function TfrmMainEcFG2.LerArquivo(aArqNome: String): Boolean;
Var
    aArquivo, aArqRetorno, aAtivo : TextFile;
    linha, aComando, aRetorno : String;
    iContParam, iRetorno : integer;
begin
    aParam1 := '';
    aParam2 := '';
    aParam3 := '';
    aParam4 := '';
    aParam5 := '';
    aParam6 := '';
    aParam7 := '';
    aParam8 := '';
    aParam9 := '';
    aParam10 := '';
    aParam11 := '';
    //
    AssignFile ( aArquivo, aArqNome );
    //
    try
      Reset ( aArquivo );
      ReadLn ( aArquivo, linha );
      //
      aComando := linha;
      //
      aTextoTef := '';
      iContParam := 1;
      while not Eof ( aArquivo ) do
      begin
           ReadLn ( aArquivo, linha );
           //
           Case iContParam of
              1: aParam1 := linha;
              2: aParam2 := linha;
              3: aParam3 := linha;
              4: aParam4 := linha;
              5: aParam5 := linha;
              6: aParam6 := linha;
              7: aParam7 := linha;
              8: aParam8 := linha;
              9: aParam9 := linha;
              10: aParam10 := linha;
              11: aParam11 := linha;
           End;
           //
           aTextoTef := aTextoTef + linha + #13+#10;
           //
           iContParam := iContParam + 1;
           //
      end;
      //
    Finally
      CloseFile ( aArquivo );
    End;
    //
    AssignFile ( aAtivo, M_NMPAST+'\'+'g2_ativo.cmd' );
    //
    try
        Rewrite ( aAtivo );
        Writeln ( aAtivo, aComando);
    finally
        CloseFile ( aAtivo );
    End;
    // enviar o comando para impressora
    iRetorno := Enviar_Comando(aComando, aParam1, aParam2, aParam3, aParam4, aParam5, aParam6, aParam7, aParam8, aParam9, aParam10, aParam11, aTextoTef);
    //
    If (iRetorno = 1) Then
        aRetorno := uFiscal.aStatus
    Else
        aRetorno := uFiscal.aMensagem;
    // gerar arquivo de retorno
    AssignFile ( aArqRetorno, M_NMPAST+'\'+'g2_resp.tmp' );
    try
      try
          Rewrite ( aArqRetorno);
          if (iRetorno = 1) Then
             Writeln ( aArqRetorno, '1'+aRetorno)
          else
             Writeln ( aArqRetorno, '0'+aRetorno+ ' -> '+inttostr(iRetorno));
      finally
          CloseFile ( aArqRetorno );
      End;
      //
      While FileExists(M_NMPAST+'\'+'g2_resp.cmd') do
          DeleteFile(M_NMPAST+'\'+'g2_resp.cmd');
      //
      uFuncoes.Renomear(M_NMPAST+'\'+'g2_resp.tmp', M_NMPAST+'\'+'g2_resp.cmd');
      // If FileExists(aArqNome) Then
      While FileExists(aArqNome) do
         DeleteFile(aArqNome);
      //
      Result := True;
    Except
      Result := False;
    End;
end;

function TfrmMainEcFG2.Enviar_Comando(aComando, cParam1, cParam2,
  cParam3, cParam4, cParam5, cParam6, cParam7, cParam8,
  cParam9, cParam10, cParam11, cTextoTef : String): integer;
begin
     Result := uFiscal.FISCAL(aComando, M_CDMODE, cParam1, cParam2, cParam3, cParam4,
                               cParam5, cParam6, cParam7, cParam8, cParam9, cParam10, cParam11, cTextoTef);
end;

procedure TfrmMainEcFG2.pmnConfiguraPastaItemClick(Sender: TObject);
begin
      Timer1.Enabled := False;
      //
      frmSobre := TfrmSobre.Create(Application);
      try
          frmSobre.ShowModal;
      Finally
          frmSobre.Release;
          frmSobre := NIL;
          Timer1.Enabled := True;
      End;
end;

procedure TfrmMainEcFG2.mnuSobreItemClick(Sender: TObject);
begin
     AbreForm(TfrmNewSobre, frmNewSobre);
end;

procedure TfrmMainEcFG2.FormDestroy(Sender: TObject);
Var
    iRetorno  : integer;
begin
     iRetorno := Enviar_Comando('FechaPortaSerial', '', '', '', '', '', '', '', '', '', '', '', '');
     //
     If (M_CDMODE < 6) Then
      begin
        If (iRetorno <> 1) Then
           ShowMessage('Erro na fechamento da porta serial.');
      End
     Else
       If (iRetorno < 0) Then
         ShowMessage('Erro na fechamento da porta serial.');
end;


procedure TfrmMainEcFG2.MemriaFiscal1Click(Sender: TObject);
begin
     AbreForm(TfrmMemoriaFiscal, frmMemoriaFiscal);
end;

Initialization
begin

end;

end.
