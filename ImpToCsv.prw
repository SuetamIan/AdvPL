#include "totvs.ch"

/*/{Protheus.doc} IMPTOCSV
Exemplo importação de arquivo *.CSV e gravação dos
registros no banco de dados
@type function
@version
@author Marcos Aleluia
@since 12/08/2021
@return variant, return_description
/*/
User Function ImpToCsv()

	Local cDir     	:= "C:\TEMP\"
	Local cArq    	:= "importa.csv"
	Local cLinha  	:= ""
	Local lPrim   	:= .T.
	Local aCampos 	:= {}
	Local aDados  	:= {}
	Local i			:= 0
	// Local j			:= 0

	// Comandos para subir o ambiente do Protheus
	if select("SM0") == 0
		RpcSetType(3)
		RpcSetEnv("99","01")
	endif

	// Olha se o arquivo está na pasta
	If ! File(cDir + cArq)
		MsgStop("O arquivo " +cDir+cArq + " não foi encontrado. A importação será abortada!","[IMPCSV] - ATENCAO")
		Return
	EndIf

	// Abre o arquivo csv
	if FT_FUSE(cDir+cArq) <> -1

		// Regua de processamento
		ProcRegua(FT_FLASTREC())

		// Vai para a primeira linha do arquivo
		FT_FGOTOP()

		// Percorre todas as linhas do arquivo
		While ! FT_FEOF()

			// Exibe mensagem na régua de processamento
			IncProc("Lendo arquivo texto...")

			// Lê a linha do arquivo
			cLinha := FT_FREADLN()

			// Se for a primeira linha então é o cabeçalho
			If lPrim
				aCampos := Separa(cLinha,";",.T.)
				lPrim := .F.
			Else
				AADD(aDados,Separa(cLinha,";",.T.))
			EndIf

			// Vai para a próxima linha do arquivo
			FT_FSKIP()

		EndDo

		// Inicia a transação
		// Begin Transaction

		// Incrementa a régua de processamento
		ProcRegua(Len(aDados))

		// Percorre todos os dados lidos do arquivo que foram armazenados no array
		For i:=1 To Len(aDados)

			// Exibe mensagem na régua de processamento
			IncProc("Importando Dados...")

			// Abre a tabela
			dbSelectArea("ZX1")

			// Define o índice da tabela
			dbSetOrder(1)

			// Vai para o primeiro registro da tabela
			dbGoTop()

			// Se a chave pesquisada não existir na tabela, inclui o registro
			If ! ZX1->( dbSeek(xFilial("ZX1") + avkey(aDados[i,1], "ZX1_CODIGO" )) )

				// Trava o registro para inclusão
				Reclock("ZX1",.T.)

				// Efetua a gravação dos campos do registro
				ZX1->ZX1_FILIAL := xFilial("ZX1")
				ZX1->ZX1_CODIGO := GETSXENUM("ZX1","ZX1_CODIGO")
				ZX1->ZX1_NOME	:= aDados[i,1]
				ZX1->ZX1_IDADE	:= val(aDados[i,2])
				ZX1->ZX1_SEXO	:= aDados[i,3]

				// For j:=1 to Len(aCampos)
				// 	cCampo  := "ZX1->" + aCampos[j]
				// 	&cCampo := aDados[i,j]
				// Next j

				// Desbloqueia o registro
				ZX1->(MsUnlock())
				// Confirma a utilizaçao do número sequencial
				ConfirmSX8()
			EndIf
		Next i

		// Fim da transação
		// End Transaction

		// Fecha o arquivo csv
		FT_FUSE()

		ApMsgInfo("Importação dos Clientes concluída com sucesso!","[IMPCSV] - SUCESSO")

	else
		Alert("Erro ao tentar abrir o arquivo!")
	endif

Return(Nil)
