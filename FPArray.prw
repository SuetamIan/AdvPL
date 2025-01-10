/**/



#include "totvs.ch"


user function FPArray()

    LOCAL aVetor := { {"Java", "AdvPL", "C++"}, {"Phyton", "PHP", "C#"} }
    LOCAL nPos   := ASCAN( aVetor, "AdvPL" )

    Local aAux := {}

    Local nX := 0
    Local nY := 0

    aAux := aClone( aVetor )


    // Vai percorrer todas as colunas do vetor e irá colocar as strings em maiúscula
    for nX := 1 to len( aAux )

        for nY := 1 to len( aAux[nX] )

            aAux[nX,nY] := UPPER( aAux[nX,nY] )   // UPPER - converte uma string para maiúscula

        next nY

    next nX

    // nPos := aScan( aAux, "JAVA" )
    nPos := aScan( aAux, { |x| x[2] == "ADVPL" } )

    Alert("O elemento pesquisado encontra-se na posição: " + cValToChar(nPos) )

return()



/*
1- Como utilizar o comando aScan para pesquisar array unidimensional
2- Como clonar o conteúdo de um array e salvar dentro de uma outra variável array
3- Como utilizar o comando aScan para pesquisar array multidimensional
*/
