#include "totvs.ch"

/*/{Protheus.doc} SIGAEST
Exemplo de programa usando browse
@type function
@version
@author Marcos Aleluia
@since 12/08/2021
@return variant, return_description
/*/
user function zBrowse()

	Local cVldAlt       := ".T." // Operacao: ALTERACAO
	Local cVldExc       := ".T." // Operacao: EXCLUSAO
	Local cAlias        := "SB1"

	// Título a ser utilizado nas operações
	Private cCadastro   := "Cadastro de ..."
	Private aRotina     := {}

	// Abre a tabela no índice 1
	SB1->( dbSetOrder(1) )

	aRotina := {;
		{ 'Pesquisar',  "AxPesqui", 0, 1},;
		{ 'Visualizar', "AxVisual", 0, 2},;
		{ 'Incluir',    "AxInclui", 0, 3},;
		{ 'Alterar',    "AxAltera", 0, 4},;
		{ 'Exlcuir',    "AxDeleta", 0, 5},;
		{ 'teste1',     "Alert('ola!')", 0, 6},;
		{ 'teste2',     "u_FMsg1()", 0, 7},;
		{ 'teste3',     "u_FMsg2", 0, 8};
		}

	// aRotina := { {"kkk",33,"pato"}, {"eie",684,"pata"}  }

	// aAdd( aRotina, {"kkk",33,"pato"} )
	// aAdd( aRotina, {"eie",684,"pata"} )

	// mBrowse( 6, 1, 22, 75, cAlias)
	mBrowse( 2, 1, 10, 75, cAlias)

return(Nil)



user function FMsg1()

	Alert('ola de novo!')

return()


user function FMsg2(cAlias,nReg ,nOpc )

	Alert('ola de novo e de novo!')

return()
