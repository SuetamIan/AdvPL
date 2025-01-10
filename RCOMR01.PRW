#include "totvs.ch"
#include "TopConn.ch"

User Function RCOMR01()

    Private oReport  := Nil
    Private oSecCab	 := Nil
    Private cPerg 	 := PadR("RCOMR01", Len(SX1->X1_GRUPO))

    // Definir os parâmetros do nosso relatório
    zPutSX1( cPerg, "01", "Código de?", "mv_par01", "mv_ch1", "C", 10 , 0, "G", "", "SB1", "", "", "", "", "", "", "Código do Produto De"  )
    zPutSX1( cPerg, "02", "Código Ate?", "mv_par02", "mv_ch2", "C", 10 , 0, "G", "", "SB1", "", "", "", "", "", "", "Código do Produto Ate"  )

    ReportDef()
    oReport:PrintDialog()

return(Nil)



static function ReportDef()

    oReport := TReport():New("RCOMR01","Cadastro de Produtos",cPerg,{|oReport| PrintReport(oReport)},"Impressão de cadastro de produtos em TReport simples.")
    oReport:SetLandscape(.T.)   // Define a orientação de página do relatório como Paisagem

    oSecCab := TRSection():New( oReport , "Produtos", {"QRY"} )

    TRCell():New( oSecCab, "B1_COD"     , "QRY")
    TRCell():New( oSecCab, "B1_DESC"    , "QRY")
    TRCell():New( oSecCab, "B1_TIPO"    , "QRY")
    TRCell():New( oSecCab, "B1_UM"      , "QRY")

    TRFunction():New(oSecCab:Cell("B1_COD"),/*cId*/,"COUNT"     ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.           ,.T.           ,.F.        ,oSecCab)

return(Nil)


Static Function PrintReport(oReport)

    Local cQuery     := ""
    // Local cAlias := GetNextAlias()

    Pergunte(cPerg,.F.)

    // cWhere := "%"
    // if .T.
    //     cWhere += "AND B1_DESC = '"+cTexto+"' "
    // else
    //     cWhere += "AND B1_DESC = '"+cTexto+"' "
    // endif
    // cWhere += "AND"
    // cWhere += "%"

    // BeginSql Alias cAlias
    //     SELECT
    //         B1_COD,
    //         B1_DESC,
    //         B1_TIPO
    //     FROM
    //         %table:SB1%
    //     WHERE
    //         1 = 1
    //         AND %exp:cWhere%
    //         AND %notDel%
    //         AND B1_FILIAL = %xFilial:SB1% B1_COD BETWEEN %exp:mv_par01% AND %exp:mv_par02%
    // EndSql

    // GetLastQuery()[2]

    cQuery += " SELECT " + CRLF
    cQuery += "     SB1.B1_COD " + CRLF
    cQuery += "    ,SB1.B1_DESC " + CRLF
    cQuery += "    ,SB1.B1_TIPO " + CRLF
    cQuery += "    ,SB1.B1_UM " + CRLF
    cQuery += "  FROM " + RetSqlName("SB1") + " SB1 " + CRLF
    cQuery += " WHERE SB1.B1_FILIAL = '" + xFilial ("SB1") + "' " + CRLF
    cQuery += "   AND SB1.B1_COD    BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' " + CRLF
    cQuery += "   AND SB1.D_E_L_E_T_ = ' ' " + CRLF
    cQuery := ChangeQuery(cQuery)

    If Select("QRY") > 0
        Dbselectarea("QRY")
        QRY->(DbClosearea())
    EndIf

    TcQuery cQuery New Alias "QRY"

    oSecCab:Print()

return(Nil)






