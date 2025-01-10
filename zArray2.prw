#include "totvs.ch"


user Function zArray2()
    /*
      1. Criar uma variável do tipo array
      2. Alimentar essa variável com as linhas da tabela
      3. Utilizar o comando aAdd() para isso
      4. Usar o FOR para mostrar todas as "celulas" do meu array de cada linha
      5. Fim
    */

    // Declaração de variávies
    Local aDados    := {}
    Local nX        := 0
    Local cTexto    := ""

    // Desenvolvimento
    aAdd( aDados, { "MARCOS", 42, "M", "45849878" } )   // Acrescenta uma linha com 4 colunas no array
    aAdd( aDados, { "JOÃO", 28, "M", "68787441" } )   // Acrescenta uma linha com 4 colunas no array
    aAdd( aDados, { "FRED", 43, "M", "7849498" } )   // Acrescenta uma linha com 4 colunas no array

    // Finalização
    for nX := 1 to len( aDados )
        cTexto += aDados[nX, 1] + " - "
        cTexto += cValToChar(aDados[nX, 2]) + " - "
        cTexto += aDados[nX, 3] + " - "
        cTexto += aDados[nX, 4] + CRLF
    next nX

    Alert( cTexto )
    /*
    "MARCOS - 42 - M - 45849878
    "JOÃO - 28 - M - 68787441
    "FRED - 43 - M - 7849498
    
    */

return(Nil)
