unit padrao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, esysECF;

const dll = 'ECFAFRAC.DLL';
{
  'ECFAFRAC.DLL' = PADRAO
  'SWAFRAC.DLL'  = 'SWEDA'
  'FS345_32.DLL' = 'DARUMA'
  'AFRAC32.DLL'  = 'SCHALTER'
  'AFRACECF.DLL' = 'MECAF'
}

type
  TfrmPadrao = class(TForm)
  private
    function Ret (n: integer; nome_func: string = ''; pegarerro: boolean = true): boolean;

    { Private declarations }
  public
    { Public declarations }

    function GetFormaPgto(x: string): string;

    function AbrePorta(Com: string): boolean;
    procedure FechaPorta;
    function InfoECf (var r: string; cod, descr: string; exiberet: boolean = true): boolean;
    function InfoAliq (var r: string): boolean;
    function TotAliq (var r: string): boolean;
    function TotNSICMS(var r: string): boolean;

    function InfoFPgto (var r: string): boolean;
    function DataHora(var Data, Hora: TDateTime; MostraMensagen:boolean): boolean;
    function SubTotal(var Sub: double): boolean;
    function NumeroCupom(var NC: string): boolean;
    function LeituraX:Boolean;
    function ReducaoZ(DataZ : string = ''):Boolean;
    function LeMemoriaFiscal(Saida, Tipo:string;DataIni,DataFin:String; RedIni,RedFin:integer):boolean;
    function MemoriaFiscalporData(DataIni, DataFim: String):boolean;
    function MemoriaFiscalporReducao(RedIni, RedFim: longint):boolean;
    function Abrecupom: integer;
    function VendeItem(Codigo,Descricao,Aliq:string; Qtd,Valor,mDesc:double; var total: double; servico: boolean = false; AcreDesc : String = '1'; PercVl : String = '0'; Desc : String = '0.00'): boolean;
    function DescAcresItem (tipo, vl_percent, vl_acresdesc: string): boolean;
    function CancelaItemGenerico(Item:Integer):boolean;
    function CancelaItem(Valor: Double; NumItem:integer): boolean;
    function IniciaFechacupomCom(Tipo:string;Valor:Double; PercValor: string):Boolean;
    function FecharAcresDesc (): boolean;

    function FormaPagtocupom(indice, Descricao:string;Valor:Double):Boolean;
    function FechaCupom(Vinculado : Boolean):Boolean;
    function Cancelacupom(Valor: Double): boolean;

    function AbreNaoFiscalVinculado(NumCupom, Forma, Valor: string):boolean;
    function RelatorioNaoFiscalVinculado(Dados: string):boolean;
    function FimRelatorioNaoFiscalVinculado:boolean;

    function AbreNaoFiscal(Forma: string):boolean;
    function RelatorioNaoFiscal(Dados: string):boolean;
    function FimRelatorioNaoFiscal:boolean;
    function EstadoECF (var sret: string): boolean;
    function Autenticar (linha, msg: string) : boolean;
    function ReAutenticar: boolean;
    function MsgCupom (msg: string): boolean;
    function AjustHora (hora: string): boolean;
    function HorVerao(Entrar : Boolean): boolean;
    function AbreGaveta: boolean;
    function EstadoGaveta( var est: string) : boolean;
    function Cancelarvinculado (): boolean;
    function CancelarNaovinculado (): boolean;

    function LerValorTotNSICMS(indice, descricao: string; var valor: string): boolean;
    function LerValorFormaPagto(indice, descricao: string; var valor: string): boolean;

    function AbreNaoFiscalNaoVinc(): boolean;
    function RegistrarNaoFiscalNaoVinc (Indice, valor, Mensagem: string):Boolean;
    function FechaNaoFiscalNaoVinc(): boolean;
    function ProgTributacao (tribut: string): boolean;

    function GravarLeituraX (patharq: string): boolean;
    function GravarMemFiscal (Ini, Fim: String; patharq: string): boolean; overload;
    function GravarMemFiscal (Ini, Fim: Integer; patharq: string): boolean; overload;
    function ImprimirCheque (NumeroBanco, Valor, Favorecido, Cidade, Data, BomPara: String): boolean;
    function Informar (Operador, MsgCupom, Vendedor: boolean): boolean;

    function RetornarFeatures(var r: string) : boolean;
    function AbrirDia(Data : String) : boolean;
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.DFM}

  function AFRAC_AbrirPorta (sPorta: pchar): Integer;  StdCall; External dll;
  function AFRAC_FecharPorta(): integer; StdCall; External dll;
  function AFRAC_LeituraX (): Integer; StdCall; External dll;
  function AFRAC_ReducaoZ (Data: PChar): Integer; StdCall; External dll;
  function AFRAC_EmitirLeituraMemoriaFiscal (tipo, inicio, final: pchar): Integer; StdCall; External dll;
  function AFRAC_LerInformacaoImpressora (CodInformacao: pchar; Retorno: pchar): integer; StdCall; External dll;
  function AFRAC_AbrirCupom (): Integer; StdCall; External dll;
  function AFRAC_VenderItem (Codigo, Descricao, Qtde, Valor_Unitario, Acres_desc, Perc_valor, Valor_acresdesc, Valor_total, Aliquota, Unidade, ForcarImpressaoUmaLinha: pchar): Integer; StdCall; External dll;
  function AFRAC_CancelarItem (NumeroItem: pchar): Integer; StdCall; External dll;
  function AFRAC_FormaPagamento (FormaPagamento, Indice, Valor, Msg : pChar): Integer; StdCall; External dll;
  function AFRAC_InformarMensagemCupom ( linhademensagem: pChar) : integer; StdCall; External dll;
  function AFRAC_InformarOperador (Caixa: pChar) : integer; StdCall; External dll;
  function AFRAC_InformarVendedor (vendedor: pChar) : integer; StdCall; External dll;

  function AFRAC_RetornarFeatures(Retorno : Pchar) : integer; StdCall; External dll;

  function AFRAC_FecharCupom (Vinculado, CupomAdicional: Pchar): Integer; StdCall; External dll;
  function AFRAC_AcrescimoDescontoItem ( Acre_Desc, Perc_Valor, Valor : String; Descricao : PChar ):Integer; StdCall; External dll;
  function AFRAC_AcrescimoDescontoCupom ( Acre_Desc, Perc_Valor, Valor, Descricao : PChar ):Integer; StdCall; External dll;
  function AFRAC_FecharAcrescimoDesconto ( msgDesc, msgAcre, valor : pchar ): Integer; StdCall; External dll;
  function AFRAC_CancelarCupom ():integer; StdCall; External dll;
  function AFRAC_AbrirVinculado (coo, Formapagto, valor: PChar): Integer; StdCall; External dll;
  function AFRAC_ImprimirVinculado(linha1, linha2: PChar):integer; StdCall; External dll;
  function AFRAC_FecharVinculado () :integer; StdCall; External dll;
  function AFRAC_CancelarVinculado (): integer; StdCall; External dll;
  function AFRAC_AbrirNaoFiscalNaoVinculado (): Integer; StdCall; External dll;
  function AFRAC_RegistrarNaoFiscal (Indice, Valor, Mensagem: PChar):integer; StdCall; External dll;
  function AFRAC_CancelarNaoVinculado ():integer; StdCall; External dll;
  function AFRAC_AbrirRelatorioGerencial (Indice:PChar): Integer; StdCall; External dll;
  function AFRAC_ImprimirRelatorioGerencial (Linha:PChar): Integer; StdCall; External dll;
  function AFRAC_FecharRelatorioGerencial (): Integer; StdCall; External dll;
  function AFRAC_PegarCodigoErro (codigoErro, mensagem, acao_sugerida: pchar): Integer; StdCall; External dll;
  function AFRAC_VerificarEstado (Retorno: pchar)  : Integer; StdCall; External dll;
  function AFRAC_Autenticar (linha, msg: pchar) : integer;  StdCall; External dll;
  function AFRAC_RepetirAutenticacao: integer;  StdCall; External dll;
  function AFRAC_GravarLeituraX (nomearq: pChar) : integer;  StdCall; External dll;
  function AFRAC_GravarLeituraMemoriaFiscal (tipo, inicio, final, nomearq: pchar): Integer; StdCall; External dll;
  function AFRAC_LerAliquotas (Retorno: pchar) : Integer; StdCall; External dll;
  function AFRAC_LerTodasFormasPagamento ( Retorno: pchar) : Integer; StdCall; External dll;
  function AFRAC_LerFormasDePagamento ( indice, descricao: pchar) : Integer; StdCall; External dll;
  function AFRAC_LerValorTotalAliquotas ( Retorno: pchar) : Integer; StdCall; External dll;
  function AFRAC_LerTotalizadoresNSICMS ( Retorno: pchar) : Integer; StdCall; External dll;

  function AFRAC_LerValorTotalizadorNSICMS (indice, descricao, valor: pchar) : Integer; StdCall; External dll;
  function AFRAC_LerValorFormaPagamento (indice, descricao, valor: pchar) : Integer; StdCall; External dll;

  function AFRAC_ProgramarTributacao (tributacao: pchar) : Integer; StdCall; External dll;
  function AFRAC_AjustarRelogio (hora: pchar) : Integer; StdCall; External dll;
  function AFRAC_EntrarHorarioVerao  : Integer; StdCall; External dll;
  function AFRAC_SairHorarioVerao  : Integer; StdCall; External dll;
  function AFRAC_ChequeImprimir (NumeroBanco, Valor, Favorecido, Cidade, Data, BomPara: Pchar) : Integer; StdCall; External dll;
  function AFRAC_AbrirGaveta   : Integer; StdCall; External dll;
  function AFRAC_VerificarGaveta (estado: pchar): Integer; StdCall; External dll;
  function AFRAC_AbrirDia(Data : pchar): Integer; StdCall; External dll;

