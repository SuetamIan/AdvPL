#include "totvs.ch"


/*/{Protheus.doc} User Function FMedAlu
    Calcula a media das notas do aluno e
    informa se ele foi aprovado/recuperação/reprovado
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

        Alert( "A nota da primeira prova é: " + cValToChar(n1) )
        Alert( "A nota da segunda prova é: " + cValToChar(n2) )
        Alert( "A média do estudante é: " + cValToChar(nMedia) )
        Alert( "O estudante está APROVADO! " )

    elseif nMedia >= 4

        Alert( "A nota da primeira prova é: " + cValToChar(n1) )
        Alert( "A nota da segunda prova é: " + cValToChar(n2) )
        Alert( "A média do estudante é: " + cValToChar(nMedia) )
        Alert( "O estudante está em RECUPERAÇÃO! " )

    else

        Alert( "A nota da primeira prova é: " + cValToChar(n1) )
        Alert( "A nota da segunda prova é: " + cValToChar(n2) )
        Alert( "A média do estudante é: " + cValToChar(nMedia) )
        Alert( "O estudante está REPROVADO! " )

    EndIf
    
Return()
