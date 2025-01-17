#include "totvs.ch"


/*/{Protheus.doc} User Function FMedAlu
    Calcula a media das notas do aluno e
    informa se ele foi aprovado/recupera��o/reprovado
    @type  Function
    @author Marcos Aleluia
    @since 10/02/2022
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function FMedAlu()

    Local n1        := 0
    Local n2        := 0
    Local nMedia    := 0

	n1 := Val(FwInputBox("Digite a nota da primeira prova"))
	n2 := Val(FwInputBox("Digite a nota da segunda prova"))

    nMedia := (n1 + n2) / 2

    If nMedia >= 7      // se isso for verdade

        Alert( "A nota da primeira prova �: " + cValToChar(n1) )
        Alert( "A nota da segunda prova �: " + cValToChar(n2) )
        Alert( "A m�dia do estudante �: " + cValToChar(nMedia) )
        Alert( "O estudante est� APROVADO! " )

    elseif nMedia >= 4

        Alert( "A nota da primeira prova �: " + cValToChar(n1) )
        Alert( "A nota da segunda prova �: " + cValToChar(n2) )
        Alert( "A m�dia do estudante �: " + cValToChar(nMedia) )
        Alert( "O estudante est� em RECUPERA��O! " )

    else

        Alert( "A nota da primeira prova �: " + cValToChar(n1) )
        Alert( "A nota da segunda prova �: " + cValToChar(n2) )
        Alert( "A m�dia do estudante �: " + cValToChar(nMedia) )
        Alert( "O estudante est� REPROVADO! " )

    EndIf
    
Return()
