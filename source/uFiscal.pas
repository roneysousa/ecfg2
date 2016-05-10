unit uFiscal;

interface

function FISCAL(Comando : String ; Modelo : Integer;
Param1 : String = ''; Param2 : String = ''; Param3 : String = ''; Param4 : String = '';
Param5 : String = ''; Param6 : String = ''; Param7 : String = ''; Param8 : String = '';
Param9 : String = ''; Param10 : String = '';Param11 : String = ''; aTextoTef: String = '') : integer;
function Retorno_Impressora(nComando : String; iRetorno : integer) : Integer;


Var
    aMensagem, aStatus : String;
    aFirmware, aVersao, aNumSerie, aDataMovimento : String;

implementation

Uses uBematech, Forms, Windows, Messages, Dialogs, SysUtils, Variants, Controls, Classes,
  uFuncoes, uDaruma, uSweda, uPrincipalECFG2, uElgin, uMecaf, uUrano;


function FISCAL(Comando : String; Modelo : Integer;
Param1 : String = ''; Param2 : String = ''; Param3 : String = ''; Param4 : String = '';
Param5 : String = ''; Param6 : String = ''; Param7 : String = ''; Param8 : String = '';
Param9 : String = ''; Param10 : String = '';Param11 : String = ''; aTextoTef: String = '') : integer;
Var
    iRetorno, mRetorno, iConta : Integer;
    Status, NumeroCupom : String;
    sCom: array [0..3] of char;
    aResult : boolean;
    //
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
    sAcre   : array [0..30] of char;
    sDescr2 : array [0..30] of char;
    sDesc2  : array [0..30] of char;
    sMsg : array[0..80] of char;
    sIndice : array[0..2] of char;
    Buffer: TStrings;
    aArquivo : String;
    Cont : Integer;
