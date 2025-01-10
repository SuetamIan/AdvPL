#include "totvs.ch"
//+--------------------------------------------------------------------+
//| Rotina | MBRW2SX5| Autor | ARNALDO RAYMUNDO JR. | Data |01.01.2007 |
//+--------------------------------------------------------------------+
//| Descr. | UTILIZACAO DA MODELO2() PARA VISUALIZAÇÃO DO SX5. |
//+--------------------------------------------------------------------+
//| Uso | CURSO DE ADVPL |
//+--------------------------------------------------------------------+
USER FUNCTION MBrw2Sx5()

    Local cAlias        := "SX5"

    Private cCadastro   := "Arquivo de Tabelas"
    Private aRotina     := {}
    Private cDelFunc    := ".T." // Validacao para a exclusao. Pode-se utilizarExecBlock


    AADD(aRotina,{"Pesquisar",  "AxPesqui"  ,0,1})
    AADD(aRotina,{"Visualizar", "U_SX52Inc" ,0,2})
    AADD(aRotina,{"Incluir",    "U_SX52Inc" ,0,3})
    AADD(aRotina,{"Alterar",    "U_SX52Inc" ,0,4})
    AADD(aRotina,{"Excluir",    "U_SX52Inc" ,0,5})

    dbSelectArea(cAlias)

    dbSetOrder(1)

    mBrowse( 6,1,22,75,cAlias)

Return(Nil)



USER FUNCTION SX52INC(cAlias,nReg,nOpc)

    Local cTitulo       := "Inclusao de itens - Arquivo de Tabelas"
    Local aCab          := {} // Array com descricao dos campos do Cabecalho do Modelo2
    Local aRoda         := {} // Array com descricao dos campos do Rodape do Modelo 2
    Local aGrid         := {80,005,050,300} //Array com coordenadas da GetDados no modelo2 - Padrao: {44,5,118,315}

    // Linha Inicial - Coluna Inicial - +Qts Linhas - +Qts Colunas : {080,005,050,300}
    Local cLinhaOk      := "u_VldLinha()" // Validacoes na linha da GetDados da Modelo 2
    Local cTudoOk       := "AllwaysTrue()" // Validacao geral da GetDados da Modelo 2
    Local lRetMod2      := .F. // Retorno da função Modelo2 - .T. Confirmou / .F. Cancelou
    // Local lOk           := .T.
    Local nColuna       := 0
    Local nLinha        := 0

    // Variaveis para GetDados()
    Private aCols       := {}
    Private aHeader     := {}

    // Variaveis para campos da Enchoice()
    Private cX5Filial   := xFilial("SX5")
    Private cX5Tabela   := SPACE(5)

    // Montagem do array de cabeçalho
    // AADD(aCab,{"Variável" ,{L,C} ,"Título","Picture","Valid","F3",lEnable})
    AADD(aCab,{"cX5Filial" ,{015,010} ,"Filial","@!",,,.F.})
    AADD(aCab,{"cX5Tabela" ,{015,080} ,"Tabela","@!",,,.T.})

    // Montagem do aHeader
    AADD(aHeader,{"Chave" ,"X5_CHAVE","@!",5,0,"AllwaysTrue()","","C","","R"})
    AADD(aHeader,{"Descricao" ,"X5_DESCRI","@!",40,0,"AllwaysTrue()","","C","","R"})

    // Montagem do aCols
    if nOpc == 3

        aCols := Array(1,Len(aHeader)+1)

        // Inicialização do aCols
        For nColuna := 1 to Len(aHeader)
            If aHeader[nColuna][8] == "C"
                aCols[1][nColuna] := SPACE(aHeader[nColuna][4])
            ElseIf aHeader[nColuna][8] == "N"
                aCols[1][nColuna] := 0
            ElseIf aHeader[nColuna][8] == "D"
                aCols[1][nColuna] := CTOD("")
            ElseIf aHeader[nColuna][8] == "L"
                aCols[1][nColuna] := .F.
            ElseIf aHeader[nColuna][8] == "M"
                aCols[1][nColuna] := ""
            Endif
        Next nColuna

        // Linha não deletada
        aCols[1][Len(aHeader)+1] := .F.

    elseif nOpc == 4 .OR. nOpc == 5 .OR. nOpc == 2

        // alimenta o aCols
        SX5->( dbSetOrder(1) )  // X5_FILIAL+X5_TABELA+X5_CHAVE
        If SX5->( MsSeek( cSeek := FWxFilial("SX5") + SX5->X5_TABELA ) )
            cX5Tabela := SX5->X5_TABELA
            while ! SX5->( EOF() ) .AND. cSeek == SX5->( X5_FILIAL+X5_TABELA )
                aItens := {}
                aAdd(aItens, SX5->X5_CHAVE)
                aAdd(aItens, SX5->X5_DESCRI)
                aAdd(aItens, .F.)
                aAdd( aCols, aItens )
                SX5->( dbSkip() )
            enddo
        EndIf

    endif

    // Execução da rotina MODELO2
    lRetMod2 := Modelo2(cTitulo,aCab,aRoda,aGrid,nOpc,cLinhaOk,cTudoOk)

    // Avalia o retorno da execução do comando Modelo2
    IF lRetMod2

        // Olha se a opção é 3=Inclusão ou 4=Alteração
        if nOpc == 3 .OR. nOpc == 4

            // Percorre todas as linhas do grid
            For nLinha := 1 to len(aCols)

                if SX5->( MsSeek( FWxFilial("SX5") + cX5Tabela + aCols[nLinha][01] ) )
                    // Trava o registro para alteração (.F.)
                    Reclock("SX5", .F.)
                else
                    // Trava o registro para inclusão (.T.)
                    Reclock("SX5", .T.)
                endif

                if nOpc == 4 .AND. gdDeleted(nLinha)

                    // Deleta o registro da tabela
                    SX5->( DBDelete() )

                else

                    // Campos do cabeçalho da tela
                    SX5->X5_FILIAL := cX5Filial
                    SX5->X5_TABELA := cX5Tabela

                    // Campos do aCols (grid) da tela
                    SX5->X5_CHAVE   := aCols[nLinha][1]
                    SX5->X5_DESCRI  := aCols[nLinha][2]

                endif

                SX5->(MsUnLock())

            Next nLinha

            // Olha se a opção é 5=exclusão
        elseif nOpc == 5

            if MsgYesNo("A tabela "+alltrim(SX5->X5_TABELA)+" vai ser toda deletada! É isso mesmo? Quer continuar?")

                SX5->( dbSetOrder(1) )  // X5_FILIAL+X5_TABELA+X5_CHAVE

                If SX5->( MsSeek( cSeek := FWxFilial("SX5") + cX5Tabela ) )
                    while ! SX5->( EOF() ) .AND. cSeek == SX5->( X5_FILIAL+X5_TABELA )
                        Reclock("SX5", .F.)
                        SX5->( DBDelete() )
                        SX5->( MsUnlock() )
                        SX5->( dbSkip() )
                    enddo
                endif

            endif

        endif
    else
        // MsgAlert("Você cancelou a operação","MBRW2SX5")
    endif

Return()


/*/{Protheus.doc} VldLinha
Função responsável por validar a linha
@type function
@version
@author Marcos Aleluia
@since 16/02/2022
@return variant, return_description
/*/
user function VldLinha()

    Local lRet := .T.

    // if len(aCols) == 1
    //     Alert("Só tem uma linha")
    //     lRet := .F.
    // else
    //     lRet := .T.
    // endif

    // Alert("VldLinha")

return(lRet)