function TfrmPadrao.Ret (n: integer; nome_func: string = ''; pegarerro: boolean = true): boolean;
var coderr: array [0..5] of char;
    msg: array [0..80] of char;
    acsug : array [0..6] of char;
begin
  result:= false;
  fillchar (coderr, 6, 0);
  fillchar (msg, 81, 0);
  fillchar (acsug, 7, 0);
  StrPCopy(coderr,'0');
  StrPCopy(msg,' ');
  StrPCopy(acsug,'0');

  if (n <> 0) then 
  begin
    if (pegarerro) then
      if AFRAC_PegarCodigoErro (codErr, msg, acsug) = 0 then
  end
  else result:= true;
  if (nome_func <> '') then frm_main.mmo_log.Lines.Add(Format('%-40.40s %-6.6s %-50.50s' , [nome_func, codErr, msg]));
end;

function TfrmPadrao.AbrePorta(Com: string): boolean;
var sCom: array [0..3] of char;
begin
  fillchar (sCom, 4, 0);
  StrPCopy(sCom, Com);
  result:=(ret(AFRAC_AbrirPorta(scom), 'AFRAC_AbrirPorta'));
end;

procedure TfrmPadrao.FechaPorta;
begin
  ret(AFRAC_FecharPorta,'AFRAC_FecharPorta');
