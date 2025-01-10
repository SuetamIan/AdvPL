#include "totvs.ch"


/*/{Protheus.doc} MA103OPC
Ponto de Entrada utilizado para adicionar itens no menu
@type function
@version  
@author Marcos Aleluia
@since 18/02/2022
@return variant, return_description
/*/
User Function MA103OPC()

    Local aRet := {}
    
    aAdd( aRet, {'Func Teste1', 'u_fFunctst()', 0, 5 } )

Return aRet



/*/{Protheus.doc} fFunctst
Executa a ação do botão
@type function
@version  
@author Marcos Aleluia
@since 18/02/2022
@return variant, return_description
/*/
user function fFunctst()

    Alert("Chamei a função!")

return()