begin
      iRetorno := 1;
      aMensagem := '';
      aStatus := '';
      {Modelos
      1 = Bematech
      2 = Daruma
      3 = Sweda
      4 = Elgin
      5 = Mecaf
      6 = Urano}
      //
      If (Comando = 'VersaoDll') Then
         begin
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 9 do aVersao := aVersao + ' ';
                            iRetorno := uBematech.Bematech_FI_VersaoDll( aVersao );
                       End;
                  End;
                  //
                2:begin       // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                  End;
                3:begin       // Sweda
                         for iConta := 1 to 9 do aVersao := aVersao + ' ';
                            iRetorno :=  uSweda.ECF_VersaoDll( PChar( aVersao) );
                  End;
                //
                4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                       iRetorno := 1;
                       aVersao := ' ';
                  End;
                //
                5:begin       // Mecaf
                      // Verifica Impressora
                      //iRetorno := uMecaf._VerificaImpressoraLigada();
                      iRetorno := 1;
                      aVersao := uMecaf.VersaoDll();
                  End;
                //
                6:begin       // Urano
                      // Verifica Impressora
                      iRetorno := 1;
                      aVersao := uUrano.DLLG2_Versao(aVersao, 0) ;
                  End;

              End;
         End;
       //
      If (Comando = 'VersaoFirmware') Then
         begin
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 4 do aFirmware := aFirmware + ' ';
                            iRetorno := uBematech.Bematech_FI_VersaoFirmware( aFirmware );
                       End;
                  End;
                  //
                2:begin       // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 4 do aFirmware := aFirmware + ' ';
                            iRetorno := uDaruma.Daruma_FI_VersaoFirmware( aFirmware );
                       End;
                  End;
                  //
                3:begin       // Sweda
                         for iConta := 1 to 4 do aFirmware := aFirmware + ' ';
                            iRetorno := uSweda.Ecf_VersaoFirmware( Pchar(aFirmware) );
                  End;
                  //
                4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 8 do aFirmware := aFirmware + ' ';
                            iRetorno := uElgin.Elgin_VersaoFirmware( aFirmware );
                       End;
                  End;
                  //
                  5:begin   // Mecaf
                     iRetorno := 1;
                     aFirmware := uMecaf.VersaoFirmware();
                  End;
                  //
                  6:begin       // Urano
                       iRetorno := 1;
                  End;
              End;
         End;
         //
      If (Comando = 'NumeroSerie') Then
         begin
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 15 do aNumSerie  := aNumSerie + ' ';
                            iRetorno := uBematech.Bematech_FI_NumeroSerie( aNumSerie );
                       End;
                  End;
                  //
                2:begin       // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 15 do aNumSerie := aNumSerie + ' ';
                            iRetorno := uDaruma.Daruma_FI_NumeroSerie( aNumSerie );
                       End;
                  End;
                  //
                3:begin       // Sweda
                         for iConta := 1 to 15 do aNumSerie := aNumSerie + ' ';
                            iRetorno := uSweda.Ecf_NumeroSerie( Pchar(aNumSerie) );
                  End;
                  //
                4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 15 do aNumSerie := aNumSerie + ' ';
                            iRetorno := uElgin.Elgin_NumeroSerie( aNumSerie );
                       End;
                  End;
                  //
                  5:begin   // Mecaf
                    iRetorno := 1;
                    aNumSerie := uMecaf.NumeroSerie();
                  End;
                  //
                  6:begin       // Urano
                    iRetorno := 1;
                    //aNumSerie := uUrano();
                  End;
              End;
         End;
         //
      If (Comando = 'DataMovimento') Then
         begin
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 6 do aDataMovimento := aDataMovimento + ' ';
                            iRetorno := uBematech.Bematech_FI_DataMovimento( aDataMovimento  );
                       End;
                  End;
                  //
                2:begin       // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 6 do aDataMovimento := aDataMovimento + ' ';
                            iRetorno := uDaruma.Daruma_FI_DataMovimento( aDataMovimento );
                       End;
                  End;
                  //
                3:begin       // Sweda
                      for iConta := 1 to 6 do aDataMovimento := aDataMovimento + ' ';
                            iRetorno := uSweda.Ecf_DataMovimento( Pchar(aDataMovimento) );
                  End;
                //
                4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                         for iConta := 1 to 6 do aDataMovimento := aDataMovimento + ' ';
                            iRetorno := uElgin.Elgin_DataMovimento( aDataMovimento );
                       End;
                  End;
                  5:begin   // Mecaf
                    iRetorno := 1;
                    aDataMovimento := uMecaf.DataMovimento();
                  End;
                  //
                  6:begin       // Urano
                        iRetorno := 1;
                        uUrano.LeData(nPorta,'Data', aDataMovimento);
                  End;
              End;
         End;
         //
      If (Comando = 'AbrePortaSerial') Then
         begin
              case modelo of
                1:begin       // Bematech
                      iRetorno := 1;
                  End;
                  //
                2:begin       // Daruma
                       iRetorno := 1;
                  End;
                  //
                3:begin       // Sweda
                      iRetorno := uSweda.ECF_AbrePortaSerial();
                  End;
                  //
                4:begin       // Elgin
                      iRetorno := 1;
                  End;
                  //
                  5:begin   // Mecaf
                      {Par�metros: Porta = Porta serial (COM?), ou endere�o de rede, em que o ECF est�
                      conectado. Esta informa��o ser� passada como um texto.
                      Descri��o: Abre a porta de comunica��o com o ECF e verifica o status do mesmo.
                      Observa��o: Se o par�mentro passado for ZERO, automaticamente ser� feita a busca pela porta.}
                      iRetorno:= 0;
                      If not (FileExists(ExtractFilePath( Application.ExeName +'\Mecaf.txt'))) Then
                          Param1 := 'COM1'
                      Else
                          Param1 := 'COM3';
                      fillchar (sCom, 4, 0);
                      StrPCopy(sCom, Param1);
                      iRetorno := uMecaf.AFRAC_AbrirPorta(sCom);
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                      //
                  End;
                  //
                  6:begin       // Urano
                        //aArquivo := ExtractFilePath( Application.ExeName) + 'urano.txt';
                        //
                        M_NMPORT := 'COM1';
                        //
                     If FileExists('PORTA.TXT') Then
                       begin
                        try

                            AssignFile(M_ARCONF, 'PORTA.TXT');
                            Reset(M_ARCONF, 'PORTA.TXT');
                            ReadLn(M_ARCONF, M_LINHA);
                            //
                            M_NMPORT := M_LINHA;
                            //
                            Cont := 1;
                            While not Eof ( M_ARCONF ) do
                              begin
                                   ReadLn(M_ARCONF, M_LINHA);
                                   //
                                   Case Cont of
                                       1: M_NMPORT := M_LINHA;
                                   End;
                                   //
                                   Cont := Cont + 1;
                              End;

                        finally
                            CloseFile(M_ARCONF);
                        end;
                       End;
                        //
                        {If not (FileExists(aArquivo)) Then
                          Param1 := 'COM1'
                        Else
                          Param1 := 'COM3';}
                        Param1  := M_NMPORT;
                        {nPorta   := 0;
                        iRetorno := uUrano.IniciaDriver(aParam1);
                        nPorta   := iRetorno;}
                        nPorta := uUrano.IniciaDriver(Param1);
                        if (nPorta >= 0) then
                         begin
                            iRetorno := 1;
                         End
                        else
                         begin
                           iRetorno := 0;
                           Application.MessageBox(PChar('Erro na Opera��o > ' + InttoStr(nPorta) ), PChar(param1));
                         End;
                  End;
              End;
         End;
         //
      If (Comando = 'FechaPortaSerial') Then
         begin
              case modelo of
                1:begin       // Bematech
                      iRetorno := 1;
                  End;
                  //
                2:begin       // Daruma
                       iRetorno := 1;
                  End;
                  //
                3:begin       // Sweda
                      // Abre porta serial
                      iRetorno := uSweda.ECF_FechaPortaSerial();
                  End;
                4:begin       // Elgin
                      iRetorno := 1;
                  End;
                  //
                  5:begin   // Mecaf
                       uMecaf.FechaPorta;
                  End;
                  //
                  6:begin       // Urano
                        //iRetorno := uUrano.DLLG2_EncerraDriver(aParam1);
                        {if ( frmMainEcFG2.TrataErro( EncerraDriver(nPorta)) ) then
                         begin
                            Application.MessageBox('Opera��o Realizada com Sucesso', 'Demo Fit');
                            iRetorno := 1;
                         end;      }
                        iRetorno := uUrano.EncerraDriver(nPorta);
                        //
                        if (iRetorno = 0) then
                           iRetorno := 1
                        else
                           iRetorno := 0;
                  End;
              End;
         End;

         //
      If (Comando = 'LeituraX') Then
         begin
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_LeituraX();
                      iRetorno := Retorno_Impressora('LeituraX',iRetorno);
                  End;
                 2:begin     // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_LeituraX();
                   End;
                 3:begin      // Sweda
                       iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                       if (iRetorno = 1) Then
                           iRetorno := uSweda.ECF_LeituraX;
                   end;
                 4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := 0;
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_LeituraX();
                  End;
                  5:begin   // Mecaf
                        // Leitura X
                        iRetorno := uMecaf.AFRAC_LeituraX;
                        if (iRetorno = 0) then
                           iRetorno := 1
                        else
                           iRetorno := 0;
                  End;
                  //
                  6:begin       // Urano
                        {Par�metros
                      	Variavel:	Destino
                      	TipoDado:	string	Tamanho M�ximo:	1	Opcional
                      	Descricao:	Destino do retorno do comando: 'I' - Impressora; 'S' - Recep��o Serial.
                      	Variavel:	ImprimeBitmap
                      	TipoDado:	bool	Tamanho M�ximo:		Opcional
                      	Descricao:	Quando setada (= 'true'), imprime o 'bitmap' neste documento.Se n�o informado, n�o ser� impresso.
                      	Variavel:	Operador
                      	TipoDado:	string	Tamanho M�ximo:	8	Opcional
                      	Descricao:	Identifica��o do operador.    }
                        iRetorno := uUrano.EmiteLeituraX(nPorta, 'I', 'False', '', Buffer);
                        if (iRetorno = 0) then
                         begin
                           iRetorno := 1;
                           //iRetorno := uUrano.AvancaPapel();
                        End;
                        //
                        iRetorno := uUrano.AvancaPapel();
                  End;
              End;  // fim-caso
         end;   // LeituraX
      //
      If (Comando = 'ReducaoZ') Then
       begin
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                         iRetorno := uBematech.Bematech_FI_ReducaoZ(pchar(DateToStr(Date)),pchar(TimeToStr(Time)));
                      iRetorno := Retorno_Impressora('ReducaoZ',iRetorno);
                  End;
                2:begin       // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                         iRetorno := uDaruma.Daruma_FI_ReducaoZ();
                         //iRetorno := uDaruma.Daruma_FI_ReducaoZ(pchar(DateToStr(Date)),pchar(TimeToStr(Time)));
                  End;
                3:begin       // Sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                         // Data:  STRING com a data atual no computador.  Os formatos aceitos s�o:   ddmmaa,   dd/mm/aa,  ddmmaaaa ou  dd/mm/aaaa.
                         // Hora: STRING   com a hora do computador a ser ajustada no formato hhmmss ou hh:mm:ss. O ajuste est� limitado a cinco minutos
                           iRetorno := uSweda.ECF_FechamentoDoDia();
                           //iRetorno := uSweda.ECF_ReducaoZ(pchar(DateToStr(Date)),pchar(TimeToStr(Time)));
                      iRetorno := Retorno_Impressora('ReducaoZ',iRetorno);
                  End;
                4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                         iRetorno := uElgin.Elgin_ReducaoZ(pchar(DateToStr(Date)),pchar(TimeToStr(Time)));
                      //iRetorno := Retorno_Impressora('ReducaoZ',iRetorno);
                  End;
                5:begin       // Mecaf
                      // Verifica Impressora
                      //iRetorno := uMecaf
                      Param1 := DatetoStr(Date());
                      iRetorno := uMecaf.AFRAC_ReducaoZ(PChar(Param1));
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                 End;
                  //
                  6:begin       // Urano
                       {Descri��o:	Emite a redu��o Z - fechamento fiscal di�rio, permitindo opcionalmente o ajuste do rel�gio com
                     	toler�ncia de 5 minutos a maior ou a menor com rela��o ao hor�rio atual do rel�gio do ECF.
                     	Observa��es:	Sendo informado um dos par�metros <Data><Hora>, a informa��o de ambos ser� obrigat�ria p/ a
                     	execu��o do comando. Se houver diferen�a de mais/menos 5 minutos entre data/hora do ECF e
                     	<Data><Hora> informados, ser�o considerado apenas 5 minutos p/ o acerto.                      }
                      //
                      {Par�metros
                    	Variavel:	Hora
                    	TipoDado:	hora	Tamanho M�ximo:		Opcional
                    	Descricao:
                    	Variavel:	Operador
                    	TipoDado:	string	Tamanho M�ximo:	8	Opcional
                    	Descricao:	Identifica��o do operador.}
                      Param1 := ''; //TimetoStr(Time);
                      Param2 := '';
                      iRetorno := uUrano.EmiteReducaoZ(nPorta, Param2, Param1);
                      if (iRetorno = 0) then
                        begin
                            iRetorno := 1;
                            iRetorno := uUrano.AvancaPapel();
                        End
                        else
                         begin
                             frmMainEcFG2.TrataErro(iRetorno);
                             //
                             iRetorno := 0;
                         End;
                  End;
              End;  //fim-caso
       End;    // ReducaoZ
       //
       If (Comando = 'MemoriaFiscal') or (Comando = 'MemoriaFiscalData') Then
         begin
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_LeituraMemoriaFiscalData(
                                       pchar( Param1 ), pchar( Param2 ) );
                      iRetorno := Retorno_Impressora('MemoriaFiscal',iRetorno);
                 End;
                 //
                 2:begin       // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_LeituraMemoriaFiscalData(
                                       pchar( Param1 ), pchar( Param2 ) );
                      iRetorno := Retorno_Impressora('MemoriaFiscal',iRetorno);
                 End;
                3:begin       // Sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // DataInic: STRING   com a data inicial no formato   ddmmaa, dd/mm/aa, ddmmaaaa ou dd/mm/aaaa.
                          // DataFim: STRING   com a data final    no formato  ddmmaa, dd/mm/aa, ddmmaaaa ou dd/mm/aaaa.
                           iRetorno := uSweda.ECF_LeituraMemoriaFiscalData(pchar( Param1 ), pchar( Param2 ));
                      iRetorno := Retorno_Impressora('MemoriaFiscal',iRetorno);
                  End;
                4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_LeituraMemoriaFiscalData(pchar( Param1 ), pchar( Param2 ) , pchar( 'c') );
                 End;
                5:begin       // Mecaf
                      // Verifica Impressora
                      //iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      iRetorno := uMecaf.AFRAC_EmitirLeituraMemoriaFiscal('1', pchar(Param1) , pchar( Param2));
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                 End;
                  //
                  6:begin       // Urano
                        {Par�metros
                        Variavel:	DataFinal
	                      TipoDado:	data	Tamanho M�ximo:		Opcional
                      	Descricao:	 Data desejada para encerrar a emiss�o da leitura da Mem�ria Fiscal.
                      	Variavel:	DataInicial
                      	TipoDado:	data	Tamanho M�ximo:		Opcional
                      	Descricao:	 Data desejada para iniciar a emiss�o da leitura da Mem�ria Fiscal.
                      	Variavel:	Destino
                      	TipoDado:	string	Tamanho M�ximo:	1	Opcional
                      	Descricao:	Destino do retorno do comando: 'I' - Impressora; 'S' - Recep��o Serial.
                      	Variavel:	LeituraSimplificada
                      	TipoDado:	bool	Tamanho M�ximo:	0	Obrigat�rio
                      	Descricao:	Indicador de leitura simplificado, quando setado.
                      	Variavel:	Operador
                      	TipoDado:	string	Tamanho M�ximo:	8	Opcional
                      	Descricao:	Identifica��o do operador.
                      	Variavel:	ReducaoFinal
                      	TipoDado:	uint	Tamanho M�ximo:		Opcional
                      	Descricao:	Redu��o desejada para encerrar a emiss�o da leitura da Mem�ria Fiscal.
                      	Variavel:	ReducaoInicial
                      	TipoDado:	uint	Tamanho M�ximo:		Opcional
                      	Descricao:	Redu��o desejada para iniciar a emiss�o da leitura da Mem�ria Fiscal.                      }
                        //
                        iRetorno := uUrano.EmiteLeituraMF(nPorta,  Param1, Param2, 'I', 'False', Buffer);
                        if (iRetorno = 0) then
                         begin
                           iRetorno := 1;
                           iRetorno := uUrano.AvancaPapel();
                         End
                        else
                           iRetorno := 0;
                  End;
              End; // fim-caso
         End;     // fim-MemoriaFiscal
         //
         if (Comando = 'StatusEcf') Then
           begin
              mRetorno := 0;
              case modelo of
                1:begin       // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                           iRetorno := uBematech.Bematech_FI_FlagsFiscais(mRetorno);
                           iRetorno := Retorno_Impressora('FlagsFiscais',iRetorno);
                       End;
                      aStatus := inttostr(mRetorno);
                  End;
                  //
                2:begin      // daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_FlagsFiscais(mRetorno);
                      aMensagem := inttostr(mRetorno);
                  End;
                  //
                3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uSweda.ECF_FlagsFiscais(mRetorno);
                      aMensagem := inttostr(mRetorno);
                  End;
                4:begin       // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_FlagsFiscais(mRetorno);
                      aStatus := inttostr(mRetorno);
                  End;
                 //
                 5:begin
                   iRetorno := 1;
                 End;
                  //
                  6:begin       // Urano
                      iRetorno := 1;
                  End;
               End;  // fim-case
           End;  // fim-StatusEcf
           //
           If (Comando = 'AbreCupom') Then
             begin
               case modelo of
                   1:begin  // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_AbreCupom( pchar( '' ) );
                      iRetorno := Retorno_Impressora('AbreCupom',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                    End;
                   2:begin  // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_AbreCupom( pchar( '' ) );
                    End;
                   3:begin   //sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                         // CNPJ_CPF: STRING at� 20 caracteres com o CNPJ/CPF do consumidor  Se n�o tiver, informar espa�os ou ��.
                          iRetorno := uSweda.ECF_AbreCupom( pchar( Param1 ) );
                   end;
                   4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();;
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_AbreCupom( pchar( '' ) );
                      iRetorno := Retorno_Impressora('AbreCupom',iRetorno);
                    End;
                    5:begin       // Mecaf
                      iRetorno := uMecaf.AFRAC_AbrirCupom();
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                     End;
                     //
                     6:begin       // Urano
                           {Par�metros
                         	Variavel:	EnderecoConsumidor
                         	TipoDado:	string	Tamanho M�ximo:	80	Opcional
                         	Descricao:	Endere�o do consumidor.
                         	Variavel:	IdConsumidor
                         	TipoDado:	string	Tamanho M�ximo:	29	Opcional
                         	Descricao:	Identifica��o do consumidor.
                         	Variavel:	NomeConsumidor
                         	TipoDado:	string	Tamanho M�ximo:	30	Opcional
                         	Descricao:	Nome do consumidor.}
                          //uUrano.DLLG2_LimpaParams(0);
                          iRetorno := uUrano.AbreCupomFiscal(nPorta, Param1, Param2, Param3 );
                          //
                          if (iRetorno = 0) then
                              iRetorno := 1;
                     End;
               End; //fim-caso
             End;  // fim- AbriCupom
             //
        If (Comando = 'CancelaCupom') Then
           begin
               case modelo of
                   1:begin  // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_CancelaCupom;
                      iRetorno := Retorno_Impressora('CancelaCupom',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                    End;
                    //
                    2:begin   //daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_CancelaCupom;
                    End;
                    3:begin  //sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uSweda.ECF_CancelaCupom;
                    End;
                    //
                   4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_CancelaCupom;
                    End;
                    5:begin    // Mecaf
                      iRetorno := uMecaf.AFRAC_CancelarCupom();
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                    End;
                    //
                    6:begin       // Urano
                           {Par�metros
                         	Variavel:	Operador
                         	TipoDado:	string	Tamanho M�ximo:	8	Opcional
                         	Descricao:	Identifica��o do operador. }
                          iRetorno := uUrano.CancelaCupom(nPorta, Param1);
                          if (iRetorno = 0) then
                           begin
                               iRetorno := 1;
                               iRetorno := uUrano.AvancaPapel();
                           End;
                    End;
               End; // fim-caso
           End;  // fim-CancelaCupom
           //
         If (Comando = 'CancelaItemGenerico') Then
           begin
               case modelo of
                   1:begin  // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_CancelaItemGenerico(PChar(Param1)) ;
                      iRetorno := Retorno_Impressora('CancelaItemGenerico',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                   End;
                   2:begin // daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_CancelaItemGenerico(PChar(Param1)) ;
                    End;
                    3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // NumeroItem: STRING com o n�mero do item a ser cancelado com no m�ximo 3 d�gitos. Informando �� ou zeros cancelar� o �ltimo item.
                          iRetorno := uSweda.ECF_CancelaItemGenerico(PChar(Param1)) ;
                    End;
                   4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_CancelaItemGenerico(PChar(Param1)) ;
                   End;
                   5:begin      // Mecaf
                       iRetorno := uMecaf.AFRAC_CancelarItem(PChar(Param1));
                       if (iRetorno = 0) then
                          iRetorno := 1
                       else
                          iRetorno := 0;
                     End;
                    //
                    6:begin       // Urano
                           {Par�metros
                         	Variavel:	NumItem
                         	TipoDado:	int	Tamanho M�ximo:		Opcional
                         	Descricao:	N�mero seq�encial de lan�amento do item a que se refere esta opera��o no cupom em emiss�o.
                         	Variavel:	Quantidade
                         	TipoDado:	money	Tamanho M�ximo:		Opcional
                         	Descricao:	Quantidade envolvida na transa��o.Quando este par�metro n�o for informado, cancela
                         	quantidade total referente ao item ou ao c�digo.}
                          iRetorno := uUrano.CancelaItemFiscal(nPorta, Param1, '' ); // param2
                          frmMainEcFG2.TrataErro(iRetorno);
                          //
                          if (iRetorno = 0) then
                             iRetorno := 1;
                    End;
                   //
               End; // fim-caso
               //
           End;      // fim -  CancelaItemGenerico
        //
        If (Comando = 'CancelaItemAnterior') Then
          begin
               case modelo of
                   1:begin  // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_CancelaItemAnterior;
                      iRetorno := Retorno_Impressora('CancelaItemAnterior',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                   End;
                   2:begin  // daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_CancelaItemAnterior;
                   End;
                   3:begin  //sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno :=  uSweda.ECF_CancelaItemAnterior;
                   End;
                   4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_CancelaItemAnterior;
                   End;
                   5:begin   // Mecaf
                       iRetorno := uMecaf.AFRAC_CancelarItem(PChar('0'));
                       if (iRetorno = 0) then
                          iRetorno := 1
                       else
                          iRetorno := 0;
                   End;
                   //
                   6:begin       // Urano
                         {Descri��o:	Cancela total ou parcialmente item emitido em um cupom fiscal. Se nenhum par�metro for informado,
                       	cancela o �ltimo item registrado.
                       	Observa��es:
                         Retornos
                         Par�metros
                       	Variavel:	NumItem
                       	TipoDado:	int	Tamanho M�ximo:		Opcional
                       	Descricao:	N�mero seq�encial de lan�amento do item a que se refere esta opera��o no cupom em emiss�o.
                       	Variavel:	Quantidade
                       	TipoDado:	money	Tamanho M�ximo:		Opcional
                  	     Descricao:	Quantidade envolvida na transa��o.Quando este par�metro n�o for informado, cancela
                  	     quantidade total referente ao item ou ao c�digo.}
                         iRetorno := uUrano.CancelaItemFiscal(nPorta, '', '');
                         frmMainEcFG2.TrataErro(iRetorno);
                         //
                         if (iRetorno = 0) then
                             iRetorno := 1;
                   End;
               End; // fim-caso
          End; //      fim-CancelaItemAnterior
          //
        If (Comando = 'VendaItem') Then
         begin
               case modelo of
                   1:begin  // Bematech
                      // Verifica Impressora
                      //iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      iRetorno := 1;
                      Param2 := copy(Param2,1,29);
                      Param5 := copy(Param5,8,7);
                      Param7 := copy(Param7,7,8);
                      if (Param8 = '$') then
                         Param9 := copy(Param9,7,8);
                      If (iRetorno = 1) Then
                           iRetorno := uBematech.Bematech_FI_VendeItem
                                 ( pchar( Param1 ),           // Codigo (13)
                                   pchar( Param2 ),           // Descricao (29)
                                   pchar( Param3 ),           // Aliquota (2)  Indice da ECF
                                   pchar( Param4 ),           // Tipo Qtde (1) I - Inteira e F - Fracion�ria.
                                   pchar( Param5 ),           // Quantidade (7)  3 s�o fra��o
                                   StrtoInt(Param6),          // Casa Decimais (Valores validos : 2 ou 3)
                                   pchar( Param7),            // Valor (8)
                                   pchar( Param8 ),           // Tipo desconto (Valores validos : % ou $)
                                   pchar( Param9 ));           // Desconto (8 para valor e 4 p/ percentual)
                      //if (iRetorno) = 1 then
                      iRetorno := Retorno_Impressora('VendaItem',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                   End;
                   //
                   2:begin  //daruma
                      // Verifica Impressora
                      //iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      iRetorno := 1;
                      Param2 := copy(Param2,1,29);
                      Param5 := copy(Param5,8,7);
                      Param7 := copy(Param7,7,8);
                      if (Param8 = '$') then
                         Param9 := copy(Param9,7,8);
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_VendeItem
                                 ( pchar( Param1 ),     // Codigo (13)
                                   pchar( Param2 ),     // Descricao (29)
                                   pchar( Param3 ),     // Aliquota (2)  Indice da ECF
                                   pchar( Param4 ),     // Tipo Qtde (1) I - Inteira e F - Fracion�ria.
                                   pchar( Param5 ),     // Quantidade (7)  3 s�o fra��o
                                   StrtoInt(Param6),    // Casa Decimais (Valores validos : 2 ou 3)
                                   pchar( Param7 ),     // Valor (8)
                                   pchar( Param8 ),     // Tipo desconto (Valores validos : % ou $)
                                   pchar( Param9 ) );   // Desconto (8 para valor e 4 p/ percentual)
                    End;
                    3:begin   //sweda
                      // Verifica Impressora
                      //iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      iRetorno := 1;
                      Param2 := copy(Param2,1,29);
                      Param5 := copy(Param5,8,7);
                      Param7 := copy(Param7,7,8);
                      if (Param8 = '$') then
                         Param9 := copy(Param9,7,8);
                      If (iRetorno = 1) Then
                           iRetorno := uSweda.ECF_VendeItem
                                 ( pchar( Param1 ),     // STRING at� 14 caracteres com o c�digo do produto.
                                   pchar( Param2 ),     // STRING at� 29 caracteres com o nome do produto.
                                   pchar( Param3 ),     // STRING com a taxa, indicador ou �ndice tribut�rio.   -- Aliquota (2)  Indice da ECF
                                   pchar( Param4 ),     // STRING   de 1 (um) caracter indicando o tipo de quantidade: �I� - Inteira. �F� - Fracion�ria.
                                   pchar( Param5 ),     // STRING  com at�  4  d�gitos para a quantidade inteira e 7 d�gitos para a quantidade fracion�ria  (sendo 3 casas decimais). Se o ponto e a v�rgula forem informados eles ser�o  ignorados.
                                   StrtoInt(Param6),    // INTEIRO   indicando o n�mero de casas decimais para o valor unit�rio (2 ou 3).
                                   pchar( Param7 ),     // STRING  at� 8 d�gitos com o valor unit�rio. Se o ponto e a v�rgula forem informados eles ser�o ignorados.
                                   pchar( Param8 ),     // STRING de 1 caracter indicando o tipo do desconto: �$� = desconto por valor. �%� = desconto percentual.
                                   pchar( Param9 ) );   // STRING com at� 8 d�gitos para desconto em valor (duas casas decimais) e 4 d�gitos para desconto percentual. Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                      iRetorno := Retorno_Impressora('VendaItem',iRetorno);
                    End;
                   4:begin  // Elgin
                      // Verifica Impressora
                      //iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      iRetorno := 1;
                      Param2 := copy(Param2,1,29);
                      Param5 := copy(Param5,8,7);
                      Param7 := copy(Param7,7,8);
                      if (Param8 = '$') then
                      begin
                         Param9 := copy(Param9,7,8);
                         Param9 := Copy(Param9, 2, 6)+','+Copy(Param9, 7,2);
                      End;
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_VendeItem
                                 ( pchar( Param1 ),           // Codigo (13)
                                   pchar( Param2 ),           // Descricao (29)
                                   pchar( Param3 ),           // Aliquota (2)  Indice da ECF
                                   pchar( Param4 ),           // Tipo Qtde (1) I - Inteira e F - Fracion�ria.
                                   pchar( Param5 ),           // Quantidade (7)  3 s�o fra��o
                                   StrtoInt(Param6),          // Casa Decimais (Valores validos : 2 ou 3)
                                   pchar( Param7),            // Valor (8)
                                   pchar( Param8 ),           // Tipo desconto (Valores validos : % ou $)
                                   pchar( Param9 ));           // Desconto (8 para valor e 4 p/ percentual)
                      //if (iRetorno) = 1 then
                         iRetorno := Retorno_Impressora('VendaItem',iRetorno);
                   End;
                   5:begin   // Mecaf
                      // Verifica Impressora
                      iRetorno := 1;
                      //
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
                      //
                      DecimalSeparator := '.';
                      StrPCopy(sCod,Param1);
                      StrPCopy(sDescr,uFuncoes.Alltrim(Param2));
                      Param5 := copy(Param5,1,11)+'.'+copy(Param5,12,3);
                      Param7 := copy(Param7,1,12)+'.'+copy(Param7,13,2);
                      Param9 := copy(Param9,1,12)+'.'+copy(Param9,13,2);
                      StrPCopy(sQtd,FloatToStrf(StrtoFloat(Param5), fffixed, 16,2));
                      StrPCopy(sValor, FloatToStrf(StrtoFloat(Param7), fffixed, 16, 2));
                      if (Param8 = '$') then
                         begin
                           StrPCopy(sAcreDesc, '1');
                           StrPCopy(sPercVl, '1');
                         end

                      else
                         begin
                            StrPCopy(sAcreDesc, '0');
                            StrPCopy(sPercVl, '0');
                         end;
                      StrPCopy(sDesc, FloatToStrf(StrtoFloat(Param9), fffixed, 16, 2));
                      StrPCopy(sUnid, Param10);
                      StrPCopy(sImp1L,'0');
                      StrPCopy(sTotal,'0');
                      //
                      Param2 := copy(Param2,1,29);
                      Param5 := copy(Param5,8,7);
                      Param7 := copy(Param7,7,8);
                      //
                      if pos(Param3[1],'IFN') > 0 then
                         StrPCopy(sAliq,'M' + Param3[1] + '00')
                      else
                         if pos(Param3[1],'J') > 0 then
                            StrPCopy(sAliq,copy(Param3,1,2))
                         else
                            //StrPCopy(sAliq,'M'+'T' + copy(Param3,1,2));
                            StrPCopy(sAliq,'M' + Param3 );
                      //
                      If (iRetorno = 1) Then
                           iRetorno := uMecaf.AFRAC_VenderItem(sCod, sDescr, sQtd,
                                sValor, sAcreDesc, sPercVl, sDesc,  sTotal, sAliq, sUnid,sImp1L);
                           {iRetorno := uMecaf.AFRAC_VenderItem
                                 ( pchar( Param1 ),           // codigo = c�digo do produtoQuantidade
                                   pchar( Param2 ),           // descricao = descricao do produto
                                   pchar( Param5 ),           // qtde = quantidade do item
                                   pchar( Param7 ),           // valor_unitario = valor unitario do item
                                   pchar( Param8 ),           // acres_desc = define se ser� dado um acr�scimo ou desconto sobre o item
                                   pchar( Param9 ),           // perc_valor = define se o acr�scimo ou valor ser� percentual ou valor
                                   pchar( Param9 ),           // valor_acresdesc = valor do acr�scimo ou desconto
                                   pchar( Param8 ),           // valor_total = a biblioteca retorna nesta vari�vel o valor total do item
                                   pchar( Param3 ),           // aliquota = c�digo da al�quota do item
                                   pchar( Param10),           // unidade = texto que descreve a unidade do item. Se n�o informado, assumese �UN�
                                   pchar( Param11));          // ForcarImpressaoUmaLinha = for�ar impress�o em uma linha se o ECF tiver o recurso.
                          //iRetorno := Retorno_Impressora('VendaItem',iRetorno);}
                          uMecaf.Ret(iRetorno,'AFRAC_VenderItem');
                          if (iRetorno = 0) then
                             iRetorno := 1
                          else
                             iRetorno := 0;
                   End;
                   //
                   6:begin       // Urano
                           {Par�metros
	                         Variavel:	AliquotaICMS
                         	TipoDado:	bool	Tamanho M�ximo:		Opcional
                         	Descricao:	Identifica a aliquota como ICMS ('true') ou ISS ('false').Deve ser utilizado em conjunto com o
                         	par�metro <PercentualAliquota> para identificar a al�quota deste produto.
                         	Variavel:	CodAliquota
                         	TipoDado:	byte	Tamanho M�ximo:		Opcional
                         	Descricao:	�ndice da al�quota, sendo v�lidos os valores: intervalo entre 0 e
                         	NUM_ALIQUOTAS_PROGRAMAVEIS; -4 = N.Trib. ICMS ou 'N'; -3 = Isento ICMS ou 'I'; -2 =
                         	Subst.Trib. ICMS ou 'F'; -11 = 'F' ISS, -12 = 'I' ISS e -13 = 'N' ISS.Se informado tem preced�ncia
                         	sobre os par�metros <AliquotaICMS> e <PercentualAliquota>.
                         	Variavel:	CodDepartamento
                         	TipoDado:	byte	Tamanho M�ximo:		Opcional
                         	Descricao:	�ndice do departamento entre 0 e NUM_DEPARTAMENTOS.Quando n�o informado, o comando de
                         	venda de item n�o acresce o valor vendido a totalizadores de departamento. Este par�metro tem
                         	preced�ncia sobre o par�metro <NomeDepartamento>.
                         	Variavel:	CodProduto
                         	TipoDado:	string	Tamanho M�ximo:	48	Obrigat�rio
                         	Descricao:	C�digo do produto.
                         	Variavel:	NomeDepartamento
                         	TipoDado:	string	Tamanho M�ximo:	15	Opcional
                         	Descricao:	Nome do departamento. Exemplo: Padaria, A�ougue, T�xtil, etc.O departamento de venda deste
                         	produto pode ser informado pelo seu nome opcionalmente ao seu c�digo no par�metro
                         	<CodDepartamento>.
                         	Variavel:	NomeProduto
                         	TipoDado:	string	Tamanho M�ximo:	200	Obrigat�rio
                         	Descricao:	Nome descritivo do produto.
                         	Variavel:	PercentualAliquota
                         	TipoDado:	money	Tamanho M�ximo:		Opcional
                         	Descricao:	Valor percentual com precis�o de 2 casas decimais.Utilizado em conjunto com o par�metro
                         	<AliquotaICMS> � um modo alternativo � indica��o da al�quota quando o par�metro <CodAliquota>
                         	n�o for informado. A al�quota deve estar necessariamente definida.
                         	Variavel:	PrecoUnitario
                         	TipoDado:	money	Tamanho M�ximo:		Obrigat�rio
                         	Descricao:	Pre�o Unit�rio.O comando de venda de item trata pre�os unit�rios que possuam at� 3 casas
                         	decimais, limitados por for�a de legisla��o a 11 d�gitos m�ximos.
                         	Variavel:	Quantidade
                         	TipoDado:	money	Tamanho M�ximo:		Obrigat�rio
                         	Descricao:	Quantidade envolvida na transa��o.O comando de venda de item trata quantidades com at� 3
                         	casas decimais, limitados por for�a de legisla��o a 8 d�gitos m�ximos.
                         	Variavel:	Unidade
                         	TipoDado:	string	Tamanho M�ximo:	2	Opcional
                         	Descricao:	Unidade do produto. Se n�o informado ser� assumido o texto "un" (sem as aspas).}
                          //iRetorno := uUrano.VendeItem(nPorta, Param3, param1, param2, Param7, Param5, Param10);
                          If (Param3 = '1700') Then
                              Param3 := '01';
                          If (Param3 = '1200') Then
                              Param3 := '02';
                          If (Param3 = '2500') Then
                              Param3 := '03';
                          If (Param3 = '3000') Then
                              Param3 := '04';
                          If (Param3 = 'F1') Then  // Substitui��o tribut�ria (T07)
                              Param3 := '-2';
                          If (Param3 = 'I1') Then  // Isen��o (T08)
                              Param3 := '-3';
                          If (Param3 = 'N1') Then  // N�o tributadas (T09)
                              Param3 := '-4';
                          // Quant
                          Param5 := InttoStr(StrtoInt(copy(Param5,1,11)))+','+copy(Param5,12,2);
                          // Valor
                          Param7 := InttoStr(StrtoInt(copy(Param7,1,12)))+','+copy(Param7,13,2);
                          iRetorno := 0;
                          //
                          Param2 := copy(Param2,1,29);
                          {Param5 := copy(Param5,8,8);
                          Param7 := copy(Param7,6,11);}
                          //
                          try
                            uUrano.DLLG2_LimpaParams(0);
                            uUrano.DLLG2_AdicionaParam(0, 'CodAliquota', Param3, 4);
                            uUrano.DLLG2_AdicionaParam(0, 'CodProduto', Param1, 7);
                            uUrano.DLLG2_AdicionaParam(0, 'NomeProduto', uFuncoes.RemoveAcento(Param2), 7);
                            uUrano.DLLG2_AdicionaParam(0, 'PrecoUnitario', Param7, 6);
                            uUrano.DLLG2_AdicionaParam(0, 'Quantidade', Param5, 6);
                            uUrano.DLLG2_AdicionaParam(0, 'Unidade', Param10, 7);
                            //
                            iRetorno := uUrano.DLLG2_ExecutaComando(0, 'VendeItem');
                            frmMainEcFG2.TrataErro(iRetorno);
                            //
                          Except

                          End;
                          {iRetorno := uUrano.VendeItem(nPorta, Param3, param1, param2, Param7, Param5, Param10);
                          if (iRetorno = 0) then
                             iRetorno := 1;
                          frmMainEcFG2.TrataErro( iRetorno );}
                          {Param3,   CodAliquota
                          param1,    CodProduto
                          param2,    NomeProduto
                          Param7,    PrecoUnitario
                          Param5,   Quantidade
                          Param10    Unidade
                          }
                   End;
               End; // fim-caso
         End;   // VendaItem
      //
      If (Comando = 'TotalCupom') Then
        begin
             case modelo of
                1:begin  // bematech
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_IniciaFechamentoCupom(
                              pchar( Param1 ),    // Acrescimo/Desconto (Valores validos : A ou D)
                              pchar( Param2 ),    // TipoAcrescimoDesconto (Valores validos : % ou $)
                              pchar( Param3 ));  // Valor AcrescimoDesconto (14 por valor ou 4 percentual)
                      iRetorno := Retorno_Impressora('TotalCupom',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                  End;
                 //
                2:begin  // Daruma
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_IniciaFechamentoCupom(
                              pchar( Param1 ),    // Acrescimo/Desconto (Valores validos : A ou D)
                              pchar( Param2 ),    // TipoAcrescimoDesconto (Valores validos : % ou $)
                              pchar( Param3 ) );  // Valor AcrescimoDesconto (14 por valor ou 4 percentual)
                     //
                     iRetorno := Retorno_Impressora('TotalCupom',iRetorno);
                End; //
                //
                3:begin  // Sweda
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // AcresDesc: STRING = "A" para acr�scimo. STRING = "D" para  desconto.
                          // TipoAcresDesc: STRING = "$'  para valor. STRING = "%" para percentual.
                          // ValAcresDesc:  STRING    at� 14  d�gitos para acr�scimo  ou desconto por valor ou 4 d�gitos para acr�scimo ou desconto em percentual. Se o ponto e a v�rgula forem informados no valor eles ser�o ignorados.
                          iRetorno := uSweda.ECF_IniciaFechamentoCupom(
                              pchar( Param1 ),    // Acrescimo/Desconto (Valores validos : A ou D)
                              pchar( Param2 ),    // TipoAcrescimoDesconto (Valores validos : % ou $)
                              pchar( Param3 ) );  // Valor AcrescimoDesconto (14 por valor ou 4 percentual)
                      //
                      iRetorno := Retorno_Impressora('TotalCupom',iRetorno);
                End;
                4:begin  // Elgin
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_IniciaFechamentoCupom(
                              pchar( Param1 ),    // Acrescimo/Desconto (Valores validos : A ou D)
                              pchar( Param2 ),    // TipoAcrescimoDesconto (Valores validos : % ou $)
                              pchar( Param3 ) );  // Valor AcrescimoDesconto (14 por valor ou 4 percentual)
                      iRetorno := Retorno_Impressora('TotalCupom',iRetorno);
                  End;
                5:begin  // Mecaf
                      // Total sem desconto e acrescimo
                      Fillchar(sDesc2,30,0);
                      Fillchar(sPercVl,2,0);
                      Fillchar(sAcreDesc,2,0);
                      Fillchar(sValor,17,0);
                      if (Param1 = 'D') then
                          begin
                            Param1 := '1';
                            StrPCopy(sDesc2,'Desconto');
                          end
                      else
                          begin
                            Param1 := '0';
                            StrPCopy(sDesc2,'Acrescimo');
                          end;

                      if (Param2 = '$') then
                          Param2 := '1'
                      else
                          Param2 := '0';

                      DecimalSeparator := '.';
                      Param3 := copy(Param3,1,11)+'.'+copy(Param3,12,2);
                      StrPCopy(sValor,FloatToStrf(StrtoFloat(Param3), fffixed, 16,2));
                      StrPCopy(sAcreDesc,Param1);
                      StrPCopy(sPercVl,Param2);
                      if (StrtoFloat(Param3) > 0) then
                          begin
                              iRetorno := uMecaf.AFRAC_AcrescimoDescontoCupom(
                                          sAcreDesc,          // define se ser� dado desconto ou acr�scimo
                                          sPercVl,            // define se o acr�scimo ou desconto ser� por valor ou percentual
                                          SValor,             // valor do acr�scimo ou desconto
                                          sDesc2);            // texto complementar
                              if (iRetorno = 0) then
                                  begin
                                    FillChar(sAcre,31,0);
                                    FillChar(sDesc,31,0);
                                    FillChar(sDescr,31,0);
                                    //
                                    StrPCopy(sDesc, 'Desconto');
                                    StrPCopy(sAcre, 'Acrescimo');
                                    StrPCopy(sDescr, sDesc + sAcre);
                                    //
                                    iRetorno := uMecaf.AFRAC_FecharAcrescimoDesconto(sDesc, sAcre, sDescr);
                                    uMecaf.Ret(iRetorno,'AFRAC_FecharAcrescimoDesconto');
                                    if (iRetorno = 0) then
                                      iRetorno := 1
                                    else
                                      iRetorno := 0;
                                  end
                              else
                                  begin
                                    uMecaf.Ret(iRetorno,'AFRAC_AcrescimoDescontoCupom');
                                    iRetorno := 0;
                                  end;
                          end
                      else
                         iRetorno :=1;
                   End;
                   //
                   6:begin       // Urano
                          {Par�metros
                        	Variavel:	Cancelar
                        	TipoDado:	bool	Tamanho M�ximo:		Obrigat�rio
                        	Descricao:	Indicador de cancelamento da opera��o.Se este par�metro for informado (='true'), cancela o
                        	�ltimo desconto/acr�scimo de subtotal informado. Este par�metro tem preced�ncia sobre os demais neste comando.
                        	Variavel:	ValorAcrescimo
                        	TipoDado:	money	Tamanho M�ximo:		Opcional
                        	Descricao:	Valor do desconto (quando negativo) ou acr�scimo (quando positivo).Este par�metro tem
                        	preced�ncia sobre o <ValorPercentual> se informado.
                        	Variavel:	ValorPercentual
                        	TipoDado:	money	Tamanho M�ximo:		Opcional
                        	Descricao:	Percentual de desconto (quando negativo) ou acr�scimo (quando positivo), com precis�o m�xima
                        	 de 2 casas decimais. Esta opera��o � realizada sobre o subtotal (l�quido) do cupom. Este
                        	par�metro ser� desconsiderado quando usado em conjunto com o par�metro <ValorAcrescimo>.}
                          //
                          If StrtoInt(Param3) > 0 Then
                          begin
                            Param3 := copy(Param3,1,11)+','+copy(Param3,12,2);
                            if (Param1 = 'D') then
                               Param3 := '-'+Param3;
                            //
                            if (Param2 = '$') then
                                iRetorno := uUrano.AcresceSubtotal(nPorta, 'False', Param3, '0')
                            Else
                                iRetorno := uUrano.AcresceSubtotal(nPorta, 'False', '0', Param3);
                            //
                            frmMainEcFG2.TrataErro(iRetorno);
                                {pchar( Param1 ),    // Acrescimo/Desconto (Valores validos : A ou D)
                                pchar( Param2 ),    // TipoAcrescimoDesconto (Valores validos : % ou $)
                                pchar( Param3 ) );  // Valor AcrescimoDesconto (14 por valor ou 4 percentual)}
                            //
                            if (iRetorno = 0) then
                               iRetorno := 1;
                           End
                           Else
                           begin
                               {iRetorno := uUrano.AcresceSubtotal(nPorta, 'False', Param3, '0');
                               frmMainEcFG2.TrataErro(iRetorno);}
                               iRetorno := 1;
                           End;
                   End;
             end;
        end;
      If (Comando = 'Pagamento') Then
        begin
             case modelo of
                1:begin  // bematech
                      // Verifica Impressora
                      Param2 := copy(Param2,1,16);
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uBematech.Bematech_FI_EfetuaFormaPagamento(
                                    pchar( Param2 ),    // forma de pagamento com no m�ximo 16 caracteres.
                                    pchar( Param3 ) );  // valor da forma de pagamento com at� 14 d�gitos.
                      iRetorno := Retorno_Impressora('Pagamento',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                2:begin  //daruma
                      // Verifica Impressora
                      Param2 := copy(Param2,1,16);
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_EfetuaFormaPagamento(
                                    pchar( Param2 ),    // forma de pagamento com no m�ximo 16 caracteres.
                                    pchar( Param3 ) );  // valor da forma de pagamento com at� 14 d�gitos.
                      //
                      iRetorno := Retorno_Impressora('Pagamento',iRetorno);
                End;
                    //
                3:begin  //sweda
                    // Verifica Impressora
                    iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                    Param2 := copy(Param2,1,15);
                    If (iRetorno = 1) Then
                        // FormaPag: STRING   com o nome da forma de pagamento at� 15 caracteres.
                        // ValorFPag: STRING   com o valor da forma de pagamento at� 14 d�gitos. Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                        iRetorno := uSweda.ECF_EfetuaFormaPagamento(
                                 pchar( Param2 ),    // forma de pagamento com no m�ximo 15 caracteres.
                                 pchar( Param3 ) );  // valor da forma de pagamento com at� 14 d�gitos.
                   //
                   iRetorno := Retorno_Impressora('Pagamento',iRetorno);
                End;
                //
                4:begin  // Elgin
                      // Verifica Impressora
                      Param2 := copy(Param2,1,16);
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_EfetuaFormaPagamento(
                                    pchar( Param2 ),    // forma de pagamento com no m�ximo 16 caracteres.
                                    pchar( Param3 ) );  // valor da forma de pagamento com at� 14 d�gitos.
                      iRetorno := Retorno_Impressora('Pagamento',iRetorno);
                End;
                5:begin   //Mecaf
                       Param2 := copy(Param2,1,16);             // sDescr, sIndice,
                       //
                       FillChar(sValor,17,0);
                       FillChar(sDescr,31,0);
                       FillChar(sMsg,81,0);
                       FillChar(sIndice,3,0);
                       //
                       Param3 := copy(Param3,1,12)+'.'+copy(Param3,13,2);
                       //
                       StrPCopy(sValor, FloatToStrf(StrtoFloat(Param3), fffixed, 16, 2));
                       StrPCopy(sDescr, Param2);
                       //StrPCopy(sMsg, 'Pagamento no indice ' + Param1 );
                       if (strtoFloat(Param1) > 0) then
                          StrPCopy(sIndice, Param1);
                       //
                       iRetorno := uMecaf.AFRAC_FormaPagamento(
                                      sDescr,        // descforma= texto que descreve a forma de pagamento. Deve estar registrado no ECF
                                      sIndice,       // Indice=Indice da posi��o da forma de pagamento.
                                      sValor,        // valor = valor da forma de pagamento informada
                                      sMsg);         // msg = mensagem complementar a forma de pagamento
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
                //
                6:begin       // Urano
                       {Par�metros
                     	Variavel:	CodMeioPagamento
                     	TipoDado:	byte	Tamanho M�ximo:		Opcional
                     	Descricao:	�ndice do meio de pagamento, sendo -2 ou um valor no intervalo entre 0 (zero) e
                     	NUM_MEIOS_PAGAMENTO, onde: -2 representa o meio de pagamento pr�-definido como
                     	"Dinheiro"; qualquer valor do intervalo representa o �ndice do meio de pagamento
                     	program�vel.Este par�metro tem preced�ncia sobre o par�metro <NomeFormaPagamento>.
                     	Variavel:	NomeMeioPagamento
                     	TipoDado:	string	Tamanho M�ximo:	16	Opcional
                     	Descricao:	Nome do meio de pagamento.
                     	Variavel:	TextoAdicional
                     	TipoDado:	string	Tamanho M�ximo:	80	Opcional
                     	Descricao:	Texto adicional explicativo referente a opera��o.
                     	Variavel:	Valor
                     	TipoDado:	money	Tamanho M�ximo:		Obrigat�rio
                     	Descricao:	Valor da opera��o.Indica o montante pago com o meio de pagamento informado.}
                      // Verifica Impressora
                      Param2 := uFuncoes.Alltrim(copy(Param2,1,16));
                      Param3 := InttoStr(StrtoInt(copy(Param3,1,12)))+','+copy(Param3,13,2);
                      {iRetorno := uUrano.PagaCupom(
                                    pchar( Param2 ),    // forma de pagamento com no m�ximo 16 caracteres.
                                    pchar( Param3 ) );  // valor da forma de pagamento com at� 11 d�gitos.}
                      iRetorno := 0;
                      //
                      //
                      try
                         uUrano.DLLG2_LimpaParams(0);
                         //
                         If (UpperCase(Param2) = 'DINHEIRO') Then
                          begin
                               Param1 := '-2';
                               Param2 := 'Dinheiro';
                               uUrano.DLLG2_AdicionaParam(0, 'CodMeioPagamento', Param1, 4);
                          End;
                         //
                         uUrano.DLLG2_AdicionaParam(0, 'NomeMeioPagamento', Param2, 7);
                         uUrano.DLLG2_AdicionaParam(0, 'Valor', Param3, 6);
                         iRetorno := uUrano.DLLG2_ExecutaComando(0, 'PagaCupom');
                         frmMainEcFG2.TrataErro(iRetorno);
                      Except
                         frmMainEcFG2.TrataErro(iRetorno);
                      End;
                End;
             End; //fim-caso
        End;  //fim - Pagamento
        //
      If (Comando = 'FecharCupom') Then
        begin
             case modelo of
                1:begin  // bematech
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uBematech.Bematech_FI_TerminaFechamentoCupom(
                                  pchar( Param1+Param2+Param3 ) );  // STRING com a mensagem promocional com
                                                      //at� 384 caracteres (8 linhas X 48 colunas),
                                                      //para a impressora fiscal MP-20 FI II, e
                                                      //320 caracteres (8 linhas X 40 colunas),
                                                      //para a impressora fiscal MP-40 FI II.
                      iRetorno := Retorno_Impressora('FecharCupom',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                 End;
                 //
                 2:begin   //daruma
                     iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.daruma_FI_TerminaFechamentoCupom(
                                  pchar( Param1+Param2+Param3 ) );  // STRING com a mensagem promocional com
                                                      //at� 384 caracteres (8 linhas X 48 colunas),
                                                      //para a impressora fiscal MP-20 FI II, e
                                                      //320 caracteres (8 linhas X 40 colunas),
                                                      //para a impressora fiscal MP-40 FI II.
                       iRetorno := Retorno_Impressora('FecharCupom',iRetorno);
                    End;
                 //
                 3:begin  // sweda
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Mensagem: STRING com a mensagem promocional limitada a 8 linhas,
                          iRetorno := uSweda.ECF_TerminaFechamentoCupom(
                                  pchar( Param1+Param2+Param3 ) );  // STRING com a mensagem promocional com
                                                      //at� 384 caracteres (8 linhas X 48 colunas),
                                                      //para a impressora fiscal MP-20 FI II, e
                                                      //320 caracteres (8 linhas X 40 colunas),
                                                      //para a impressora fiscal MP-40 FI II.
                       iRetorno := Retorno_Impressora('FecharCupom',iRetorno);
                    End;
                    //
                4:begin  // Elgin
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uElgin.Elgin_TerminaFechamentoCupom(
                                  pchar( Param1+Param2+Param3 ) );  // STRING com a mensagem promocional com
                                                      //at� 384 caracteres (8 linhas X 48 colunas),
                                                      //para a impressora fiscal MP-20 FI II, e
                                                      //320 caracteres (8 linhas X 40 colunas),
                                                      //para a impressora fiscal MP-40 FI II.
                      iRetorno := Retorno_Impressora('FecharCupom',iRetorno);
                 End;
                 5:Begin    // Mecaf
                         // Fechamento de cupom
                   iRetorno  := uMecaf.AFRAC_FecharCupom('0', Pchar(Param1+Param2+Param3));
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                 End;
                 //
                 6:begin       // Urano
                       {Par�metros
                     	Variavel:	Operador
                     	TipoDado:	string	Tamanho M�ximo:	8	Opcional
                     	Descricao:	Identifica��o do operador.
                     	Variavel:	TextoPromocional
                     	TipoDado:	string	Tamanho M�ximo:	492	Opcional
                     	Descricao:	Texto da mensagem promocional a ser impressa.O caracter ASCII 10 ('\n' ou line feed) �
                     	interpretado como separador de linhas do texto promocional. }
                       iRetorno := uUrano.EncerraDocumento(nPorta, ' ', Param1+Param2+Param3);
                       frmMainEcFG2.TrataErro(iRetorno);
                       //
                       if (iRetorno = 0) then
                        begin
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
                 End;

            End;  //fim-caso
        End;  // fim-FecharCupom
        //
       If (Comando = 'NumeroCupom') Then
         begin
             case modelo of
                1:begin  // bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      NumeroCupom := uFuncoes.Replicate(' ',6);
                      If (iRetorno = 1) Then
                           iRetorno := uBematech.Bematech_FI_NumeroCupom( NumeroCupom );
                      //iRetorno := Retorno_Impressora('NumeroCupom',iRetorno);
                      mRetorno := Retorno_Impressora('NumeroCupom',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                     // aMensagem := mRetorno;
                End;
                //
                2:begin   //daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      NumeroCupom := uFuncoes.Replicate(' ',6);
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_NumeroCupom( NumeroCupom );
                      mRetorno := Retorno_Impressora('NumeroCupom',iRetorno);
                End;
                //
                3:begin  //Sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      NumeroCupom := uFuncoes.Replicate(' ',6);
                      If (iRetorno = 1) Then
                           // NumCupom:  STRING com 6 posi��es para receber o n�mero do �ltimo  cupom.    Ele  �  impresso  ap�s  a  legenda �COO: � - Contador de Ordem de Opera��o.
                           iRetorno := uSweda.ECF_NumeroCupom(Pchar(NumeroCupom) );
                      mRetorno := Retorno_Impressora('NumeroCupom',iRetorno);
                 End;
                 //
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      NumeroCupom := uFuncoes.Replicate(' ',6);
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_NumeroCupom( NumeroCupom );
                      //iRetorno := Retorno_Impressora('NumeroCupom',iRetorno);
                      mRetorno := Retorno_Impressora('NumeroCupom',iRetorno);
                     // aMensagem := mRetorno;
                End;
                5:begin   // Mecaf
                     iRetorno := uMecaf.NumeroCupom(NumeroCupom);
                     mRetorno := StrtoInt(NumeroCupom);
                     if (iRetorno = 0) then
                        iRetorno := 1
                      else
                        iRetorno := 0;
                End;
                //
                6:begin       // Urano
                      {Retornos
                    	Variavel:	ValorInteiro
                    	TipoDado:	long	Tamanho M�ximo:		Obrigat�rio
                    	Descricao:	Valor inteiro.
                      Par�metros
                    	Variavel:	NomeInteiro
                    	TipoDado:	string	Tamanho M�ximo:	50	Obrigat�rio
                    	Descricao:	Nome da vari�vel inteira solicitada conforme anexo � especifica��o do protocolo.Quando este
                    	par�metro referenciar um vetor, o �ndice do vetor deve ser identificado entre colchetes '[]' ap�s o nome. }
                      iRetorno := uUrano.LeInteiro(nPorta, 'COO', NumeroCupom);
                      frmMainEcFG2.TrataErro(iRetorno);
                      if (iRetorno = 0) then
                            iRetorno := 1;
                End;
             End;     //fim-caso
         End;  // fim-NumeroCupom
         //
       If (Comando = 'AbreComprovanteNaoFiscalVinculado') Then
         begin
             case modelo of
                1:begin  // bematech
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      Param1   := copy(Param1,1,16);
                      If (iRetorno = 1) Then
                           iRetorno := uBematech.Bematech_FI_AbreComprovanteNaoFiscalVinculado(pchar( Param1 ),pchar(''),pchar(''));
                      iRetorno := Retorno_Impressora('AbreComprovanteNaoFiscalVinculado',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                2:begin   // daruma
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      Param1   := copy(Param1,1,16);
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_AbreComprovanteNaoFiscalVinculado(pchar( Param1 ),pchar(''),pchar(''));
                    End;
                3:begin  // sweda
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      Param1   := copy(Param1,1,15);
                      If (iRetorno = 1) Then
                           iRetorno := uSweda.ECF_AbreComprovanteNaoFiscalVinculado(pchar( Param1 ),pchar(''),pchar(''));
                End;
                4:begin  // Elgin
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      Param2 := uFuncoes.StrZero(Param2,13);
                      //
                      Param1 := copy(Param1,1,16);
                      Param2 := InttoStr(StrtoInt(copy(Param2,1,11)))+','+copy(Param2,12,2);
                      //
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_AbreComprovanteNaoFiscalVinculado(pchar( Param1 ), pchar( Param2 ),pchar(''));
                End;
                5:begin     // mecaf
                       {Descri��o: Abre N�o fiscal n�o Vinculado
                       Observa��o: Em algumas impressoras n�o ter� efeito de impress�o. Esta impress�o ser�
                       contemplada na informa��o do valor na fun��o AFRAC_RegistrarN�oFiscal
                       NOME ANTIGO: AFRAC_Sangria(nome_totalizador: ttexto[20];
                       valor: tpontoflutuante;
                       mensagem: ttexto[255] ): inteiro   }
                       iRetorno := uMecaf.AFRAC_AbrirNaoFiscalNaoVinculado();
                       if (iRetorno = 0) then
                         iRetorno := 1
                       else
                          iRetorno := 0;
                End;
                //
                   6:begin       // Urano
                         {Par�metros
                       	Variavel:	EnderecoConsumidor
                       	TipoDado:	string	Tamanho M�ximo:	80	Opcional
                       	Descricao:	Endere�o do consumidor.
                       	Variavel:	IdConsumidor
                       	TipoDado:	string	Tamanho M�ximo:	29	Opcional
                       	Descricao:	Identifica��o do consumidor.
                       	Variavel:	NomeConsumidor
                       	TipoDado:	string	Tamanho M�ximo:	30	Opcional
                       	Descricao:	Nome do consumidor. }
                        Param1   := uFuncoes.Alltrim(copy(Param1,1,16));
                        //
                        try
                            // iRetorno := uUrano.AbreCupomNaoFiscal(nPorta, Param1, ' ', ' ');
                            uUrano.DLLG2_LimpaParams(0);
                            //valores opcionais, mas se declarados n�o podem ser deixados em branco
                            {uUrano.DLLG2_AdicionaParam(0, 'COO', edit17.Text, 100);
                            uUrano.DLLG2_AdicionaParam(0, 'NumParcelas', edit18.Text, 10);
                            uUrano.DLLG2_AdicionaParam(0, 'Valor', edit20.Text, 6);}
                            If not uFuncoes.Empty(Param1) Then
                               uUrano.DLLG2_AdicionaParam(0, 'NomeMeioPagamento', Param1, 7);
                            //
                            iRetorno := uUrano.DLLG2_ExecutaComando(0, 'AbreCreditoDebito');
                            frmMainEcFG2.TrataErro(iRetorno);
                            //
                            if (iRetorno = 0) then
                               iRetorno := 1;
                        Except
                             frmMainEcFG2.TrataErro(iRetorno);
                        End;
                        //
                   End;

           End;  //fim-caso
         End;       // fim-AbreComprovanteNaoFiscalVinculado
      //
      If (Comando = 'UsaComprovanteNaoFiscalVinculado') Then
      begin
             case modelo of
                1:begin  // bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uBematech.Bematech_FI_UsaComprovanteNaoFiscalVinculado(pchar( aTextoTef ));
                      iRetorno := Retorno_Impressora('UsaComprovanteNaoFiscalVinculado',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                2:begin  //daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          iRetorno := uDaruma.Daruma_FI_UsaComprovanteNaoFiscalVinculado(pchar( aTextoTef ));
                  End;
                3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           // Texto: STRING com o texto a ser impresso no comprovante n�o fiscal vinculado com at� 618 caracteres.
                           iRetorno := uSweda.ECF_UsaComprovanteNaoFiscalVinculado(pchar( aTextoTef ));
                 End;
                 //
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_UsaComprovanteNaoFiscalVinculado(pchar( aTextoTef ));
                      iRetorno := Retorno_Impressora('UsaComprovanteNaoFiscalVinculado',iRetorno);
                End;
                5: begin
                      {Quando enviado este comando, o ECF deve imprimir a linha.
                      A segunda linha (opcional) para otimizar a impress�o bidirecional.
                      Se n�o for poss�vel imprimir o conte�do da linha enviada em uma �nica linha
                      do ECF, o restante do texto deve ser impresso na pr�xima linha.}
                      iRetorno := uMecaf.AFRAC_ImprimirVinculado(
                                pchar( aTextoTef ),      // linha1: ttexto[48]; - Linha1 = linha a ser impressa no cupom n�o fiscal vinculado
                                pchar( Param1 ));        // linha2: ttexto[48]; - Linha2 = Opcional, segunda linha a ser impressa.
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
                //
                6:begin       // Urano
                       //
                       DLLG2_LimpaParams(nPorta);
                       dLLG2_AdicionaParam(nPorta,'TextoLivre' , PChar(aTextoTef) ,7);
                       iRetorno := uUrano.DLLG2_ExecutaComando(nPorta,'ImprimeTexto');
                       frmMainEcFG2.TrataErro(iRetorno);
                       if (iRetorno = 0) then
                        begin
                           iRetorno := 1;
                           //   nova alteracao
                           {iRetorno := uUrano.DLLG2_ExecutaComando(nPorta,'EmiteViaCreditoDebito');
                           frmMainEcFG2.TrataErro(iRetorno);
                           //
                           if (iRetorno = 0) then
                               iRetorno := 1
                           Else
                               iRetorno := 0;}
                        End
                       else
                          iRetorno := 0;
                End;
             End;  // fim-caso
      End;   // fim-UsaComprovanteNaoFiscalVinculado
      //
      If (Comando = 'FechaComprovanteNaoFiscalVinculado') Then
        begin
             case modelo of
                1:begin  // bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uBematech.Bematech_FI_FechaComprovanteNaoFiscalVinculado();
                      iRetorno := Retorno_Impressora('FechaComprovanteNaoFiscalVinculado',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                //
                2:begin  // daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_FechaComprovanteNaoFiscalVinculado();
                 End;
                3:begin   //sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uSweda.ECF_FechaComprovanteNaoFiscalVinculado();
                 End;
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_FechaComprovanteNaoFiscalVinculado();
                      iRetorno := Retorno_Impressora('FechaComprovanteNaoFiscalVinculado',iRetorno);
                End;
                5:Begin
                      {O ECF somente poder� retornar sucesso se todas as linhas foram impressas.
                      Esta fun��o tamb�m dever� limpar os dados armazenados atrav�s das
                      fun��es AFRAC_007 a AFRAC_014.}
                      iRetorno := uMecaf.AFRAC_FecharVinculado();
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
                //
                6:begin
                      // Urano
                      DLLG2_LimpaParams(nPorta);
                      iRetorno := uUrano.DLLG2_ExecutaComando(nPorta,'EncerraDocumento');
                      frmMainEcFG2.TrataErro(iRetorno);
                      if (iRetorno = 0) then
                       begin
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
                       End
                      else
                         iRetorno := 0;
                End;

             End; // fim-caso
        End;
      //
      If (Comando = 'AbreRelatorioGerencial') Then
      begin
             case modelo of
                1:begin  // bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                           // aqui
                           If uFuncoes.Empty(Param1) Then
                               Param1 := '5';
                           iRetorno := uBematech.Bematech_FI_AbreRelatorioGerencialMFD(pchar(Param1));
                           uBematech.Analisa_iRetorno;
                           //
                           aMensagem := uBematech.aMensagem;
                       End;
                End;
                2:begin   // daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_AbreRelatorioGerencial();
                End;
                3:begin   //sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           // Texto: STRING com o texto a ser impresso no relat�rio at� 618 caracteres.
                           iRetorno := uSweda.ECF_AbreRelatorioGerencialMFD(pchar(''));
                End;
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      // Abre o primeiro Relat�rio Gerencial localizado, imprimindo seu cabe�alho e nome.
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_AbreRelatorioGerencial;
                End;
                5:begin    // Mecaf
                      {Para o conv�nio 156, o campo �ndice dever� ser preenchido com caracteres
                      em branco, ou nulos.}
                      // �ndice = �ndice do relat�rio gerencial, indicando o tipo do relat�rio (Conv�nio 50).
                      iRetorno := uMecaf.AFRAC_AbrirRelatorioGerencial(PChar(Param1));
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
                //
                6:begin       // Urano
                       {Par�metros
                     	Variavel:	CodGerencial
                     	TipoDado:	byte	Tamanho M�ximo:		Opcional
                     	Descricao:	�ndice do relat�rio gerencial entre 0 e NUM_GERENCIAIS.Este par�metro tem preced�ncia a
                     	<NomeGerencial>.
                     	Variavel:	NomeGerencial
                     	TipoDado:	string	Tamanho M�ximo:	30	Opcional
                     	Descricao:	Nome do relat�rio gerencial.}
                      uUrano.dLLG2_LimpaParams(nPorta);
                      uUrano.dLLG2_AdicionaParam(nPorta,'CodGerencial' , Param1,4);
                      //
                      iRetorno := uUrano.DLLG2_ExecutaComando(nPorta,'AbreGerencial');
                      frmMainEcFG2.TrataErro(iRetorno);
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;  
                End;
                //
              End;    // fim-caso
      End;

      If (Comando = 'RelatorioGerencial') Then
      begin
             case modelo of
                1:begin  // bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                       begin
                           iRetorno := uBematech.Bematech_FI_RelatorioGerencial(pchar( aTextoTef ));
                           uBematech.Analisa_iRetorno;
                           //
                           aMensagem := uBematech.aMensagem;
                       End;
                End;
                2:begin   // daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_RelatorioGerencial(pchar( aTextoTef ));
                End;
                3:begin   //sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           // Texto: STRING com o texto a ser impresso no relat�rio at� 618 caracteres.
                           iRetorno := uSweda.ECF_RelatorioGerencial(pchar( aTextoTef ));
                End;
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_RelatorioGerencial(pchar( aTextoTef ));
                End;
                5:begin    // Mecaf
                      // Imprime uma linha no relat�rio gerencial
                      iRetorno := uMecaf.AFRAC_ImprimirRelatorioGerencial(PChar(aTextoTef));  // linha = linha a ser impressa na relat�rio gerencial - linha: ttexto[160]
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
                //
                6:begin       // Urano
                       dLLG2_AdicionaParam(nPorta,'TextoLivre' , aTextoTef ,7);
                       iRetorno := uUrano.DLLG2_ExecutaComando(nPorta,'ImprimeTexto');
                       frmMainEcFG2.TrataErro(iRetorno);
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
                //
              End;    // fim-caso
      End;
      //
      If (Comando = 'FechaRelatorioGerencial') Then
       begin
             case modelo of
                1:begin  // bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uBematech.Bematech_FI_FechaRelatorioGerencial();
                      iRetorno := Retorno_Impressora('FechaRelatorioGerencial',iRetorno);
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                2:begin   // daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uDaruma.Daruma_FI_FechaRelatorioGerencial();
                End;
                3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uSweda.ECF_FechaRelatorioGerencial();
                End;
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           iRetorno := uElgin.Elgin_FechaRelatorioGerencial();
                End;
                5:begin    // Mecaf
                      // Finaliza o relat�rio gerencial
                      iRetorno := uMecaf.AFRAC_FecharRelatorioGerencial();
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
                //
                6:begin       // Urano
                     iRetorno := uUrano.DLLG2_ExecutaComando(nPorta,'EncerraDocumento');
                     frmMainEcFG2.TrataErro(iRetorno);
                      if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;
                End;
             End; // fim-case
        End;
      //
      If (Comando = 'LeituraMemoriaFiscalReducao') Then
        begin
             case modelo of
                1:begin  // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // CRZInic: STRING com o n�mero da redu��o inicial at� 4 d�gitos.
                          //  CRZFim: STRING com o n�mero da redu��o final at� 4 d�gitos.
                          iRetorno := uBematech.Bematech_FI_LeituraMemoriaFiscalReducao(pchar(param1), pchar(param2));
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                //
                2:begin  // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // CRZInic: STRING com o n�mero da redu��o inicial at� 4 d�gitos.
                          //  CRZFim: STRING com o n�mero da redu��o final at� 4 d�gitos.
                          iRetorno := uDaruma.Daruma_FI_LeituraMemoriaFiscalReducao(pchar(param1), pchar(param2));
                End;
                //
                3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // CRZInic: STRING com o n�mero da redu��o inicial at� 4 d�gitos.
                          //  CRZFim: STRING com o n�mero da redu��o final at� 4 d�gitos.
                           iRetorno := uSweda.ECF_LeituraMemoriaFiscalReducao(pchar(param1), pchar(param2));
                End;
                //
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // CRZInic: STRING com o n�mero da redu��o inicial at� 4 d�gitos.
                          //  CRZFim: STRING com o n�mero da redu��o final at� 4 d�gitos.
                          iRetorno := uElgin.Elgin_LeituraMemoriaFiscalReducao(pchar(param1), pchar(param2) , pchar('c'));
                End;
                5:begin     //Mecaf
                       {Se tipo for 0, o intervalo inicio e final � ignorado. Se for por data, deve ser no
                       formato ddmmaaaa. Se for por redu��o, deve ser n�meros com zeros �
                       esquerda.}
                       iRetorno := uMecaf.AFRAC_EmitirLeituraMemoriaFiscal('2', pchar(param1), pchar(param2));
                       if (iRetorno = 0) then
                          iRetorno := 1
                       else
                          iRetorno := 0;
                End;
                //
                6:begin       // Urano
                     if (iRetorno = 0) then
                         iRetorno := 1
                      else
                         iRetorno := 0;

                End;
             End;
        End;         // fim-LeituraMemoriaFiscalReducao
     //
     if  (Comando = 'Sangria') Then
      begin
             case modelo of
                1:begin  // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor: STRING com o Valor da sangria com at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                           iRetorno := uBematech.Bematech_FI_Sangria(pchar(param1));
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                2:begin  // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor: STRING com o Valor da sangria com at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                           iRetorno := uDaruma.Daruma_FI_Sangria(pchar(param1));
                End;
                3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor: STRING com o Valor da sangria com at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                           iRetorno := uSweda.ECF_Sangria(pchar(param1));
                End;
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor: STRING com o Valor da sangria com at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                           iRetorno := uElgin.Elgin_Sangria(pchar(param1));
                End;
                5:begin     // mecaf
                     iRetorno := 0;
                End;
                //
                6:begin       // Urano
                     iRetorno := 0;
                End;
             End;
      End;
      //
      if (Comando = 'Suprimento') Then
        begin
             case modelo of
                1:begin  // Bematech
                      // Verifica Impressora
                      iRetorno := uBematech.Bematech_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor:  STRING   com o Valor do suprimento at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                          // FormaPag:  STRING   com o nome do meio de pagamento at� 15 caracteres. Se o nome da forma de pagamento n�o for informado, o suprimento ser� feito em Dinheiro.
                           iRetorno := uBematech.Bematech_FI_Suprimento(pchar(Param1), pchar(Param2));
                      uBematech.Analisa_iRetorno;
                      //
                      aMensagem := uBematech.aMensagem;
                End;
                2:begin  // Daruma
                      // Verifica Impressora
                      iRetorno := uDaruma.Daruma_FI_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor:  STRING   com o Valor do suprimento at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                          // FormaPag:  STRING   com o nome do meio de pagamento at� 15 caracteres. Se o nome da forma de pagamento n�o for informado, o suprimento ser� feito em Dinheiro.
                           iRetorno := uDaruma.Daruma_FI_Suprimento(pchar(Param1), pchar(Param2));
                End;
                3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor:  STRING   com o Valor do suprimento at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                          // FormaPag:  STRING   com o nome do meio de pagamento at� 15 caracteres. Se o nome da forma de pagamento n�o for informado, o suprimento ser� feito em Dinheiro.
                           iRetorno := uSweda.ECF_Suprimento(pchar(Param1), pchar(Param2));
                End;
                4:begin  // Elgin
                      // Verifica Impressora
                      iRetorno := uElgin.Elgin_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                          // Valor:  STRING   com o Valor do suprimento at� 14 d�gitos (duas casas decimais). Se o ponto e a v�rgula forem informados no valor eles ser�o  ignorados.
                          // FormaPag:  STRING   com o nome do meio de pagamento at� 15 caracteres. Se o nome da forma de pagamento n�o for informado, o suprimento ser� feito em Dinheiro.
                           iRetorno := uElgin.Elgin_Suprimento(pchar(Param1), pchar(Param2));
                End;
                5:begin   // Mecaf
                      iRetorno := 0;
                End;
                //
                6:begin       // Urano
                      iRetorno := 0;
                End;
             End;
        End;
       //
      //
      if (Comando = 'ProgramaFormasPagamento') Then
        begin
             case modelo of
                1:begin  // Bematech
                      iRetorno := 1;
                End;
                2:begin  // Daruma
                      iRetorno := 1;
                End;
                3:begin  // sweda
                      // Verifica Impressora
                      iRetorno := uSweda.ECF_VerificaImpressoraLigada();
                      If (iRetorno = 1) Then
                           // Inclui v�rias formas de pagamento.
                           // TabFormaPag:  STRING   onde   s�o   informados   o   nome de
                           // cada  forma   de  pagamento  separada  por v�rgula ou
                           // PONTO-E-V�RGULA. O nome deve ter at� 16 caracteres.
                           iRetorno := uSweda.ECF_ProgramaFormasPagamento( pchar(Param1));
                End;
                4:begin  // Elgin
                      iRetorno := 1;
                End;
                5:begin   // Mecaf
                      iRetorno := 0;
                End;
                //
                6:begin       // Urano
                       {Retornos
	                     Variavel:	CodMeioPagamentoProgram
                     	TipoDado:	byte	Tamanho M�ximo:		Obrigat�rio
                     	Descricao:	�ndice do meio de pagamento program�vel entre 0 (zero) e NUM_MEIOS_PAGAMENTO.Retorna o
                     	�ndice do meio de pagamento programado.
                      Par�metros
                     	Variavel:	CodMeioPagamentoProgram
                     	TipoDado:	byte	Tamanho M�ximo:		Opcional
                     	Descricao:	�ndice do meio de pagamento program�vel entre 0 (zero) e NUM_MEIOS_PAGAMENTO.Identifica o
                     	meio de pagamento a ser definido ou redefinido. Quando n�o informado, procura pelo pr�ximo
                     	�ndice dispon�vel.
                     	Variavel:	DescricaoMeioPagamento
                     	TipoDado:	string	Tamanho M�ximo:	80	Opcional
                     	Descricao:	Texto associado a este meio de pagamento em particular. De livre uso do programa aplicativo.
                     	Variavel:	NomeMeioPagamento
                     	TipoDado:	string	Tamanho M�ximo:	16	Obrigat�rio
                     	Descricao:	Nome do meio de pagamento.Identifica o nome do meio de pagamento sempre que o par�metro
                     	<CodMeioPagamentoProgram> n�o for informado.
                     	Variavel:	PermiteVinculado
                     	TipoDado:	bool	Tamanho M�ximo:		Opcional
                     	Descricao:	Informa se permite a emiss�o de cupons cr�dito/d�bito relativos ao meio de pagamento
                     	definido.Se este campo n�o for informado neste comando, seu valor ser� definido ap�s a
                     	primeira utiliza��o do respectivo meio de pagamento.}
                      //iRetorno := uUrano.DefineMeioPagamento(nPorta, 'T', ' ', Param1, ' ');
                End;
             End;
        End;
      // retorno
      result := iRetorno;
End;

// **********************************************************************
// -------------------- Analisa Retorno da impressora ---------------------
function Retorno_Impressora( nComando : String; iRetorno : integer) : Integer;
Var
   iACK, iST1, iST2: Integer;
   Status, strErroMsg : String;
   //strErroMsg : char;
Begin
    aStatus := 'OK';
    result  := iRetorno;
    //
    if (iRetorno = 1) then
       begin
         iACK := 0; iST1 := 0; iST2 := 0;
         result := 0;
         //
         Case uPrincipalECFG2.M_CDMODE of
            1: uBematech.Bematech_FI_RetornoImpressora(iACK, iST1, iST2);  // Bematech
            2: uDaruma.Daruma_FI_RetornoImpressora(iACK, iST1, iST2);      // daruma
            3: uSweda.ECF_RetornoImpressora(iACK, iST1, iST2);             // sweda
            4: begin                                                       // Elgin
               iACK := 6; iST1 := 0; iST2 := 0;
               end;
            5:begin                                                        // Mecaf
               //uMecaf
            End;
         End;
         //
         if (iACK = 6) and (iST1 = 0) and (iST2 = 0) then
            result :=1
         else
            result :=0;

         If iACK = 6 then                    // Byte indicativo de Recebimento Correto.
         Begin
               // Verifica ST1

               IF iST1 >= 128 Then
                    Begin
                    iST1 := iST1 - 128;
                    aMensagem := 'Fim de Papel!!!'+ nComando ;
               END;
               IF iST1 >= 64  Then
               begin
                    iST1 := iST1 - 64;
                    aMensagem := 'Pouco Papel!!! '+nComando;
               End;
               IF iST1 >= 32  Then
               Begin
                    iST1 := iST1 - 32;
                    aMensagem := 'Erro no Rel�gio!!! '+nComando;
               End;
               IF iST1 >= 16  Then
               Begin
                    iST1 := iST1 - 16;
                    aMensagem := 'Impressora em ERRO!!! '+nComando;
               End;
               IF iST1 >= 8   Then
               Begin
                    iST1 := iST1 - 8;
                    aMensagem := 'CMD n�o iniciado com ESC!!! '+nComando;
               End;
               IF iST1 >= 4   Then
               Begin
                     iST1 := iST1 - 4;
                     aMensagem := 'Comando Inexistente!!! '+nComando;
               End;
               IF iST1 >= 2   Then
               Begin
                    iST1 := iST1 - 2;
                    aMensagem := 'Cupom Aberto!!! '+nComando;
               End;
               IF iST1 >= 1   Then
               Begin
                    iST1 := iST1 - 1;
                    aMensagem := 'N� de Par�metros Inv�lidos!!! '+nComando;
              End;

               // Verifica ST2

               IF iST2 >= 128 Then
               Begin
                    iST2 := iST2 - 128;
                    aMensagem := 'Tipo de Par�metro Inv�lido!!! '+nComando;
               End;
               IF iST2 >= 64  Then
               Begin
                    iST2 := iST2 - 64;
                    aMensagem := 'Mem�ria Fiscal Lotada!!! '+nComando;
               END;
               IF iST2 >= 32  Then
               Begin
                    iST2 := iST2 - 32;
                    aMensagem := 'CMOS n�o Vol�til!!! '+nComando;
               END;
               IF iST2 >= 16  Then
               Begin
                    iST2 := iST2 - 16;
                    aMensagem := 'Al�quota N�o Programada!!! '+nComando;
               END;
               IF iST2 >= 8   Then
               Begin
                    iST2 := iST2 - 8;
                    aMensagem := 'Al�quota lotadas!!! '+nComando;
               End;
               IF iST2 >= 4   Then
               Begin
                    iST2 := iST2 - 4;
                    aMensagem := 'Cancelamento n�o Permitido!!! '+nComando;
               END;
               IF iST2 >= 2   Then
               Begin
                    iST2 := iST2 - 2;
                    aMensagem := 'CGC/IE n�o Programados!!! '+nComando;
               END;
               IF iST2 >= 1   Then
               Begin
                    iST2 := iST2 - 1;
                    aMensagem := Status;
               END;
         End;

         If iACK = 21 Then
            Begin                     // Byte indicativo de Recebimento incorreto.
                 aMensagem := 'Aten��o!!!' + #13 + #10 +
                        'A Impressora retornou NAK. O programa ser� abortado.';
                 Exit;
            End;
          //
          aStatus := aMensagem;
       End
       Else
       begin
         Case uPrincipalECFG2.M_CDMODE of
            1: begin  // bematech
                 aMensagem := 'Erro ao tentar se comunicar com ECF';
                 aStatus := aMensagem;
               end;
            2: begin  // daruma
                 aMensagem := 'Erro ao tentar se comunicar com ECF';
                 aStatus := aMensagem;
               end;
            3: begin // sweda
                 aMensagem := 'Erro ao tentar se comunicar com ECF';
                 aStatus := aMensagem;
               end;
            4: begin  // elgin
                 strErroMsg := StringOfChar(' ',1024);
                 iRetorno := uElgin.Elgin_RetornoImpressora(iACK, strErroMsg);
                 aMensagem := PChar(strErroMsg);
                 aStatus := aMensagem;
               end;
         End;

       End;

end;


end.