end;

function TfrmPadrao.InfoECf (var r: string; cod, descr: string; exiberet: boolean = true): boolean;
var sCod: array [0..3] of char;
    buff: array[0..300] of char;
begin
  try
    fillchar (sCod, 4, 0);
    fillchar(buff, 301, 0);
    StrPCopy(sCod,cod);
    StrPCopy(buff,' ');
    result := Ret (AFRAC_LerInformacaoImpressora (sCod, buff),'AFRAC_LerInformacaoImpressora');
    if (result) then r:= buff;
  except
    Result:= false;
    MessageDlg(Format('Houve algum problema ao obter %s do ECF',[descr]), mtWarning, [mbOK], 0);
  end;
end;

function TfrmPadrao.DataHora(var Data, Hora: TDateTime; MostraMensagen:boolean): Boolean;
var s: string;
begin
  result:= false;
  try
    result:= InfoECF (s, '017', 'a Data');
    if (not result) then exit;
    Data:= StrToDate(Copy(s,1,10));
  except
    data:= date();
  end;
end;

function TfrmPadrao.SubTotal(var Sub: double): boolean;
var s: string;
begin
  result:= InfoECF (s, '001', 'o SubTotal');
  if (not result) then exit;
  try
    sub:= strtofloat(s);
  except
    sub:= 0;
  end;
end;

function TfrmPadrao.Numerocupom(var NC: string): boolean;
var sNc: string;
begin
  result:= InfoECF (sNc, '023', 'o Número do Cupom');
  Nc:= sNc;
end;

function TfrmPadrao.LeituraX:Boolean;
begin
  result:= Ret(AFRAC_LeituraX, 'AFRAC_LeituraX');
end;

function TfrmPadrao.ReducaoZ(DataZ : string = ''):Boolean;
var
  sData : string;
begin
  if length(DataZ) = 8 then
    sData := DataZ
  else
    sData:= FormatDateTime('ddmmyyyy', date());

  result:= Ret(AFRAC_ReducaoZ(pChar(sData)),'AFRAC_ReducaoZ');
end;


function TfrmPadrao.LeMemoriaFiscal(Saida, Tipo:string;DataIni,DataFin:String; RedIni,RedFin:integer):boolean;
begin
  if (Dataini='') and (Datafin='') then
    MemoriaFiscalporReducao(RedIni,RedFin)
  else if (Redini=0) and (Redfin=0) then
    MemoriaFiscalporData(DataIni,DataFin);
  Result:= True;
end;

function TfrmPadrao.MemoriaFiscalporData(DataIni, DataFim: String):boolean;
var
  sDataIni, sDataFim : array[0..8] of char;
begin
  Fillchar(sDataIni,9,0);
  StrPCopy(sDataIni, DataIni);
  Fillchar(sDatafim,9,0);
  StrPCopy(sDatafim,  Datafim);
  Result:= Ret(AFRAC_EmitirLeituraMemoriaFiscal('1', sDataIni, sDataFim),'AFRAC_EmitirLeituraMemoriaFiscal');
end;

