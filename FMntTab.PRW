#include "totvs.ch"

/*/{Protheus.doc} User Function FMntTab
    (long_description)
    @type  Function
    @author user
    @since 17/02/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/
User Function FMntTab()

    // Declaração de variáveis
    Local cDoc := "23111526"
    Local lDeleta := .T.

    RpcSetType(3)
    RpcSetEnv("99","01")

    // Corpo da função
    // Abertura da tabela setando índice 1
    SD1->( dbSetOrder( 1 ) )    // D1_FILIAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, D1_ITEM

    // Posicionamento do registro
    if SD1->( MsSeek( FWxFilial("SD1") + cDoc ) )

        Alert( "O conteúdo do campo D1_ITEM é: " + SD1->D1_ITEM )
        Alert( "O conteúdo do campo D1_DOC é: " + SD1->D1_DOC )
        Alert( "A multiplicação de quantidade x valor unitário : " + cValToChar(SD1->D1_QUANT * SD1->D1_VUNIT) )
        Alert( "A multiplicação de quantidade x valor unitário : " + cValToChar(SD1->( D1_QUANT * D1_VUNIT ) ) )
        Alert( "A data de emissao antes da alteração é: " + cValToChar(SD1->D1_EMISSAO) )

        // Alteração da data de emissão do ítem da nota

        SD1->( RecLock( "SD1", .F. ) )  // .T.= Bloqueia o registro para inclusão; .F.=Bloqueia o registro para alteração/deleção

        if lDeleta

            // Deleta o registro posicionado
            SD1->( dbDelete() )

        else

            SD1->D1_EMISSAO     := dDataBase
            SD1->D1_CONTA       := "9999"

            SD1->( MsUnlock() )

            Alert( "A data de emissao antes da alteração é: " + cValToChar(SD1->D1_EMISSAO) )
            Alert( "A data de emissao antes da alteração é: " + SD1->D1_CONTA )

        endif

    else

        Alert( "Não foi possível encontrar o registro!" )

    endif


    // Finalizações


Return(Nil)


user function fMntDado()

    /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de cVariable dos componentes                                 ±±
    Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
    Private cNota      := Space(10)
    Private cFil      := Space(2)
    Private dEmissao   := CtoD(" ")
    Private nRadio

    RpcSetType(3)
    RpcSetEnv("99","01")


    /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
    Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
    SetPrvt("oDlg1","oSay1","oSay2","oSay3","oSay4","oGet1","oRMenu1","oGet2","oBtn1","oBtn2","oGet3")

    /*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
    Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
    oDlg1      := MSDialog():New( 215,270,715,965,"oDlg1",,,.F.,,,,,,.T.,,,.T. )
    oSay1      := TSay():New( 036,056,{||"Filial"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
    oSay2      := TSay():New( 116,048,{||"oSay2"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,228,044)
    oSay3      := TSay():New( 037,129,{||"Numero da nota"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,056,008)
    oSay4      := TSay():New( 079,056,{||"Emissão"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
    oGet1      := TGet():New( 048,056,{|u| If(PCount()>0,cFil:=u,cFil)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNota",,)
    GoRMenu1   := TGroup():New( 028,204,080,296,"Opções",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
    oRMenu1    := TRadMenu():New( 032,210,{"Alterar","Deletar"},{|u| If(PCount()>0,nRadio:=u,nRadio)},oDlg1,,,CLR_BLACK,CLR_WHITE,"",,,072,26,,.F.,.F.,.T. )
    oGet2      := TGet():New( 047,129,{|u| If(PCount()>0,cNota:=u,cNota)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNota",,)
    oBtn1      := TButton():New( 196,108,"E&xecutar",oDlg1,{|| fAltera() },037,012,,,,.T.,,"",,,,.F. )
    oBtn2      := TButton():New( 195,168,"&Sair",oDlg1,{|| oDlg1:End() },037,012,,,,.T.,,"",,,,.F. )
    oGet3      := TGet():New( 088,056,{|u| If(PCount()>0,dEmissao:=u,dEmissao)},oDlg1,072,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dEmissao",,)

    oDlg1:Activate(,,,.T.)


return()



static function fAltera()

    if oRMenu1:nOption == 1

        SD1->( dbSetOrder(1) )

        if SD1->( MsSeek( FWxFilial("SD1") + cNota ) )

            SD1->( RecLock( "SD1", .F. ) )

            SD1->D1_EMISSAO     := dEmissao

            SD1->( MsUnlock() )

            oSay2:cCaption := "Registro alterado com sucesso!"

        endif

    endif

return()


/*Essa função FGATALE é chamada no gatilho
disparado a partir do campo D1_VUNIT.
A chamada da função tem que enviar como
parametro o M->QUANT ( ex: U_FGATALE(M->D1_QUANT) ). 
Este será recebido pela variável nQuant*/
user function FGATALE(nQuant)

    Local nResultado := nQuant * M->D1_VUNIT

return(nResultado)
