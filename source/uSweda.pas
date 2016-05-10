unit uSweda;

interface

// Fun��es de Inicializa��o 
function ECF_AlteraSimboloMoeda( SimboloMoeda: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ProgramaAliquota( Aliquota: pchar; ICMS_ISS: Integer ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ProgramaHorarioVerao: Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_NomeiaDepartamento(
 Indice: Integer;
 Departamento: pchar ): Integer;
 StdCall; External 'CONVECF.DLL';


function ECF_NomeiaTotalizadorNaoSujeitoIcms(
 Indice: Integer;
 Totalizador: pchar): 
 Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_ProgramaArredondamento: Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ProgramaTruncamento: Integer; 
 StdCall; External 'CONVECF.DLL' Name 'ECF_ProgramaTruncamento'; 

function ECF_LinhasEntreCupons( Linhas: Integer ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_EspacoEntreLinhas( Dots: Integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ForcaImpactoAgulhas( ForcaImpacto: Integer ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

// Fun��es do Cupom Fiscal 
function ECF_AbreCupom( CGC_CPF: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_VendeItem(   Codigo: pchar;
                     Descricao: pchar;
                     Aliquota: pchar;
TipoQuantidade: pchar;
Quantidade: pchar;
CasasDecimais: Integer;
ValorUnitario: pchar;
TipoDesconto: pchar;
Desconto: pchar): Integer;
StdCall; External 'CONVECF.DLL'; 



function ECF_VendeItemDepartamento(
Codigo: pchar;
Descricao: pchar;
Aliquota: pchar;
ValorUnitario: pchar;
Quantidade: pchar;
Acrescimo: pchar;
Desconto: pchar;
IndiceDepartamento: pchar;
UnidadeMedida: pchar): Integer;
StdCall; External 'CONVECF.DLL'; 



function ECF_CancelaItemAnterior: Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaItemGenerico( NumeroItem: pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaCupom: Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_FechaCupomResumido(
 FormaPagamento: pchar;
 Mensagem: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_FechaCupom(
 FormaPagamento: pchar;
 AcrescimoDesconto: pchar;
 TipoAcrescimoDesconto: pchar;
 ValorAcrescimoDesconto: pchar;
 ValorPago: pchar; Mensagem: pchar): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ResetaImpressora: Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_IniciaFechamentoCupom(
 AcrescimoDesconto: pchar;
 TipoAcrescimoDesconto: pchar;
 ValorAcrescimoDesconto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_EfetuaFormaPagamento(
 FormaPagamento: pchar;
 ValorFormaPagamento: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_EfetuaFormaPagamentoDescricaoForma(
 FormaPagamento: pchar;
 ValorFormaPagamento: pchar;
 DescricaoFormaPagto: pchar ): integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_TerminaFechamentoCupom( Mensagem: pchar): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_EstornoFormasPagamento(
 FormaOrigem: pchar;
 FormaDestino: pchar;
 Valor: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 



function ECF_UsaUnidadeMedida(UnidadeMedida: pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_AumentaDescricaoItem( Descricao: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

// Fun��es dos Relat�rios Fiscais 
function ECF_LeituraX: Integer; StdCall; External 'CONVECF.DLL' ; 

function ECF_ReducaoZ(
 Data: pchar;
 Hora: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_RelatorioGerencial( Texto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_RelatorioGerencialTEF( Texto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_FechaRelatorioGerencial: Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalData(
 DataInicial: pchar;
 DataFinal: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalReducao(
 ReducaoInicial: pchar;
 ReducaoFinal: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalSerialData(
 DataInicial: pchar;
 DataFinal: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalSerialReducao(
 ReducaoInicial: pchar;
 ReducaoFinal: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

// Fun��es das Opera��es N�o Fiscais 
function ECF_RecebimentoNaoFiscal(
 IndiceTotalizador: pchar;
 Valor: pchar;
 FormaPagamento: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_AbreComprovanteNaoFiscalVinculado(
 FormaPagamento: pchar;
 Valor: pchar;
 NumeroCupom: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_UsaComprovanteNaoFiscalVinculado( Texto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 



function ECF_UsaComprovanteNaoFiscalVinculadoTEF( Texto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL' 

function ECF_FechaComprovanteNaoFiscalVinculado: Integer; StdCall;
 External 'CONVECF.DLL'; 

function ECF_Sangria( Valor: pchar ): Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_Suprimento(
 Valor: pchar;
 FormaPagamento: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

// Fun��es de Informa��es da Impressora 
function ECF_NumeroSerie( NumeroSerie: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_SubTotal( SubTotal: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroCupom( NumeroCupom: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraXSerial: Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_VersaoFirmware( VersaoFirmware: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CGC_IE( CGC: pchar; IE: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_GrandeTotal( GrandeTotal: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_Cancelamentos( ValorCancelamentos: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_Descontos( ValorDescontos: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroOperacoesNaoFiscais( NumeroOperacoes: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroCuponsCancelados( NumeroCancelamentos: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroIntervencoes( NumeroIntervencoes: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 



function ECF_NumeroReducoes( NumeroReducoes: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroSubstituicoesProprietario(
 NumeroSubstituicoes: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_UltimoItemVendido( NumeroItem: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ClicheProprietario( Cliche: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroCaixa( NumeroCaixa: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroLoja(   NumeroLoja: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_SimboloMoeda( SimboloMoeda: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_MinutosLigada( Minutos: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_MinutosImprimindo( Minutos: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaModoOperacao( Modo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaEpromConectada( Flag: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_FlagsFiscais( Var Flag: Integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ValorPagoUltimoCupom( ValorCupom: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_DataHoraImpressora( Data: pchar; Hora: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ContadoresTotalizadoresNaoFiscais( Contadores: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaTotalizadoresNaoFiscais( Totalizadores: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_DataHoraReducao( Data: pchar; Hora: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_DataMovimento( Data: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaTruncamento( Flag: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_Acrescimos( ValorAcrescimos: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ContadorBilhetePassagem( ContadorPassagem: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaAliquotasIss( Flag: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaFormasPagamento( Formas: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaRecebimentoNaoFiscal( Recebimentos: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 



function ECF_VerificaDepartamentos( Departamentos: pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaTipoImpressora( Var TipoImpressora: Integer ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaTotalizadoresParciais( Totalizadores: pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_RetornoAliquotas( Aliquotas: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaEstadoImpressora(
 Var ACK: Integer;
 Var ST1: Integer;
 Var ST2: Integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_DadosUltimaReducao( DadosReducao: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_MonitoramentoPapel( Var Linhas: Integer): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaIndiceAliquotasIss( Flag: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ValorFormaPagamento(
 FormaPagamento: pchar;
 Valor: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ValorTotalizadorNaoFiscal(
 Totalizador: pchar;
 Valor: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

// Fun��es de Autentica��o e Gaveta de Dinheiro 
function ECF_Autenticacao:Integer; 
StdCall; External 'CONVECF.DLL' Name 'ECF_Autenticacao'; 

function ECF_ProgramaCaracterAutenticacao( Parametros: pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_AcionaGaveta:Integer;
 StdCall; External 'CONVECF.DLL' Name 'ECF_AcionaGaveta'; 

function ECF_VerificaEstadoGaveta( Var EstadoGaveta: Integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 


// Fun��o para a Impressora Bilhete de Passagem 
function ECF_AbreBilhetePassagem(
 ImprimeValorFinal: pchar;
 ImprimeEnfatizado: pchar;
 Embarque: pchar;
 Destino: pchar;
 Linha: pchar;
 Prefixo: pchar;
 Agente: pchar;
 Agencia: pchar;
 Data: pchar;
 Hora: pchar;
 Poltrona: pchar;
 Plataforma: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

// Fun��es de Impress�o de Cheques 
function ECF_ProgramaMoedaSingular(MoedaSingular: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_ProgramaMoedaPlural( MoedaPlural: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaImpressaoCheque: Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaStatusCheque(Var StatusCheque: Integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ImprimeCheque(
 Banco: pchar;
 Valor: pchar;
 Favorecido: pchar;
 Cidade: pchar;
 Data: pchar; Mensagem: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_IncluiCidadeFavorecido(
 Cidade: pchar;
 Favorecido: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ImprimeCopiaCheque: Integer;
 StdCall; External 'CONVECF.DLL' Name 'ECF_ImprimeCopiaCheque'; 

// Outras Fun��es 
function ECF_AbrePortaSerial: Integer; StdCall; External 'CONVECF.DLL';

function ECF_RetornoImpressora(
 Var ACK: Integer;
 Var ST1: Integer;
 Var ST2: Integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_FechaPortaSerial: Integer; 
StdCall; External 'CONVECF.DLL' Name 'ECF_FechaPortaSerial'; 

function ECF_MapaResumo:Integer; 
StdCall; External 'CONVECF.DLL' Name 'ECF_MapaResumo'; 

function ECF_AberturaDoDia(
 ValorCompra: pchar;
 FormaPagamento: pchar ): Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_FechamentoDoDia: Integer; 
StdCall; External 'CONVECF.DLL' Name 'ECF_FechamentoDoDia'; 

function ECF_ImprimeConfiguracoesImpressora:Integer;
StdCall; External 'CONVECF.DLL' Name 'ECF_ImprimeConfiguracoesImpressora'; 

function ECF_ImprimeDepartamentos: Integer;
StdCall; External 'CONVECF.DLL' Name 'ECF_ImprimeDepartamentos'; 



function ECF_RelatorioTipo60Analitico: Integer;
StdCall; External 'CONVECF.DLL' Name 'ECF_RelatorioTipo60Analitico'; 

function ECF_RelatorioTipo60Mestre: Integer; 
StdCall; External 'CONVECF.DLL' Name 'ECF_RelatorioTipo60Mestre'; 

function ECF_VerificaImpressoraLigada: Integer; 
StdCall; External 'CONVECF.DLL' Name 'ECF_VerificaImpressoraLigada'; 

function ECF_ImpressaoCarne(
 Titulo, Percelas: pchar;
 Datas, Quantidade: integer;
 Texto, Cliente, RG_CPF, Cupom: pchar;
 Vias, Assina: integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_InfoBalanca(
 Porta: pchar;
 Modelo: integer;
 Peso, PrecoKilo, Total: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_DadosSintegra(
 DataInicio: pchar;
 DataFinal: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_IniciaModoTEF: Integer;
 StdCall; External 'CONVECF.DLL' Name 'ECF_IniciaModoTEF'; 

function ECF_FinalizaModoTEF: Integer;
 StdCall; External 'CONVECF.DLL' Name 'ECF_FinalizaModoTEF'; 

function ECF_VersaoDll( Versao: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_RegistrosTipo60: Integer; 
 StdCall; External 'CONVECF.DLL' Name 'ECF_RegistrosTipo60'; 

function ECF_LeArquivoRetorno( Retorno: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

// Fun��es da Impressora Fiscal MFD 
function ECF_AbreCupomMFD(
CGC: pchar; 
Nome: pchar;
Endereco : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaCupomMFD(
CGC, Nome, 
Endereco: pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ProgramaFormaPagamentoMFD(
FormaPagto, 
OperacaoTef: pchar) : Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_EfetuaFormaPagamentoMFD(
FormaPagamento,
ValorFormaPagamento,
Parcelas,
DescricaoFormaPagto: pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_CupomAdicionalMFD(): Integer; StdCall; External 'CONVECF.DLL'; 

function ECF_AcrescimoDescontoItemMFD (
Item,
AcrescimoDesconto,
TipoAcrescimoDesconto,
ValorAcrescimoDesconto: pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_NomeiaRelatorioGerencialMFD (Indice, Descricao : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_AutenticacaoMFD(Linhas, Texto : pchar) : Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AbreComprovanteNaoFiscalVinculadoMFD(
FormaPagamento,
Valor,
NumeroCupom,
CGC,
nome,
Endereco : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_ReimpressaoNaoFiscalVinculadoMFD() : Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AbreRecebimentoNaoFiscalMFD(CGC, Nome, Endereco : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_EfetuaRecebimentoNaoFiscalMFD(
IndiceTotalizador,
ValorRecebimento : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_IniciaFechamentoRecebimentoNaoFiscalMFD(
AcrescimoDesconto,
TipoAcrescimoDesconto,
ValorAcrescimo,
ValorDesconto : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_FechaRecebimentoNaoFiscalMFD(Mensagem : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaRecebimentoNaoFiscalMFD(
CGC, 
Nome, 
Endereco : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AbreRelatorioGerencialMFD(Indice : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_UsaRelatorioGerencialMFD(Texto : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_UsaRelatorioGerencialMFDTEF(Texto : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_SegundaViaNaoFiscalVinculadoMFD(): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_EstornoNaoFiscalVinculadoMFD(
CGC,
Nome,
Endereco : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroSerieMFD(NumeroSerie : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_VersaoFirmwareMFD(VersaoFirmware : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_CNPJMFD(CNPJ : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_InscricaoEstadualMFD(InscricaoEstadual : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_InscricaoMunicipalMFD(InscricaoMunicipal : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_TempoOperacionalMFD(TempoOperacional : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_MinutosEmitindoDocumentosFiscaisMFD(Minutos : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ContadoresTotalizadoresNaoFiscaisMFD(Contadores : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaTotalizadoresNaoFiscaisMFD(Totalizadores : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaFormasPagamentoMFD(FormasPagamento : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaRecebimentoNaoFiscalMFD(Recebimentos : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaRelatorioGerencialMFD(Relatorios : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ContadorComprovantesCreditoMFD(Comprovantes : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ContadorOperacoesNaoFiscaisCanceladasMFD(
OperacoesCanceladas : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 



function ECF_ContadorRelatoriosGerenciaisMFD (Relatorios : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ContadorCupomFiscalMFD(CuponsEmitidos : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ContadorFitaDetalheMFD(ContadorFita : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_ComprovantesNaoFiscaisNaoEmitidosMFD(Comprovantes : pchar):Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_NumeroSerieMemoriaMFD(NumeroSerieMFD : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_MarcaModeloTipoImpressoraMFD(
Marca,
Modelo,
Tipo : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_ReducoesRestantesMFD(Reducoes : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaTotalizadoresParciaisMFD(Totalizadores : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_DadosUltimaReducaoMFD(DadosReducao : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalDataMFD(
DataInicial,
DataFinal,
FlagLeitura : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalReducaoMFD(
ReducaoInicial,
ReducaoFinal,
FlagLeitura : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalSerialDataMFD(
DataInicial,
DataFinal,
FlagLeitura : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraMemoriaFiscalSerialReducaoMFD(
ReducaoInicial,
ReducaoFinal,
FlagLeitura : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_LeituraChequeMFD(CodigoCMC7 : pchar): Integer; 
StdCall; External 'CONVECF.DLL'; 



function ECF_ImprimeChequeMFD(
NumeroBanco,
Valor,
Favorecido,
Cidade,
Data,
Mensagem,
ImpressaoVerso,
Linhas : pchar): Integer;
StdCall; External 'CONVECF.DLL'; 


function ECF_HabilitaDesabilitaRetornoEstendidoMFD(FlagRetorno : pchar):Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_RetornoImpressoraMFD(
Var ACK: Integer;
Var ST1: Integer;
Var ST2: Integer;
Var ST3: Integer ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AbreBilhetePassagemMFD(
Embarque,
Destino,
Linha,
Agencia,
Data,
Hora,
Poltrona,
Plataforma,
TipoPassagem,
RGCliente,
NomeCliente,
EnderecoCliente,
UFDetino: pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaAcrescimoDescontoItemMFD( cFlag, cItem: pchar ): integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_SubTotalizaCupomMFD: integer; StdCall; External 'CONVECF.DLL'; 

function ECF_SubTotalizaRecebimentoMFD: integer; StdCall; External 'CONVECF.DLL'; 

function ECF_TotalLivreMFD( cMemoriaLivre: pchar ): integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_TamanhoTotalMFD( cTamanhoMFD: pchar ): integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AcrescimoDescontoSubtotalRecebimentoMFD(
 cFlag,
 cTipo,
 cValor: pchar ): integer; 
 StdCall; External 'CONVECF.DLL'; 





function ECF_AcrescimoDescontoSubtotalMFD(
 cFlag,
 cTipo,
 cValor: pchar): integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaAcrescimoDescontoSubtotalMFD(cFlag: pchar): integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaAcrescimoDescontoSubtotalRecebimentoMFD(
 cFlag: pchar ): integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_TotalizaCupomMFD: integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_TotalizaRecebimentoMFD: integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_PercentualLivreMFD( cMemoriaLivre: pchar ): integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_DataHoraUltimoDocumentoMFD( cDataHora: pchar ): integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_MapaResumoMFD:Integer; 
 StdCall; External 'CONVECF.DLL' Name 'ECF_MapaResumoMFD'; 

function ECF_RelatorioTipo60AnaliticoMFD: Integer; 
 StdCall; External 'CONVECF.DLL' Name 'ECF_RelatorioTipo60AnaliticoMFD'; 

function ECF_ValorFormaPagamentoMFD(
 FormaPagamento: pchar;
 Valor: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ValorTotalizadorNaoFiscalMFD(
 Totalizador: pchar;
 Valor: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaEstadoImpressoraMFD(
 Var ACK: Integer;
 Var ST1: Integer;
 Var ST2: Integer;
 Var ST3: Integer ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_IniciaFechamentoCupomMFD(
 AcrescimoDesconto: pchar;
 TipoAcrescimoDesconto: pchar;
 ValorAcrescimo: pchar;
 ValorDesconto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_TerminaFechamentoCupomCodigoBarrasMFD(
 cMensagem: pchar;
 cTipoCodigo: pchar;
 cCodigo: pchar;
 iAltura: Integer;
 iLargura: Integer;
 iPosicaoCaracteres: Integer;
 iFonte: Integer;
 iMargem: Integer;
 iCorrecaoErros: Integer;
 iColunas: Integer ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaItemNaoFiscalMFD( NumeroItem: pchar ): Integer; 
 StdCall; External 'CONVECF.DLL'; 

function ECF_AcrescimoItemNaoFiscalMFD(
 NumeroItem: pchar;
 AcrescimoDesconto: pchar;
 TipoAcrescimoDesconto: pchar;
 ValorAcrescimoDesconto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CancelaAcrescimoNaoFiscalMFD(
 NumeroItem: pchar;
 AcrescimoDesconto: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_ImprimeClicheMFD:Integer; 
 StdCall; External 'CONVECF.DLL' Name 'ECF_ImprimeClicheMFD'; 

function ECF_ImprimeInformacaoChequeMFD(
 Posicao: Integer;
 Linhas: Integer;
 Mensagem: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_RelatorioSintegraMFD(
iRelatorios : Integer;
cArquivo    : pchar;
cMes        : pchar;
cAno        : pchar;
cRazaoSocial: pchar;
cEndereco   : pchar;
cNumero     : pchar;
cComplemento: pchar;
cBairro     : pchar;
cCidade     : pchar;
cCEP        : pchar;
cTelefone   : pchar;
cFax        : pchar;
cContato    : pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 

function ECF_GeraRelatorioSintegraMFD (
iRelatorios : Integer;
cArquivoOrigem : pchar;
cArquivoDestino: pchar;
cMes           : pchar;
cAno           : pchar;
cRazaoSocial   : pchar;
cEndereco      : pchar;
cNumero        : pchar;
cComplemento   : pchar;
cBairro        : pchar;
cCidade        : pchar;
cCEP           : pchar;
cTelefone      : pchar;
cFax           : pchar;
cContato       : pchar ): Integer;
StdCall; External 'CONVECF.DLL'; 



function ECF_DownloadMF( Arquivo: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_DownloadMFD(
 Arquivo: pchar;
 TipoDownload: pchar;
 ParametroInicial: pchar;
 ParametroFinal: pchar;
 UsuarioECF: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_FormatoDadosMFD(
 ArquivoOrigem: pchar;
 ArquivoDestino: pchar;
 TipoFormato: pchar;
 TipoDownload: pchar;
 ParametroInicial: pchar;
 ParametroFinal: pchar;
 UsuarioECF: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_AtivaDesativaVendaUmaLinhaMFD( iFlag: Integer ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AtivaDesativaAlinhamentoEsquerdaMFD( iFlag: Integer ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AtivaDesativaCorteProximoMFD(): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_AtivaDesativaTratamentoONOFFLineMFD( iFlag: Integer ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_StatusEstendidoMFD( Var iStatus: Integer ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_VerificaFlagCorteMFD( Var iStatus: Integer ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_TempoRestanteComprovanteMFD( cTempo: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_UFProprietarioMFD( cUF: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_GrandeTotalUltimaReducaoMFD( cGT: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_DataMovimentoUltimaReducaoMFD( cData: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_SubTotalComprovanteNaoFiscalMFD( cSubTotal: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_InicioFimCOOsMFD( cCOOIni, cCOOFim: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 

function ECF_InicioFimGTsMFD( cGTIni, cGTFim: pchar ): Integer; 
StdCall; External 'CONVECF.DLL'; 



// Fun��o para Configura��o dos C�digos de Barras 
function ECF_ConfiguraCodigoBarrasMFD(
 Altura: Integer;
 Largura: Integer;
 PosicaoCaracteres: Integer;
 Fonte: Integer; Margem: Integer): Integer; 
 StdCall; External 'CONVECF.DLL'; 

// Fun��es para Impress�o dos C�digos de Barras 
function ECF_CodigoBarrasUPCAMFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasUPCEMFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasEAN13MFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasEAN8MFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasCODE39MFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasCODE93MFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasCODE128MFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasITFMFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasCODABARMFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasISBNMFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasMSIMFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasPLESSEYMFD( Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 

function ECF_CodigoBarrasPDF417MFD(
 NivelCorrecaoErros: Integer;
 Altura: Integer;
 Largura: Integer; Colunas: Integer;
 Codigo: pchar ): Integer;
 StdCall; External 'CONVECF.DLL'; 






// Novas Fun��es




Function ECF_VendeItemTresDecimais(codigo: pchar;
                                   nome: pchar;
                                   aliquota: pchar;
                                   quant: pchar;
                                   valor: pchar;
                                   tipoacrdesc: pchar;
                                   perc: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_IdentificaConsumidor( nomei: pchar;
                                   endi: pchar;
                                   cpfi: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__EmitirCupomAdicional(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__AbreRelatorioGerencial(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__EnviarTextoCNF(cTexto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__AbreRecebimentoNaoFiscal( indice: pchar;
                                        tipoacredesc: pchar;
                                        tipovalor: pchar;
                                        acredesci: pchar;
                                        receb: pchar;
                                        texto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__EfetuaFormaPagamentoNaoFiscal(legenda: pchar;
                                            valor: pchar;
                                            texto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__FundoCaixa(  valor: pchar;
                           legenda: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__ReducaoZAjustaDataHora(
                           cdata: pchar;
                           chora: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__AutenticacaoStr(texto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_ProgramaFormasPagamento(Modal: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__ProgramaOperador(oper: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__CfgFechaAutomaticoCupom(fac: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__CfgRedZAutomatico(zauto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__CfgCupomAdicional(adicional: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__CfgEspacamentoCupons(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__CfgHoraMinReducaoZ(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__CfgLimiarNearEnd(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF__CfgPermMensPromoCNF(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_AlteraRegistry(
                           chave: pchar;
                           valori: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_Path(path: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_PathMFD(path: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_ZAutomatica(zauto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_Verao(verao: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_Log(log: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_AplMensagem1(apl: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_AplMensagem2(apl: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_Default(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_Registry_RetornaValor(ecf: pchar;
                                  chave: pchar;
                                  valor: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_StatusCupomFiscal(cupa: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_StatusRelatorioGerencial(rela: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_StatusComprovanteNaoFiscalVinculado
                                   (vinc: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_StatusComprovanteNaoFiscalNaoVinculado
                                   (nvinc: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaModeloEcf(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaHorarioVerao(verao: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaZPendente(zpen: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaXPendente(xpen: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaDiaAberto(diaa: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaDescricaoFormasPagamento(Formas:pchar):Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaFormasPagamentoEx(FPag: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaTotalizadoresNaoFiscaisEx 
                           (Recebimento: pchar):Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_ClicheProprietarioEx
                           (ClicheProprietario: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RegistraNumeroSerie(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaNumeroSerie(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaSerialCriptografado(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_COO(COOi: pchar; COOf: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_LerAliquotasComIndice(taxas: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VendaBruta(vbruta: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_UltimaFormaPagamento(nome: pchar;
                                  Valor: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_TipoUltimoDocumento(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_PalavraStatus(status: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_PalavraStatusBinario(status: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaErroExtendido(status: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaAcrescimoNF(acnf: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCFCancelados(cfc: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCNFCancelados(nfc: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCLX(clx: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCNFNV(Recebimento: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCNFV(Vinculado: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCOO(COO: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCRO(cro: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCRZ(crz: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCRZRestante(sRed: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaCancelamentoNF( cnf: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaDescontoNF( dnf: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaGNF(gnf: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaTempoImprimindo(MinImprim: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaTempoLigado(MinutosLigada: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaTotalPagamentos(FPag: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaTroco(troco: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaRegistradoresNaoFiscais(rnf: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaRegistradoresFiscais(rf: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaValorComprovanteNaoFiscal
                           (indice: pchar;
                            Valor: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_RetornaIndiceComprovanteNaoFiscal
                           (nome:pchar;
                            indice: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_CasasDecimaisProgramada(   dval: pchar;
                                         dqt: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_TempoEsperaCheque(segundos: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_StatusCheque(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_ImprimirCheque(banco: pchar;
                            cidade: pchar;
                            cdata: pchar;
                            nominal: pchar;
                            valor: pchar;
                            pos: pchar): Integer;
StdCall; External 'CONVECF.DLL';


Function ECF_ImprimirVersoCheque(texto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_LiberarCheque(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_LeituraCodigoMICR(cmc7: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_CancelarCheque(): Integer; 
                           StdCall; External 'CONVECF.DLL';


Function ECF_ProgramarLeiauteCheque(banco: pchar;
                                    geometria: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_LeituraLeiautesCheques(): Integer; 
                           StdCall; External 'CONVECF.DLL';


Function ECF_DescontoSobreItemVendido(item: pchar;
                                      tipodesc: pchar;
                                      valor: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_AcrescimosICMSISS(vaicms: pchar;
                               vaiss: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_CancelamentosICMSISS(vcicms: pchar;
                                   vciss: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_DescontosICMSISS(vdicms: pchar;
                              vdiss: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_LeituraInformacaoUltimoDoc(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_LeituraInformacaoUltimosCNF(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_VerificaRelatorioGerencialProgMFD(sRG: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_SegundaViaCNFV(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_CancelamentoCNFV(ignorado: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_TEF_ImprimirRespostaCartao(path: pchar;
                                        forma: pchar;
                                        trava: pchar;
                                        valor: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_TEF_ImprimirResposta(path: pchar;
                                  forma: pchar;
                                  trava: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_TEF_FechaRelatorio(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_TEF_EsperarArquivo(path: pchar;
                                segundos: pchar;
                                trava: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_TEF_TravarTeclado(trava: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_ApagaTabelaNomesNaoFiscais(): Integer;
                           StdCall; External 'CONVECF.DLL';




Function ECF_ApagaTabelaNomesFormasdePagamento(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_ApagaTabelaAliquotas(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_ApagaTabelaNomesRelatoriosGerenciais(): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_ArquivoSintegra2004MFD( itipo: Integer;
                                    cArquivo: pchar;
                                    cMes: pchar;
                                    cAno: pchar;
                                    cMesf: pchar;
                                    cAnof: pchar;
                                    cRazaoSocial: pchar;
                                    cEndereco: pchar;
                                    cNumero: pchar;
                                    cComplemento: pchar;
                                    cBairro: pchar;
                                    cCidade: pchar;
                                    cUF: pchar;
                                    cCEP: pchar;
                                    cTelefone: pchar;
                                    cFax: pchar;
                                    cContato: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_LigaDesligaJanelas( impressora: pchar;
                                  resto: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';



Function  ECF_EnviarLogotipoCliche  (path: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function  ECF_GravarLogotipoCliche  (): Integer;  
                           StdCall; External 'CONVECF.DLL';


Function  ECF_ExcluirLogotipoCliche (): Integer; 
                           StdCall; External 'CONVECF.DLL';


Function  ECF_ProgramarParametrosDiversos 
                                  (ecf: pchar;
                                  loja: pchar;
                                  extra: pchar;
                                  qt: pchar;
                                  iss: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function  ECF_ProgramarCliche (  razao: pchar;
                                  fantasia: pchar;
                                  endereco:  pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function  ECF_RetornaTipoEcf  (tipo: pchar): Integer; 
                           StdCall; External 'CONVECF.DLL';


Function  ECF_TabelaMercadoriasServicos3404
                                  (destino: pchar;
                                  inicio: pchar;
                                  fim: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function  ECF_ProgramarTotalizadoresNaoTributados  
                                  (f: pchar;
                                   i: pchar;
                                   n: pchar;
                                   fs: pchar;
                                   is_: pchar;
                                   ns: pchar):Integer;
                           StdCall; External 'CONVECF.DLL';


Function  ECF_ReproduzirMemoriaFiscalMFD
                                  (tipo: pchar;
                                   fxai: pchar;
                                   fxaf:  pchar;
                                   asc: pchar;
                                  bin: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


{Function ECF_TipoUltimoDocumento (tipo: pchar): Integer;
                           StdCall; External 'CONVECF.DLL';}


Function ECF_GeraRegistrosCAT52MFD(pathbin:pchar; datas:pchar): Integer;
                           StdCall; External 'CONVECF.DLL';


Function ECF_CapturaDocunmentos(tipo, faixai,
  faixaf, arquivo, log: pchar):Integer;
   StdCall; External 'CONVECF.DLL';


implementation

end.