function TfrmPadrao.MemoriaFiscalporReducao(RedIni, RedFim: longint):boolean;
var
  sRedIni,sRedFim: array[0..8] of char;
begin
  Fillchar(sRedIni,9,0);
  StrPCopy(sRedIni, Format('%.8d',[Redini]));
  Fillchar(sRedFim,9,0);
  StrPCopy(sRedFim, Format('%.8d',[RedFim]));
  Result:= Ret(AFRAC_EmitirLeituraMemoriaFiscal('2', sRedIni, sRedFim),'AFRAC_EmitirLeituraMemoriaFiscal');
end;

function TfrmPadrao.Abrecupom: integer;
begin
  result:= -1;
  if Ret(AFRAC_AbrirCupom, 'AFRAC_AbrirCupom') then result:= 0;
end;

function TfrmPadrao.VendeItem(Codigo,Descricao,Aliq:string; Qtd,Valor,mDesc:double; var total: double; servico: boolean = false; AcreDesc : String = '1'; PercVl : String = '0'; Desc : String = '0.00'): boolean;
var
  sCod : array[0..20] of char;
  sDescr : array[0..200] of char;
  sAliq : array[0..5] of char;
  sQtd : array[0..16] of char;
  sValor : array[0..16] of char;
  sAcreDesc : array[0..1] of char;
  sPercVl : array[0..1] of char;
  sDesc : array[0..16] of char;
  sImp1L : array[0..1] of char;
  sUnid : array[0..3] of char;
  sTotal : array[0..16] of char;

begin

  FillChar(sCod,21,0);
  Fillchar(sDescr,201,0);
  Fillchar(sAliq,6,0);
  Fillchar(sQtd,17,0);
  Fillchar(sValor,17,0);
  Fillchar(sAcreDesc,2,0);
  Fillchar(sPercVl,2,0);
  Fillchar(sDesc,17,0);
  Fillchar(sImp1L,2,0);
  Fillchar(sUnid,4,0);
  FillChar(sTotal,17,0);

  StrPCopy(sCod,Codigo);
  StrPCopy(sDescr,descricao);
  StrPCopy(sQtd,FloatToStrf(qtd, fffixed, 16,2));
  StrPCopy(sValor, FloatToStrf(valor, fffixed, 16, 2));
  StrPCopy(sAcreDesc,AcreDesc);
  StrPCopy(sPercVl,PercVl);
  StrPCopy(sDesc, Desc);
  StrPCopy(sUnid,'UN');
  StrPCopy(sImp1L,'0');
  StrPCopy(sTotal,'0');

  if (servico) then begin
     StrPCopy(sAliq, Aliq)
  end
  else begin
    if pos(Aliq[1],'IFN') > 0 then StrPCopy(sAliq,'M' + Aliq[1] + '00')
    else if pos(Aliq[1],'J') > 0 then StrPCopy(sAliq,Aliq)
    else StrPCopy(sAliq,'M'+'T' + Aliq)
  end;  


  Result:= Ret(AFRAC_VenderItem(sCod, sDescr, sQtd,
               sValor, sAcreDesc, sPercVl, sDesc,  sTotal, sAliq, sUnid,sImp1L), 'AFRAC_VenderItem');
               
  try
    if trim(sTotal) = '' then sTotal:= '0';
    total:= StrtoFloat(sTotal);
  except
    total:= 0;
  end;
end;

function TfrmPadrao.CancelaItem(Valor: Double; NumItem:integer): boolean;
var sNumItem: array [0..5] of char;
begin
  FillChar(sNumItem,6,0);
  StrPCopy(sNumItem, IntToStr(NumItem));
  Result:= Ret(AFRAC_CancelarItem(sNumItem),'AFRAC_CancelarItem');
end;

function TfrmPadrao.CancelaItemGenerico(Item:Integer):boolean;
begin
  Result:=CancelaItem(0,Item);
end;

function TfrmPadrao.IniciaFechacupomCom(Tipo:string;Valor:Double; PercValor: string):Boolean;
var
  sValor: array[0..16] of char;
  sAcreDesc : array[0..1] of char;
  sPerc : array[0..1] of char;
  sValorLiq: array[0..16] of char;
  sAcre, sDesc, sDescr: array[0..30] of char;
begin
  result:= false;
  if Valor <> 0 then begin
    FillChar(sValor,17,0);
    FillChar(sDescr,31,0);
    FillChar(sAcreDesc,2,0);
    FillChar(sPerc,2,0);
    FillChar(sValorLiq,17,0);
    FillChar(sAcre,31,0);
    FillChar(sDesc,31,0);

    StrPCopy(sDesc, 'Desconto');
    StrPCopy(sAcre, 'Acrescimo');  
    StrPCopy(sPerc, PercValor);
        
    StrPCopy(sValor, FloatToStrf(valor, fffixed, 16, 2));
    if uppercase(Tipo) = 'D' then begin
      StrPCopy(sDescr, sDesc);
      StrPCopy(sAcreDesc, '1');
    end
    else begin
      StrPCopy(sDescr, sAcre);
      StrPCopy(sAcreDesc, '0');
    end;
    Result:= Ret(AFRAC_AcrescimoDescontoCupom(sAcreDesc, sPerc, sValor, sDescr),'AFRAC_AcrescimoDescontoCupom');
  end;
