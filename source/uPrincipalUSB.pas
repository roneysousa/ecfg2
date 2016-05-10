unit uPrincipalUSB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Gradient, RXShell, Menus, XPMenu, shellapi,
  ImgList, Printers, QuickRpt, QRCtrls, Buttons, Gradient1;

type
  TfrmPrincipalUSB = class(TForm)
    pnlSuperior: TPanel;
    pnlCentral: TPanel;
    pnlInferior: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    OpenDialog1: TOpenDialog;
    Gradiente1: TGradiente;
    Image1: TImage;
    Gradiente2: TGradiente;
    Image2: TImage;
    RxTrayIcon1: TRxTrayIcon;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    pmnConfiguraPastaItem: TMenuItem;
    Sobre1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Label2: TLabel;
    Label3: TLabel;
    imgSair: TImage;
    lbl_CFPAST: TLabel;
    ImageList1: TImageList;
    PrintDialog1: TPrintDialog;
    mnuAbrirItem: TMenuItem;
    Timer1: TTimer;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure lbl_CFPASTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure mnuAbrirItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PrinterSetupDialog1Close(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure JumpTo(const aAdress: String);
    Procedure IMPRIMIR;
    Procedure IMPRIMIR_02;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    { Private declarations }
  public
    { Public declarations }
    function Tamanho_Fonte() : Integer;
    procedure Gravar_Fonte(aTamanho : String);
    function Empty(inString:String): Boolean;
    Procedure AbreForm(aClasseForm: TComponentClass; aForm : TForm);        
  end;

var
  frmPrincipalUSB: TfrmPrincipalUSB;
  M_NMPAST, M_NMARQU : String;
  M_ARCONF : TextFile;
  H : HWnd;
  M_LINHA,M_TEXTO : String;
  X, M_NRPAGI :integer;

implementation

uses uSobre, uFrmTesteImp;

{$R *.dfm}

procedure TfrmPrincipalUSB.Timer1Timer(Sender: TObject);
Var
    Hwnd: Thandle;
begin
     //
     If (FileExists(M_NMPAST+'\'+M_NMARQU)) Then
     Begin
          //
          {Hwnd := FindWindow (nil, 'SAC.EXE');
          Showwindow(application.handle,sw_show);}
          Timer1.Enabled := False;
          //
          If (PrinterSetupDialog1.Execute) Then
          Begin
              // Imprimi relatorio
              //WinExec('NotePad.exe /p '+INFOG2.IMP', 0)
              IMPRIMIR_02;
              //IMPRIMIR;
          End;
          //
          If (FileExists(M_NMPAST+'\'+M_NMARQU)) Then
             // Apaga o arquivo
             DeleteFile(M_NMPAST+'\INFOG2.IMP');
         //
         {Showwindow(application.handle,sw_hide);
         //
         SetForegroundWindow(Hwnd);
         ShowWindow(Hwnd, SW_RESTORE);}
     End;
     //
end;

procedure TfrmPrincipalUSB.lbl_CFPASTClick(Sender: TObject);
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

procedure TfrmPrincipalUSB.FormCreate(Sender: TObject);
Type
      TRegisterServiceProcess = function (dwProcessID, dwType:DWord) : DWORD; stdcall;
  var
      Handle: THandle;
      RegisterServiceProcess: TRegisterServiceProcess;
      M_LINHA : String;
begin
     //
     M_NMARQU := 'G2_ENVIA.CMD';
     //
     If Not (FileExists('INFOCONF.TXT')) Then
     begin
          try
              AssignFile(M_ARCONF, 'INFOCONF.TXT');
              Rewrite(M_ARCONF, 'INFOCONF.TXT');
              Append(M_ARCONF);
              WriteLn(M_ARCONF, 'C:\');
              //
              M_NMPAST := 'C:\';
          finally
              CloseFile(M_ARCONF);
          end;
     End
     Else
     begin
          try
              AssignFile(M_ARCONF, 'INFOCONF.TXT');
              Reset(M_ARCONF, 'INFOCONF.TXT');
              ReadLn(M_ARCONF, M_LINHA);
              M_NMPAST := M_LINHA;
          finally
              CloseFile(M_ARCONF);
          end;
     End;
end;

procedure TfrmPrincipalUSB.FormActivate(Sender: TObject);
begin
   //  RichEdit1.Lines.LoadFromFile(M_NMPAST+'\INFOG2.IMP');
     H := FindWindow(Nil,'InfoUSB');
     if H <> 0 then ShowWindow(H,SW_HIDE);
end;

procedure TfrmPrincipalUSB.Sair1Click(Sender: TObject);
begin
     If Application.MessageBox('Sair do Programa?',
         'ATENÇÃO', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = idYes then
     begin
          If (Timer1.Enabled = True) Then
             Timer1.Enabled := False;
          Application.Terminate;
     End;
end;

function TfrmPrincipalUSB.Empty(inString: String): Boolean;
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

procedure TfrmPrincipalUSB.Label2Click(Sender: TObject);
var
   Mail : String;
begin
    Mail := 'mailto: infog2@globo.com ';
    ShellExecute(GetDesktopWindow,'open',pchar(Mail),nil,nil,sw_ShowNormal);
end;

procedure TfrmPrincipalUSB.Label5Click(Sender: TObject);
begin
        JumpTo('www.infog2.com.br');
end;

procedure TfrmPrincipalUSB.JumpTo(const aAdress: String);
var
     buffer: String;
begin
     buffer := 'http://' + aAdress;
     ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmPrincipalUSB.Sobre1Click(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmSobre, frmSobre);
      frmSobre.ShowModal;
  Finally
      frmSobre.Free;
  End;
end;

procedure TfrmPrincipalUSB.mnuAbrirItemClick(Sender: TObject);
begin
      //Application.ShowMainForm := True;
      //Showwindow(application.handle,sw_show);    // <== Este oculta da TaskBar
end;

procedure TfrmPrincipalUSB.FormShow(Sender: TObject);
begin
    H := FindWindow(Nil,'InfoUSB'); //troque project1 pelo nome do seu projeto)
    if H <> 0 then ShowWindow(H,SW_HIDE);
end;

procedure TfrmPrincipalUSB.Button1Click(Sender: TObject);
begin
{    frmPrincipalUSB.WindowState := wsMinimized;
    H := FindWindow(Nil,'InfoUSB'); //troque project1 pelo nome do seu projeto)
    if H <> 0 then ShowWindow(H,SW_HIDE);}
    AbreForm(TfrmTesteImp, frmTesteImp);
end;

procedure TfrmPrincipalUSB.IMPRIMIR;
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

procedure TfrmPrincipalUSB.PrinterSetupDialog1Close(Sender: TObject);
begin
     // Habilita o relegio
     Timer1.Enabled := True;
end;

procedure TfrmPrincipalUSB.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPrincipalUSB.IMPRIMIR_02;
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

procedure TfrmPrincipalUSB.WMSysCommand(var Msg: TWMSysCommand);
begin
     if (Msg.CmdType = SC_MINIMIZE)or (Msg.CmdType = SC_MAXIMIZE) then
     begin
          MessageBeep(0);
     End;

     DefaultHandler(Msg);
end;

function TfrmPrincipalUSB.Tamanho_Fonte: Integer;
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

procedure TfrmPrincipalUSB.Gravar_Fonte(aTamanho : String);
Var
    M_TAMFON : TextFile;
    M_TAMANHO : String;
begin
  try
     AssignFile(M_TAMFON,M_NMPAST+'\Fonte.txt');
     //
     If (FileExists(M_NMPAST+'\Fonte.txt')) Then
      Begin
           Rewrite(M_TAMFON);
           //Reset(M_TAMFON);
           Write(M_TAMFON, aTamanho);
      End
      Else
      begin
           Rewrite(M_TAMFON);
           Write(M_TAMFON, '6');
      End;
      //
  Finally
      CloseFile(M_TAMFON);
  End;
end;

procedure TfrmPrincipalUSB.AbreForm(aClasseForm: TComponentClass;
  aForm: TForm);
begin
      Application.CreateForm(aClasseForm, aForm);
      try
          aForm.ShowModal;
      Finally
          aForm.Free;
      End;

end;

end.
