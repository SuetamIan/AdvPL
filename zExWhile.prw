#include "Totvs.ch"

user function zExWhile()

	Local nNumber 	:= 0
	Local nSomaPar 	:= 0
	Local nCont 	:= 0
	Local l1aVez	:= .T.

	While nNumber <= 100

		nCont ++

		if l1aVez
			Alert("Vou dar um loop")
			l1aVez := .F.
			loop
		endif

		nSomaPar += nNumber
		nNumber  += 2

		if nNumber == 6
			Alert("Estou saindo!")
			exit
		endif

	Enddo

	Alert( "A soma dos "+cValToChar(nCont)+" primeiros numeros pares e: " + cValToChar(nSomaPar) )

Return()