end;

function TfrmPadrao.FormaPagtocupom(indice, Descricao:string;Valor:Double):Boolean;
var
  sDescr: array[0..30] of char;
  sValor: array[0..16] of char;
  sMsg : array[0..80] of char;
  sIndice: array[0..2] of char;
begin
  FillChar(sValor,17,0);
  FillChar(sDescr,31,0);
  FillChar(sMsg,81,0);
  FillChar(sIndice,3,0);
  StrPCopy(sValor, FloatToStrf(valor, fffixed, 16, 2));
  StrPCopy(sDescr, Descricao);
  StrPCopy(sMsg, 'Pagamento no indice ' + Indice );
  StrPCopy(sIndice, Indice);                       
  Result:= Ret(AFRAC_FormaPagamento(sDescr, sIndice, sValor, sMsg),'AFRAC_FormaPagamento');
end;

function TfrmPadrao.FechaCupom(Vinculado : Boolean):Boolean;
begin
  if vinculado then
    Result:= Ret(AFRAC_FecharCupom('1','0'),'AFRAC_FecharCupom')
  else
    Result:= Ret(AFRAC_FecharCupom('0','0'),'AFRAC_FecharCupom');
end;

function TfrmPadrao.Cancelacupom(Valor: Double): boolean;
var sCoo: string;
begin
  sCoo:= '';
  Result:= Ret(AFRAC_CancelarCupom(),'AFRAC_CancelarCupom');
end;

function TfrmPadrao.AbreNaoFiscalVinculado(NumCupom, Forma, Valor: string):boolean;
var
  sNumCupom: array[0..6] of char;
  sFormaPagto : array[0..30] of char;
  sValorLiq: array[0..16] of char;
begin
  FillChar(sNumCupom,7,0);
  FillChar(sFormaPagto,31,0);
  FillChar(sValorLiq,17,0);
  StrPCopy(sNumCupom, inttostr(strtoint(NumCupom)));
  StrPCopy(sFormaPagto, Forma);
  StrPCopy(sValorLiq, Valor);
  Result:= Ret(AFRAC_AbrirVinculado(sNumCupom, sFormaPagto, sValorLiq),'AFRAC_AbrirVinculado');
end;

function TfrmPadrao.RelatorioNaoFiscalVinculado(Dados: string):boolean;
var Linha1, Linha2: string;
begin
  Linha1:= Format('%-48.48s',[Dados]);
  Linha2:= StringOfChar(' ',48);
  Result:= Ret(AFRAC_ImprimirVinculado(PChar(Linha1), PChar(Linha2)),'AFRAC_ImprimirVinculado');
end;

function TfrmPadrao.FimRelatorioNaoFiscalVinculado:boolean;
begin
  Result:= Ret((AFRAC_FecharVinculado),'AFRAC_FecharVinculado');
end;

function TfrmPadrao.AbreNaoFiscal(Forma: string):boolean;
var sIndice: string;
begin
  sIndice:= '50';
  Result:= Ret(AFRAC_AbrirRelatorioGerencial(PChar(sIndice)),'AFRAC_AbrirRelatorioGerencial');
end;

function TfrmPadrao.RelatorioNaoFiscal(Dados: string):boolean;
begin
  Dados:= Format('%-160.160s',[Dados]);
  Result:= Ret(AFRAC_ImprimirRelatorioGerencial(PChar(Dados)),'AFRAC_ImprimirRelatorioGerencial');
end;

function TfrmPadrao.FimRelatorioNaoFiscal:boolean;
begin
  Result:= Ret((AFRAC_FecharRelatorioGerencial),'AFRAC_FecharRelatorioGerencial');
end;

function TfrmPadrao.InfoAliq(var r: string): boolean;
var
  buff: array[0..420] of char;
begin
  try
    fillchar(buff, 421, 0);
    StrPCopy(buff,'');
    result := Ret (AFRAC_LerAliquotas(buff),'AFRAC_LerAliquotas');
    if (result) then r:= buff;
  except
    Result:= false;
    MessageDlg('Houve algum problema ao obter as Alíquotas do ECF', mtWarning, [mbOK], 0);
  end;
end;

function TfrmPadrao.TotAliq(var r: string): boolean;
var
  buff: array[0..1080] of char;
