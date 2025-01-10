#include "totvs.ch"


/*/{Protheus.doc} FIN050INC
EXECAUTO CONTAS A PAGAR
@type function
@version
@author Marcos Aleluia
@since 29/11/2021
@return variant, return_description
/*/
USER FUNCTION FIN050INC()

    LOCAL aArray := {}

    PRIVATE lMsErroAuto := .F.

    aArray := {;
        { "E2_PREFIXO"  , "TST"             , NIL },;
        { "E2_NUM"      , "18022110"        , NIL },;
        { "E2_TIPO"     , "BOL"             , NIL },;
        { "E2_NATUREZ"  , "PAGTO.EMPR"      , NIL },;
        { "E2_FORNECE"  , "000001"          , NIL },;
        { "E2_LOJA"     , "01"              , NIL },;
        { "E2_EMISSAO"  , CtoD("18/02/2022"), NIL },;
        { "E2_VENCTO"   , CtoD("21/02/2022"), NIL },;
        { "E2_VALOR"    , 88547             , NIL } }

        // { "E2_VENCREA"  , CtoD("17/02/2012"), NIL },;
        // { "E2_EMISSAO"  , CtoD("17/02/2012"), NIL },;
    MsExecAuto( { |x,y,z| FINA050(x,y,z) }, aArray,, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão


    If lMsErroAuto
        MostraErro()
    Else
        Alert("Título incluído com sucesso!")
    Endif

Return