/*/{Protheus.doc} zPutSX1
Função para criar Grupo de Perguntas
@author Atilio
@since 09/06/2017
@version 1.0
@type function
    @param cGrupo,    characters, Grupo de Perguntas       (ex.: X_TESTE)
    @param cOrdem,    characters, Ordem da Pergunta        (ex.: 01, 02, 03, ...)
    @param cTexto,    characters, Texto da Pergunta        (ex.: Produto De, Produto Até, Data De, ...)
    @param cMVPar,    characters, MV_PAR?? da Pergunta     (ex.: MV_PAR01, MV_PAR02, MV_PAR03, ...)
    @param cVariavel, characters, Variável da Pergunta     (ex.: MV_CH0, MV_CH1, MV_CH2, ...)
    @param cTipoCamp, characters, Tipo do Campo            (C = Caracter, N = Numérico, D = Data)
    @param nTamanho,  numeric,    Tamanho da Pergunta      (Máximo de 60)
    @param nDecimal,  numeric,    Tamanho de Decimais      (Máximo de 9)
    @param cTipoPar,  characters, Tipo do Parâmetro        (G = Get, C = Combo, F = Escolha de Arquivos, K = Check Box)
    @param cValid,    characters, Validação da Pergunta    (ex.: Positivo(), u_SuaFuncao(), ...)
    @param cF3,       characters, Consulta F3 da Pergunta  (ex.: SB1, SA1, ...)
    @param cPicture,  characters, Máscara do Parâmetro     (ex.: @!, @E 999.99, ...)
    @param cDef01,    characters, Primeira opção do combo
    @param cDef02,    characters, Segunda opção do combo
    @param cDef03,    characters, Terceira opção do combo
    @param cDef04,    characters, Quarta opção do combo
    @param cDef05,    characters, Quinta opção do combo
    @param cHelp,     characters, Texto de Help do parâmetro
    @obs Função foi criada, pois a partir de algumas versões do Protheus 12, a função padrão PutSX1 não funciona (por medidas de segurança)
    @example Abaixo um exemplo de como criar um grupo de perguntas

    cPerg    := "X_TST"

    cValid   := ""
    cF3      := ""
    cPicture := ""
    cDef01   := ""
    cDef02   := ""
    cDef03   := ""
    cDef04   := ""
    cDef05   := ""

    u_zPutSX1(cPerg, "01", "Produto De?",       "MV_PAR01", "MV_CH0", "C", TamSX3('B1_COD')[01], 0, "G", cValid,       "SB1", cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe o produto inicial")
    u_zPutSX1(cPerg, "02", "Produto Até?",      "MV_PAR02", "MV_CH1", "C", TamSX3('B1_COD')[01], 0, "G", cValid,       "SB1", cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe o produto final")
    u_zPutSX1(cPerg, "03", "A partir da Data?", "MV_PAR03", "MV_CH2", "D", 08,                   0, "G", cValid,       cF3,   cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe a data inicial a ser considerada")
    u_zPutSX1(cPerg, "04", "Média maior que?",  "MV_PAR04", "MV_CH3", "N", 09,                   2, "G", "Positivo()", cF3,   "@E 999,999.99", cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe a média de atraso que será considerada")
    u_zPutSX1(cPerg, "05", "Tipo de Saldos?",   "MV_PAR05", "MV_CH4", "N", 01,                   0, "C", cValid,       cF3,   cPicture,        "Todos", "Maior que 0", "Menor que 0", "Zerados", cDef05, "Informe o tipo de saldo a ser considerado")
    u_zPutSX1(cPerg, "06", "Tipos de Produto?", "MV_PAR06", "MV_CH5", "C", 60,                   0, "K", cValid,       cF3,   cPicture,        "PA",    "PI",          "MP",          cDef04,    cDef05, "Informe os tipos de produto que serão considerados")
    u_zPutSX1(cPerg, "07", "Caminho de Log?",   "MV_PAR07", "MV_CH6", "C", 60,                   0, "F", cValid,       cF3,   cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe o caminho para geração do log")
/*/