begin
  try
    fillchar(buff, 1081, 0);
    StrPCopy(buff,'');
    result := Ret (AFRAC_LerValorTotalAliquotas(buff),'AFRAC_LerValorTotalAliquotas');
    if (result) then r:= buff;
  except
    Result:= false;
    MessageDlg('Houve algum problema ao obter os valores das Alíquotas do ECF', mtWarning, [mbOK], 0);
  end;
end;

function TfrmPadrao.TotNSICMS(var r: string): boolean;
var
  buff: array[0..840] of char;
begin
  try
    fillchar(buff, 841, 0);
    StrPCopy(buff,'');
    result := Ret (AFRAC_LerTotalizadoresNSICMS(buff),'AFRAC_LerTotalizadoresNSICMS');
    if (result) then r:= buff;
  except
    Result:= false;
    MessageDlg('Houve algum problema ao obter os totalizadores NSICMS do ECF', mtWarning, [mbOK], 0);
  end;
end;

function TfrmPadrao.InfoFPgto(var r: string): boolean;
var
  buff: array[0..600] of char;
begin
  try
    fillchar(buff, 601, 0);
    StrPCopy(buff,'');
    result := Ret (AFRAC_LerTodasFormasPagamento(buff),'AFRAC_LerTodasFormasPagamento');
    if (result) then r:= buff;
  except
    Result:= false;
    MessageDlg('Houve algum problema ao obter as Formas de Pagamento do ECF', mtWarning, [mbOK], 0);
  end;
end;

function TfrmPadrao.EstadoECF(var sret: string): boolean;
var r: array [0..1] of char;
begin
  fillchar (r, 2, 0);
  StrPCopy (r,'');
  result:= ret(AFRAC_VerificarEstado (r),'AFRAC_VerificarEstado');
  if (r='A') then sret:= 'Ativo, operação normal'
  else if (r='P') then sret:= 'Passivo, no período entre uma Redução Z e o Início do dia (Abertura do Dia)'
  else if (r='I') then sret:= 'Intervenção Técnica'
  else if (r='T') then sret:= 'Treinamento, estado anterior a gravação do número do CNPJ (Convênio 156)';
end;

function TfrmPadrao.GetFormaPgto(x: string): string;
var sindice: array [0..1] of char;
    sx: array [0..30] of char;
    i: integer;
    aux: string;
begin
  aux:= x;
  result:= '';
  fillchar(sIndice,2,0);
  fillchar(sx, 31,0);
  for i:= 0 to 30 do begin
    StrPCopy(sindice, FormatFloat('00',i));
    StrPCopy(sx, '');
    ret(AFRAC_LerFormasDePagamento (sindice, sx));
    if trim(sx) = '' then break;
    if uppercase(trim(aux)) = uppercase(trim(copy(sx,2,29))) then begin
      result:= FormatFloat('00',i);
      break;
    end;
  end;
end;

function TfrmPadrao.Autenticar (linha, msg: string) : boolean;
var slinha: array [0..15] of char;
    smsg: array [0..48] of char;
begin
  fillchar(slinha, 16,0);
  fillchar(smsg, 49,0);
  strpcopy(slinha, linha);
  strpcopy(smsg, msg);
  result:= ret(AFRAC_Autenticar (slinha, smsg),'AFRAC_Autenticar');
end;

function TfrmPadrao.AbreNaoFiscalNaoVinc: boolean;
begin
  result:= Ret((AFRAC_AbrirNaoFiscalNaoVinculado),'AFRAC_AbrirNaoFiscalNaoVinculado');
end;   

function TfrmPadrao.RegistrarNaoFiscalNaoVinc (Indice, valor, Mensagem: string):boolean;
var
  sValor: array[0..16] of char;
  sMsg : array[0..80] of char;
  sIndice: array[0..2] of char;  
begin
  FillChar(sValor,17,0);
  FillChar(sMsg,81,0);
  FillChar(sIndice,3,0);
  StrPCopy(sValor, valor);
  StrPCopy(sMsg, Mensagem );
  StrPCopy(sIndice, Indice);
  result:= ret(AFRAC_RegistrarNaoFiscal(sIndice, sValor, sMsg),'AFRAC_RegistrarNaoFiscal');
end;

function TfrmPadrao.FechaNaoFiscalNaoVinc: boolean;
begin
  FechaCupom(false);
  //Result:= Ret((AFRAC_FecharVinculado),'AFRAC_FecharVinculado'); -> Especificação antiga
end;



function TfrmPadrao.GravarLeituraX(patharq: string): boolean;
var sNomearq: array[0..255] of char;
begin
  Fillchar(sNomeArq,256,0);
  StrPCopy(sNomeArq, patharq);
  result:= Ret(AFRAC_GravarLeituraX (sNomeArq),'AFRAC_GravarLeituraX');
  if (result) then MessageDlg('Arquivo gravado em '^m + patharq, mtInformation, [mbOK], 0);
