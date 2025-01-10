#include "totvs.ch"


user function xExemFor2()

	Local nCnt := 0
	Local nSomaPar := 0

	for nCnt := 0 to 100 Step 2
		nSomaPar += nCnt
	next nCnt

	Alert( "A soma dos 100 primeiros números é:" + cValToChar(nSomaPar) )

return()
