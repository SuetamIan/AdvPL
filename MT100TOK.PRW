#include "totvs.ch"


/*/{Protheus.doc} User Function MT100TOK
    Ponto de entrada na Valida��o da inclus�o de NF
    @type  Function
    @author Aleluia
    @since 18/02/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function MT100TOK()
    
    Local lRet := .T.

    lMT100TOK := .F.

    if __cUserID $ "000000"
        Alert("Ol� Administrador! Sua nota ser� gravada!")
        // lRet := .F.
    endif

Return(lRet)
