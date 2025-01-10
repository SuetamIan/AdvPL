#include "totvs.ch"


USER FUNCTION zBrowse2()


    LOCAL cFiltro   := ""
    LOCAL aCores  := {{ 'PA1->PA1_STATUS=="1"' , 'ENABLE'  },;    // Ativo
    { 'PA1->PA1_STATUS=="2"' , 'DISABLE' }}    // Inativo

    PRIVATE cAlias   := 'PA1'
    PRIVATE _cCpo  := "PA1_FILIAL/PA1_PRODUT/PA1_DESC"
    PRIVATE cCadastro := "Tabela de Umidade"
    PRIVATE aRotina     := {{"Pesquisar" , "AxPesqui"         , 0, 1 },;
    {"Visualizar" , "U_CTJA010B"   , 0, 2 },;
    {"Incluir"       , "U_CTJA010B"   , 0, 3 },;
    {"Alterar"      , "U_CTJA010B"   , 0, 4 },;
    {"Excluir"      , "U_CTJA010B"   , 0, 5 },;
    {"Consultar" , "U_CTJA010C"   , 0, 6 },;
    {"Legenda"   , "U_CTJA10LEG", 0, 7, 0, .F. }}       //"Legenda"

    dbSelectArea("PA1")

    dbSetOrder(1)

    mBrowse( ,,,,"PA1",,,,,,aCores,,,,,,,,cFiltro)

RETURN(NIL)