end;

function TfrmPadrao.GravarMemFiscal(Ini,
  Fim: String; patharq: string): boolean;
var
  sDataIni, sDataFim : array[0..8] of char;
  sNomearq: array[0..255] of char;
begin
  Fillchar(sNomeArq,256,0);
  StrPCopy(sNomeArq, patharq);
  Fillchar(sDataIni,9,0);
  StrPCopy(sDataIni, Ini);
  Fillchar(sDatafim,9,0);
  StrPCopy(sDatafim, fim);
  result:= Ret(AFRAC_GravarLeituraMemoriaFiscal ('1',  sDataIni, sDataFim, sNomearq),'AFRAC_GravarLeituraMemoriaFiscal');
  if (result) then MessageDlg('Arquivo gravado em '^m + patharq, mtInformation, [mbOK], 0);                           
end;

function TfrmPadrao.GravarMemFiscal(Ini,
  Fim: Integer; patharq: string): boolean;
var 
  sRedIni,sRedFim: array[0..8] of char;
  sNomearq: array[0..255] of char;  
begin
  Fillchar(sNomeArq,256,0);
  StrPCopy(sNomeArq, patharq);  
  Fillchar(sRedIni,9,0);
  StrPCopy(sRedIni, Format('%.8d',[ini]));
  Fillchar(sRedFim,9,0);
  StrPCopy(sRedFim, Format('%.8d',[Fim]));    
  result:= Ret(AFRAC_GravarLeituraMemoriaFiscal ('2', sRedIni, sRedFim, sNomearq),'AFRAC_GravarLeituraMemoriaFiscal');  
  if (result) then MessageDlg('Arquivo gravado em '^m + patharq, mtInformation, [mbOK], 0);                           
end;


function TfrmPadrao.DescAcresItem(tipo, vl_percent, vl_acresdesc: string): boolean;
var
  sValor: array[0..16] of char;
  sAcreDesc : array[0..1] of char;
  sPerc : array[0..1] of char;
begin
  FillChar(sValor,17,0);
  FillChar(sAcreDesc,2,0);
  FillChar(sPerc,2,0);
  StrPCopy(sPerc, vl_percent);    
  StrPCopy(sValor, vl_acresdesc);        
  StrPCopy(sAcreDesc, tipo);        
  Result:= Ret(AFRAC_AcrescimoDescontoItem(sAcreDesc, sPerc, sValor, ''), 'AFRAC_AcrescimoDescontoItem');
end;
  
function TfrmPadrao.FecharAcresDesc: boolean;
var   sAcre, sDesc, sDescr: array[0..30] of char;

begin
  FillChar(sAcre,31,0);
  FillChar(sDesc,31,0);
  FillChar(sDescr,31,0);
  StrPCopy(sDesc, 'Desconto');
  StrPCopy(sAcre, 'Acrescimo');  
  StrPCopy(sDescr, sDesc + sAcre);  
  result:= ret(AFRAC_FecharAcrescimoDesconto(sDesc, sAcre, sDescr),'AFRAC_FecharAcrescimoDesconto');
end;

function TfrmPadrao.ReAutenticar: boolean;
begin
  result:= ret(AFRAC_RepetirAutenticacao,'AFRAC_RepetirAutenticacao');
end;

function TfrmPadrao.MsgCupom (msg: string): boolean;
var sMsg: array [0..48] of char;
begin
  fillchar(sMsg, 49,0);
  StrPCopy (sMsg, msg);  
  result:= ret(AFRAC_InformarMensagemCupom(sMsg), 'AFRAC_InformarMensagemCupom');
end;

function TfrmPadrao.ProgTributacao (tribut: string): boolean;
var stribut: array [0..7] of char;
begin
  fillchar(stribut, 8,0);
  StrPCopy (stribut, tribut);  
  result:= ret((AFRAC_ProgramarTributacao(stribut)), 'AFRAC_ProgramarTributacao');
end;

function TfrmPadrao.AjustHora(hora: string): boolean;
var shora: array [0..6] of char;
begin
  fillchar(shora, 7,0);
  StrPCopy (shora, hora);  
  result:= ret(AFRAC_AjustarRelogio (shora),'AFRAC_AjustarRelogio')
end;

function TfrmPadrao.HorVerao(Entrar : Boolean): boolean;
begin
  if (Entrar) then
     result:= ret(AFRAC_EntrarHorarioVerao, 'AFRAC_EntrarHorarioVerao')
  else
     result:= ret(AFRAC_SairHorarioVerao, 'AFRAC_SairHorarioVerao');
end;

