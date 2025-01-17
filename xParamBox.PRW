#include "totvs.ch"

//----------------------------------------------------------
// Fun��o exemplo utilizando a fun��o ParamBox()
//----------------------------------------------------------
User Function xParamBox()

    Local aRet          := {}
    Local aParamBox     := {}
    Local aCombo        := {"Janeiro","Fevereiro","Mar�o","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
    Local i             := 0

    Private cCadastro    := ""

    /*O comando RpcSetEnv() � utilizado para abertura de ambiente
    em rotinas autom�ticas, permitindo definir a empresa e filial
    no qual desejamos fazer a inicializa��o do ambiente, especificando
    o usu�rio e senha para determinar os direitos e a��es a serem realizadas.
    � poss�vel tamb�m especificar quais as tabelas que ser�o abertas
    para uso no ambiente e qual m�dulo ser� utilizado. */
    if select("SM0") == 0 // importante para iniciar a tela pelo codigo sem estar com o smart client ligado
        RpcSetType(3)
        RpcSetEnv("99","01")
    endif

    cCadastro := "xParambox"

    // ------------------------------------------------------------------
    // ->> Abaixo est� a montagem do vetor que ser� passado para a fun��o
    // ------------------------------------------------------------------

    // aAdd(aParamBox,{1,"Produto","KKKK","","","SB1","",0,.T.}) // Tipo caractere

    // aAdd(aParamBox,{1,"Valor",0,"@E 9,999.99","mv_par02>0","","",20,.F.}) // Tipo num�rico

    aAdd(aParamBox,{1,"Data"  ,Ctod(Space(8)),"","","","",50,.F.}) // Tipo data
    // // Tipo 1 -> MsGet()
    // //           [2]-Descricao
    // //           [3]-String contendo o inicializador do campo
    // //           [4]-String contendo a Picture do campo
    // //           [5]-String contendo a validacao
    // //           [6]-Consulta F3
    // //           [7]-String contendo a validacao When
    // //           [8]-Tamanho do MsGet
    // //           [9]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{2,"Informe o m�s",1,aCombo,50,"",.F.})
    // // Tipo 2 -> Combo
    // //           [2]-Descricao
    // //           [3]-Numerico contendo a opcao inicial do combo
    // //           [4]-Array contendo as opcoes do Combo
    // //           [5]-Tamanho do Combo
    // //           [6]-Validacao
    // //           [7]-Flag .T./.F. Parametro Obrigatorio ?
    // // Cuidado, h� um problema nesta op��o quando selecionado a 1� op��o.

    aAdd(aParamBox,{3,"Mostra deletados",1,{"Sim","N�o","Talvez"},50,"",.F.})
    // Tipo 3 -> Radio
    //           [2]-Descricao
    //           [3]-Numerico contendo a opcao inicial do Radio
    //           [4]-Array contendo as opcoes do Radio
    //           [5]-Tamanho do Radio
    //           [6]-Validacao
    //           [7]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{4,"Marca todos ?",.F.,"Marque todos se necess�rio for.",90,"",.F.})
    // // Tipo 4 -> Say + CheckBox
    // //           [2]-Descricao
    // //           [3]-Indicador Logico contendo o inicial do Check
    // //           [4]-Texto do CheckBox
    // //           [5]-Tamanho do Radio
    // //           [6]-Validacao
    // //           [7]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{5,"Marca todos ?",.F.,50,"",.F.})
    // // Tipo 5 -> Somente CheckBox
    // //           [2]-Descricao
    // //           [3]-Indicador Logico contendo o inicial do Check
    // //           [4]-Tamanho do Radio
    // //           [5]-Validacao
    // //           [6]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{6,"Buscar arquivo",Space(50),"","","",50,.F.,"Todos os arquivos (*.*) |*.*"})
    // // Tipo 6 -> File
    // //           [2]-Descricao
    // //           [3]-String contendo o inicializador do campo
    // //           [4]-String contendo a Picture do campo
    // //           [5]-String contendo a validacao
    // //           [6]-String contendo a validacao When
    // //           [7]-Tamanho do MsGet
    // //           [8]-Flag .T./.F. Parametro Obrigatorio ?
    // //           [9]-Texto contendo os tipos de arquivo, exemplo: "Arquivos .CSV |*.CSV"
    // //           [10]-Diretorio inicial do cGetFile
    // //           [11]-N�mero relativo a visualiza��o, podendo ser por diret�rio ou por arquivo (0,1,2,4,8,16,32,64,128)

    aAdd(aParamBox,{7,"Monte o filtro","SX5","X5_FILIAL==xFilial('SX5')"})
    // // Tipo 7 -> Montagem de expressao de filtro
    // //           [2]-Descricao
    // //           [3]-Alias da tabela
    // //           [4]-Filtro inicial

    aAdd(aParamBox,{8,"Digite a senha",Space(15),"","","","",80,.F.})
    // // Tipo 8 -> MsGet Password
    // //           [2]-Descricao
    // //           [3]-String contendo o inicializador do campo
    // //           [4]-String contendo a Picture do campo
    // //           [5]-String contendo a validacao
    // //           [6]-Consulta F3
    // //           [7]-String contendo a validacao When
    // //           [8]-Tamanho do MsGet
    // //           [9]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{9,"Texto aleat�rio, apenas demonstrativo.",150,7,.T.})
    // // Tipo 9 -> Somente uma mensagem, formato de um t�tulo
    // //           [2]-Texto descritivo
    // //           [3]-Largura do texto
    // //           [4]-Altura do texto
    // //           [5]-Valor l�gico sendo: .T. => fonte tipo VERDANA e .F. => fonte tipo ARIAL

    aAdd(aParamBox,{10,"Cliente",Space(6),"SA1",40,"C",6,".T."})
    // // Tipo 10 -> Range de busca
    // //            [2] = T�tulo
    // //            [3] = Inicializador padr�o
    // //            [4] = Consulta F3
    // //            [5] = Tamanho do GET
    // //            [6] = Tipo do dado, somente (C=caractere e D=data)
    // //            [7] = Tamanho do espa�o
    // //            [8] = Condi��o When

    aAdd(aParamBox,{11,"Informe o motivo","",".T.",".T.",.T.})
    // // Tipo 11 -> MultiGet (Memo)
    // //            [2] = Descri��o
    // //            [3] = Inicializador padr�o
    // //            [4] = Valida��o
    // //            [5] = When
    // //            [6] = Campo com preenchimento obrigat�rio .T.=Sim .F.=N�o (incluir a valida��o na fun��o ParamOk)

    // ------------------------------------------------------------------
    // <<- Abaixo est� a montagem do vetor que ser� passado para a fun��o
    // ------------------------------------------------------------------

    // Parametros da fun��o Parambox()
    // -------------------------------
    // 1 - < aParametros > - Vetor com as configura��es
    // 2 - < cTitle >      - T�tulo da janela
    // 3 - < aRet >        - Vetor passador por referencia que cont�m o retorno dos par�metros
    // 4 - < bOk >         - Code block para validar o bot�o Ok
    // 5 - < aButtons >    - Vetor com mais bot�es al�m dos bot�es de Ok e Cancel
    // 6 - < lCentered >   - Centralizar a janela
    // 7 - < nPosX >       - Se n�o centralizar janela coordenada X para in�cio
    // 8 - < nPosY >       - Se n�o centralizar janela coordenada Y para in�cio
    // 9 - < oDlgWizard >  - Utiliza o objeto da janela ativa
    //10 - < cLoad >       - Nome do perfil se caso for carregar
    //11 - < lCanSave >    - Salvar os dados informados nos par�metros por perfil
    //12 - < lUserSave >   - Configura��o por usu�rio

    // Caso alguns par�metros para a fun��o n�o seja passada ser� considerado DEFAULT as seguintes abaixo:
    // DEFAULT bOk   := {|| (.T.)}
    // DEFAULT aButtons := {}
    // DEFAULT lCentered := .T.
    // DEFAULT nPosX  := 0
    // DEFAULT nPosY  := 0
    // DEFAULT cLoad     := ProcName(1)
    // DEFAULT lCanSave := .T.
    // DEFAULT lUserSave := .F.

    If ParamBox(aParamBox,"Teste Par�metros...",@aRet)
        // For i:=1 To Len(aRet)
        //     MsgInfo(aRet[i],"Op��o escolhida")
        // Next
        if ddatabase > aRet[1]
            Alert("Data Base Maior")
        elseif aRet[2] == 1
            Alert("Marcou Sim")
        elseif aRet[2] == 2
            Alert("Marcou N�o")
        else
            Alert("Marcou Talvez")
        endif

    Endif

Return()



user function zParBx()

    if select("SM0") == 0
        RpcSetType(3)
        RpcSetEnv("99","01")
    endif

    // zPar01()
    // zPar02()
    zPar03()
    zPar04()
    zPar05()
    zPar06()

return()



// ParamBox com par�metros texto
static function zPar01()

    Local aPergs   := {}
    Local cArquivo := Space(100)
    Local cProdDe  := Space(TamSX3('B1_COD')[01])
    Local cProdAt  := Space(TamSX3('B1_COD')[01])

    aAdd(aPergs, {1, "Arquivo",     cArquivo, "", ".T.", "",    ".T.", 120, .T.})
    aAdd(aPergs, {1, "Produto De",  cProdDe,  "", ".T.", "SB1", ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Produto At�", cProdAt,  "", ".T.", "SB1", ".T.", 80,  .T.})

    If ParamBox(aPergs, "Informe os par�metros")
        Alert(MV_PAR01)
        Alert(MV_PAR02)
        Alert(MV_PAR03)
    EndIf

return()


// ParamBox com par�metros data
static function zPar02()

    Local aPergs   := {}
    Local dDataDe  := FirstDate(Date())
    Local dDataAt  := LastDate(Date())

    aAdd(aPergs, {1, "Data De",  dDataDe,  "", ".T.", "", ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Data At�", dDataAt,  "", ".T.", "", ".T.", 80,  .T.})

    If ParamBox(aPergs, "Informe os par�metros")
        Alert(cValToChar(MV_PAR01))
        Alert(cValToChar(MV_PAR02))
    EndIf

return()



// ParamBox com par�metros num�rico
static function zPar03()

    Local aPergs   := {}
    Local nQuant   := 0
    Local nValor   := 0

    aAdd(aPergs, {1, "Qtde",  nQuant,  "@E 9,999",     "Positivo()", "", ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Valor", nValor,  "@E 99,999.99", "Positivo()", "", ".T.", 80,  .F.})

    If ParamBox(aPergs, "Informe os par�metros")
        Alert(cValToChar(MV_PAR01))
        Alert(cValToChar(MV_PAR02))
    EndIf

return()



// ParamBox com par�metros do tipo Combo
static function zPar04()

    Local aPergs   := {}
    Local nTipo    := 1
    Local nVinc    := 1

    aAdd(aPergs, {2, "Tipo Importa��o",               nTipo, {"1=Pr� Nota",              "2=Classifica��o em Documento de Entrada"},     122, ".T.", .F.})
    aAdd(aPergs, {2, "Vincula Pedido de Compra",      nVinc, {"1=Sim (Automaticamente)", "2=N�o"},                                       090, ".T.", .F.})

    If ParamBox(aPergs, "Informe os par�metros")
        Alert(cValToChar(MV_PAR01))
        Alert(cValToChar(MV_PAR02))
    EndIf

return()



// ParamBox com par�metros sem o salvamento de dados
static function zPar05()

    Local aPergs   := {}
    Local cArquivo := Space(100)
    Local cProdDe  := Space(TamSX3('B1_COD')[01])
    Local cProdAt  := Space(TamSX3('B1_COD')[01])

    aAdd(aPergs, {1, "Arquivo",     cArquivo, "", ".T.", "",    ".T.", 120, .T.})
    aAdd(aPergs, {1, "Produto De",  cProdDe,  "", ".T.", "SB1", ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Produto At�", cProdAt,  "", ".T.", "SB1", ".T.", 80,  .T.})

    If ParamBox(aPergs, "Informe os par�metros", , , , , , , , , .F., .F.)
        Alert(MV_PAR01)
        Alert(MV_PAR02)
        Alert(MV_PAR03)
    EndIf

return()



// ParamBox com in�meros par�metros diferentes
static function zPar06()

    Local aPergs   := {}
    Local cArquivo := Space(100)
    Local cProdDe  := Space(TamSX3('B1_COD')[01])
    Local cProdAt  := Space(TamSX3('B1_COD')[01])
    Local dDataDe  := FirstDate(Date())
    Local dDataAt  := LastDate(Date())
    Local nQuant   := 0
    Local nValor   := 0
    Local nTipo    := 1
    Local nVinc    := 1

    aAdd(aPergs, {1, "Arquivo",     cArquivo, "",             ".T.",        "",    ".T.", 120, .T.})
    aAdd(aPergs, {1, "Produto De",  cProdDe,  "",             ".T.",        "SB1", ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Produto At�", cProdAt,  "",             ".T.",        "SB1", ".T.", 80,  .T.})
    aAdd(aPergs, {1, "Data De",  dDataDe,  "",             ".T.",        "",    ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Data At�", dDataAt,  "",             ".T.",        "",    ".T.", 80,  .T.})
    aAdd(aPergs, {1, "Qtde",        nQuant,   "@E 9,999",     "Positivo()", "",    ".T.", 80,  .F.})
    aAdd(aPergs, {1, "Valor",       nValor,   "@E 99,999.99", "Positivo()", "",    ".T.", 80,  .F.})
    aAdd(aPergs, {2, "Tipo Importa��o",               nTipo, {"1=Pr� Nota",              "2=Classifica��o em Documento de Entrada"},     122, ".T.", .F.})
    aAdd(aPergs, {2, "Vincula Pedido de Compra",      nVinc, {"1=Sim (Automaticamente)", "2=N�o"},                                       090, ".T.", .F.})

    If ParamBox(aPergs, "Informe os par�metros")
        Alert(MV_PAR01)
        Alert(MV_PAR02)
        Alert(MV_PAR03)
        Alert(cValToChar(MV_PAR04))
        Alert(cValToChar(MV_PAR05))
        Alert(cValToChar(MV_PAR06))
        Alert(cValToChar(MV_PAR07))
        Alert(cValToChar(MV_PAR08))
        Alert(cValToChar(MV_PAR09))
    EndIf

return()
