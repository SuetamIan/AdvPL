#include "totvs.ch"

//Arrays
user function AVETOR()

	Local dData := Date()
	Local aValores := { {"Jack",dData,100}, {"Marcos",dData,100}, {"Aleluia",dData,100} }
	Local aValores2 := {}
	Local nX := 0
	Local nY := 0

	// comando for para fazer a leitura de todas as linhas e colunas de um array
	// for nX := 1 to len( aValores )	// 3

	// 	for nY := 1 to len( aValores[nX] )

	// 		Alert( aValores[nX, nY] )

	// 	next nY

	// next nX

	aAdd( aValores2, { "marcos", 2, CTOD("25/02/2022"), Nil } )
	aAdd( aValores2, { "Aleluia", 3, CTOD("28/02/2022"), "Nil" } )

return



user function AVETOR2()
	/**
	AADD() - permite a inserção de um item em um Array existente
	AINS() - permite a inserção de um elemento em ualquer posição do Array
	ACLONE() - realiza a copia de um Array para outro
	ADEL() - permite a exclusão de um elemento do Array tornando o último valor NULL
	ASIZE() - redefine a estrutura de um Array pré existente, adicionando ou removendo
	LEN() - retorna a quantidade de elementos de um Array
	*/


	Local aVetor := {10,20,30}
	Local nCount := 0
	
	Aadd(aVetor, 40)
	Alert("O tamanho do Array é: "+ cValToChar(Len(aVetor)))

	AIns(aVetor,2)
	aVetor[2] := 200
	Alert(aVetor[2])
	Alert(Len(aVetor))

	aVetor2 := AClone(aVetor)
	for nCount := 1 To Len(aVetor2)
		Alert(aVetor2[nCount])

	Next Count

	Adel(aVetor,2)
	Alert(aVetor[3])
	Alert(Len(aVetor))


	Asize(aVetor,2)
	Alert(Len(aVetor))

	FShowMsg()

return


static function FShowMsg()

	Alert("Olá pessoal!")

return()


static function ffunc()

	Local nNum := 10

return(nNum)
