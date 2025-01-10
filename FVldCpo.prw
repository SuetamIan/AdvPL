#include "totvs.ch"


user function FVldCpo()

    Local lRet := .T.

    // if( UPPER(ALLTRIM(M->BM_GRUPO)) == "ABC" , ( MsgAlert("conteúdo inválido"), .F. ) , .T. )

    If UPPER( ALLTRIM( M->BM_GRUPO ) ) == "ABC"
        MsgAlert("conteúdo inválido")
        lRet := .F.
    EndIf


return(lRet)
