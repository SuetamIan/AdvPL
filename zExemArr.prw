#include "totvs.ch"

/*/{Protheus.doc} User Function zExemArr
    (long_description)
    @type  Function
    @author Aleluia
    @since 15/09/2021
    @version version
    @param , ,
    @return , ,
    @example
    (examples)
    @see (links_or_references)
/*/
User Function zExemArr()

    Local aVar := {}
    Local nX := 0
    Local cAux := ""
    Local aAux := {}
    // Local nY := 0


    aVar := Array(2,3)

    for nX := 1 to len( aVar )
        cAux := FWInputBox("Informe o conteúdo separado por ;")
        aAux := StrTokArr2(cAux, ";", .T.)
        aVar[nX][1] := aAux[1]


        // PONTO DE ENTRADA
        // .
        // .
        // .
        // .
        // PONTO DE ENTRADA

        aVar[nX][2] := aAux[2]
        aVar[nX][3] := aAux[3]
        // for nY := 1 to len( aVar[nX] )
        //     aVar[nX][nY] := 10
        // next nY
    next nX


Return()


user function zOrdena()

    LOCAL aVetor := { "A", "D", "C", "B" }
    LOCAL aArray := { 3, 5, 1, 2, 4 }
    LOCAL aIndice := { { "Fipe", 9.3 }, { "IPC", 8.7 }, { "DIEESE", 12.3 } }

    ASORT(aVetor)                               // Resulta: { “A”, “B”, “C”, “D” }
    ASORT(aVetor,Nil,Nil, { |x, y| x > y } )    // Resulta: { “D”, “C”, “B”, “A” }

    ASORT(aArray)                               // Resulta: { 1, 2, 3, 4, 5 }

    ASORT(aArray,,, { |x, y| x > y } )          // Resulta: { 5, 4, 3, 2, 1 }

    //Este exemplo ordena o segundo elemento de um array de duas dimensões:

    ASORT(aIndice, , , { | x,y | x[2] > y[2] } )

    // Com base na ordenação acima, a ordem fica:

    // DIEESE     12.3

    // Fipe       9.3

    // IPC        8.7

    /*
    Quando o sinal é <, a ordenação se dará de forma ASCENDENTE
    Quando o sinal é >, a ordenação se dará de forma DESCENDENTE
    */

return()
