#include "totvs.ch"

/*/{Protheus.doc} User Function FArray
    (long_description)
    @type  Function
    @author Aleluia
    @since 11/08/2021
    @version version
    @param , ,
    @return , ,
    @example
    (examples)
    @see (links_or_references)
/*/
User Function FArray()

    Local aDados1       := {}     // array unidimensional
    Local aDados2       := {}     // array bidimensional
    Local bBloco        := { || Alert("Ola pessoal!"), Alert( "Esse é um bloco de código" ) }
    Local cRetorno      := ""
    Local lContinua     := .T.
    Local nX            := 0


    cRetorno := FWInputBox("1-Array Unidimensional; 2-Array Bidimensional?; 3=Outra opção", "")

    if empty( cRetorno )
        Alert( "O conteúdo não pode ser vazio" )
        lContinua := .F.
    endif

    if lContinua

        if cRetorno == "1"

            // ESTUDO COM ARRAY UNIDIMENSIONAL
            aAdd( aDados1, 1)
            aAdd( aDados1, "TEXTO")
            aAdd( aDados1, .T.)
            aAdd( aDados1, CTOD("11/08/2021") )
            aAdd( aDados1, bBloco )


            // Alert( cValToChar(aDados1[1]) )
            // Alert( aDados1[2] )
            // Alert( cValToChar(aDados1[3]) )
            // Alert( cValToChar(aDados1[4]) )


            for nX := 1 to len( aDados1 )
                if valtype(adados1[nX]) == "B"
                    Eval( aDados1[5] )
                elseif valtype(adados1[nX]) <> "C"
                    Alert( cValToChar( adados1[nX] ) )
                else
                    Alert( aDados1[nX] )
                endif
            next nX


        elseif cRetorno == "2"

            // ESTUDO COM ARRAY BIDIMENSIONAL
            aAdd( aDados2, {"Texto1", .T., 1234} )
            aAdd( aDados2, {"Texto2", .F., 4321} )

        elseif cRetorno == "3"

        // .
        // .
        // .

        else

            Alert( "As opções possíveis são apenas 1-Array Unidimensional; 2-Array Bidimensional" )

        endif

    endif

Return(Nil)