Static Function zPutSX1(cGrupo, cOrdem, cTexto, cMVPar, cVariavel, cTipoCamp, nTamanho, nDecimal, cTipoPar, cValid, cF3, cPicture, cDef01, cDef02, cDef03, cDef04, cDef05, cHelp)
    Local aArea       := GetArea()
    Local cChaveHelp  := ""
    Local nPreSel     := 0
    Default cGrupo    := Space(10)
    Default cOrdem    := Space(02)
    Default cTexto    := Space(30)
    Default cMVPar    := Space(15)
    Default cVariavel := Space(6)
    Default cTipoCamp := Space(1)
    Default nTamanho  := 0
    Default nDecimal  := 0
    Default cTipoPar  := "G"
    Default cValid    := Space(60)
    Default cF3       := Space(6)
    Default cPicture  := Space(40)
    Default cDef01    := Space(15)
    Default cDef02    := Space(15)
    Default cDef03    := Space(15)
    Default cDef04    := Space(15)
    Default cDef05    := Space(15)
    Default cHelp     := ""

    //Se tiver Grupo, Ordem, Texto, Parâmetro, Variável, Tipo e Tamanho, continua para a criação do parâmetro
    If !Empty(cGrupo) .And. !Empty(cOrdem) .And. !Empty(cTexto) .And. !Empty(cMVPar) .And. !Empty(cVariavel) .And. !Empty(cTipoCamp) .And. nTamanho != 0

        //Definição de variáveis
        cGrupo     := PadR(cGrupo, Len(SX1->X1_GRUPO), " ")           //Adiciona espaços a direita para utilização no DbSeek
        cChaveHelp := "P." + AllTrim(cGrupo) + AllTrim(cOrdem) + "."  //Define o nome da pergunta
        cMVPar     := Upper(cMVPar)                                   //Deixa o MV_PAR tudo em maiúsculo
        nPreSel    := Iif(cTipoPar == "C", 1, 0)                      //Se for Combo, o pré-selecionado será o Primeiro
        cDef01     := Iif(cTipoPar == "F", "56", cDef01)              //Se for File, muda a definição para ser tanto Servidor quanto Local
        nTamanho   := Iif(nTamanho > 60, 60, nTamanho)                //Se o tamanho for maior que 60, volta para 60 - Limitação do Protheus
        nDecimal   := Iif(nDecimal > 9,  9,  nDecimal)                //Se o decimal for maior que 9, volta para 9
        nDecimal   := Iif(cTipoPar == "N", nDecimal, 0)               //Se não for parâmetro do tipo numérico, será 0 o Decimal
        cTipoCamp  := Upper(cTipoCamp)                                //Deixa o tipo do Campo em maiúsculo
        cTipoCamp  := Iif(! cTipoCamp $ 'C;D;N;', 'C', cTipoCamp)     //Se o tipo do Campo não estiver entre Caracter / Data / Numérico, será Caracter
        cTipoPar   := Upper(cTipoPar)                                 //Deixa o tipo do Parâmetro em maiúsculo
        cTipoPar   := Iif(Empty(cTipoPar), 'G', cTipoPar)             //Se o tipo do Parâmetro estiver em branco, será um Get
        nTamanho   := Iif(cTipoPar == "C", 1, nTamanho)               //Se for Combo, o tamanho será 1

        DbSelectArea('SX1')
        SX1->(DbSetOrder(1)) // Grupo + Ordem

        //Se não conseguir posicionar, a pergunta será criada
        If ! SX1->(DbSeek(cGrupo + cOrdem))
            RecLock('SX1', .T.)
            X1_GRUPO   := cGrupo
            X1_ORDEM   := cOrdem
            X1_PERGUNT := cTexto
            X1_PERSPA  := cTexto
            X1_PERENG  := cTexto
            X1_VAR01   := cMVPar
            X1_VARIAVL := cVariavel
            X1_TIPO    := cTipoCamp
            X1_TAMANHO := nTamanho
            X1_DECIMAL := nDecimal
            X1_GSC     := cTipoPar
            X1_VALID   := cValid
            X1_F3      := cF3
            X1_PICTURE := cPicture
            X1_DEF01   := cDef01
            X1_DEFSPA1 := cDef01
            X1_DEFENG1 := cDef01
            X1_DEF02   := cDef02
            X1_DEFSPA2 := cDef02
            X1_DEFENG2 := cDef02
            X1_DEF03   := cDef03
            X1_DEFSPA3 := cDef03
            X1_DEFENG3 := cDef03
            X1_DEF04   := cDef04
            X1_DEFSPA4 := cDef04
            X1_DEFENG4 := cDef04
            X1_DEF05   := cDef05
            X1_DEFSPA5 := cDef05
            X1_DEFENG5 := cDef05
            X1_PRESEL  := nPreSel

            //Se tiver Help da Pergunta
            If !Empty(cHelp)
                X1_HELP    := ""

                fPutHelp(cChaveHelp, cHelp)
            EndIf
            SX1->(MsUnlock())
        EndIf
    EndIf

    RestArea(aArea)
Return



/*---------------------------------------------------*
 | Função: fPutHelp                                  |
 | Desc:   Função que insere o Help do Parametro     |
*---------------------------------------------------*/
Static Function fPutHelp(cKey, cHelp, lUpdate)
    Local cFilePor  := "SIGAHLP.HLP"
    Local cFileEng  := "SIGAHLE.HLE"
    Local cFileSpa  := "SIGAHLS.HLS"
    Local nRet      := 0
    Default cKey    := ""
    Default cHelp   := ""
    Default lUpdate := .F.

    //Se a Chave ou o Help estiverem em branco
    If Empty(cKey) .Or. Empty(cHelp)
        Return
    EndIf

    //**************************** Português
    nRet := SPF_SEEK(cFilePor, cKey, 1)

    //Se não encontrar, será inclusão
    If nRet < 0
        SPF_INSERT(cFilePor, cKey, , , cHelp)

        //Senão, será atualização
    Else
        If lUpdate
            SPF_UPDATE(cFilePor, nRet, cKey, , , cHelp)
        EndIf
    EndIf



    //**************************** Inglês
    nRet := SPF_SEEK(cFileEng, cKey, 1)

    //Se não encontrar, será inclusão
    If nRet < 0
        SPF_INSERT(cFileEng, cKey, , , cHelp)

        //Senão, será atualização
    Else
        If lUpdate
            SPF_UPDATE(cFileEng, nRet, cKey, , , cHelp)
        EndIf
    EndIf



    //**************************** Espanhol
    nRet := SPF_SEEK(cFileSpa, cKey, 1)

    //Se não encontrar, será inclusão
    If nRet < 0
        SPF_INSERT(cFileSpa, cKey, , , cHelp)

        //Senão, será atualização
    Else
        If lUpdate
            SPF_UPDATE(cFileSpa, nRet, cKey, , , cHelp)
        EndIf
    EndIf
Return