function TfrmPadrao.ImprimirCheque(NumeroBanco, Valor, Favorecido, Cidade, Data, BomPara: String): boolean;
var
  sNumeroBanco: array[0..3] of char;
  sValor : array[0..16] of char;
  sFavorecido : array[0..80] of char;
  sCidade : array[0..30] of char;
  sData : array[0..10] of char;
  sBomPara : array[0..20] of char;
begin
  FillChar(sNumeroBanco,4,0);
  FillChar(sValor,17,0);
  FillChar(sFavorecido,81,0);
  FillChar(sCidade,31,0);
  FillChar(sData,10,0);
  FillChar(sBomPara,21,0);
  
  StrPCopy(sNumeroBanco, NumeroBanco);    
  StrPCopy(sValor, Valor);        
  StrPCopy(sFavorecido, Favorecido);        

  StrPCopy(sCidade, Cidade);    
  StrPCopy(sData, Data);        
  StrPCopy(sBomPara, BomPara);

  result:= ret(AFRAC_ChequeImprimir(sNumeroBanco,sValor, sFavorecido,sCidade,sData, sBomPara),'AFRAC_ChequeImprimir');
end;

function TfrmPadrao.Informar(Operador, MsgCupom,
  Vendedor: boolean): boolean;
begin
  result:= false;
  if (Operador) then result:= Ret(AFRAC_InformarOperador('Operador'),'AFRAC_InformarOperador');
  if (MsgCupom) then result:= Ret(AFRAC_InformarMensagemCupom('Mensagem Cupom'),'AFRAC_InformarMensagemCupom');
  if (Vendedor) then result:= Ret(AFRAC_InformarVendedor('Vendedor'),'AFRAC_InformarVendedor');
end;

function TfrmPadrao.AbreGaveta: boolean;
begin
  Result:= ret(AFRAC_AbrirGaveta,'AFRAC_AbrirGaveta');  
end;


function TfrmPadrao.EstadoGaveta(var est: string): boolean;
var sest: array [0..1] of char;
begin
  fillchar(sest,2,0);
  StrPCopy(sest, est);
  result:=ret(AFRAC_VerificarGaveta(sest),'AFRAC_VerificarGaveta');
  if (result) then est:= sest;
end;

function TfrmPadrao.Cancelarvinculado: boolean;
begin
  result:= ret(AFRAC_CancelarVinculado,'AFRAC_CancelarVinculado');
end;

function TfrmPadrao.CancelarNaovinculado: boolean;
begin
  result:= ret(AFRAC_CancelarNaoVinculado,'AFRAC_CancelarNaoVinculado');
end;

function TfrmPadrao.LerValorTotNSICMS(indice, descricao: string; var valor: string): boolean;
var sValor: array[0..16] of char;
    sIndice: array[0..2] of char;
    sDescricao: array[0..20] of char;

begin
  result:= false;
  FillChar(sValor,17,0);
  FillChar(sIndice,3,0);
  FillChar(sDescricao,21,0);
  StrPCopy(sValor, valor);
  StrPCopy(sIndice, indice);
  StrPCopy(sDescricao, descricao);
  result:= ret(AFRAC_LerValorTotalizadorNSICMS(sindice, sdescricao, sValor),'AFRAC_LerValorTotalizadorNSICMS');
  if (result) then valor:= svalor;
end;

function TfrmPadrao.LerValorFormaPagto(indice, descricao: string; var valor: string): boolean;
var sValor: array[0..16] of char;
    sIndice: array[0..2] of char;
    sDescricao: array[0..20] of char;
begin
  result:= false;
  FillChar(sValor,17,0);
  FillChar(sIndice,3,0);
  FillChar(sDescricao,21,0);
  StrPCopy(sValor, valor);
  StrPCopy(sIndice, indice);
  StrPCopy(sDescricao, descricao);
  result:= ret(AFRAC_LerValorFormaPagamento(sindice, sdescricao, sValor),'AFRAC_LerValorFormaPagamento');
  if (result) then valor:= svalor;
end;

function TFrmPadrao.RetornarFeatures(var r: string) : boolean;
var
  buff: array[0..50] of char;
begin
  try
    fillchar(buff, 51, 0);
    StrPCopy(buff,' ');
    result := Ret (AFRAC_RetornarFeatures(buff),'AFRAC_RetornarFeatures');
    if (result) then r:= buff;
  except
    Result:= false;
    MessageDlg('Houve algum problema ao obter os Features do ECF', mtWarning, [mbOK], 0);
  end;
end;

function TfrmPadrao.AbrirDia(Data : String): boolean;
var
  sData: array[0..7] of char;
begin
  FillChar(sData,8,0);
  StrPCopy(sData, Data);
  result:= ret(AFRAC_AbrirDia(sData),'AFRAC_AbrirDia');
end;



Initialization
  RegisterClasses([TfrmPadrao]);
end.
