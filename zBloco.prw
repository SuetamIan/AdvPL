#include "totvs.ch"


/*
O que é Bloco de código?

Um ClodeBlock nada mais é do que uma função “inline”, 
onde podem ser declarados parâmetros de entrada, e dentro 
dele podemos colocar uma ou mais expressões Advpl separadas 
por vírgulas, como por exemplo atribuições de valores em 
variáveis e chamadas de funções ou métodos.

Sintaxe

{ | [parm1][,parm2...N] | [expr1] [,expr2...N] }


Os parâmetros são declarados entre um par de pipes “||”. 
Caso o CodeBlock não receba parâmetros, usamos um par de 
pipes sem nada entre eles. As expressões ADVPL colocadas 
após o par de pipes devem ser separadas por vírgulas, e 
serão executadas da esquerda para a direita.

A última expressão do bloco de código será o seu retorno. 
Dentro das expressões não é possível usar estruturas de 
programação, como WHILE , CASE e afins. É permitido usar 
as funções IF() e/ou IIF(), que veremos posteriormente.


Chamada

Para executar o CodeBlock, você deve usar a função EVAL(), 
onde informamos no primeiro parâmetro o CodeBLock ou a variável 
ou propriedade onde o mesmo está contido, e a partir do segundo 
parâmetro podemos informar os parâmetros que serão repassados 
para o CodeBlock. A função Eval() retorna o resultado da última 
expressão do CodeBlock executado.

*/


// CodeBlock sem parâmetros, chamando uma função de interface para mostrar uma caixa de diálogo com uma mensagem fixa
User Function Ola01()

    Local bCB := {|| MsgInfo("Olá CodeBlock") }

    Eval(bCB)

Return(Nil)


// CodeBlock recebendo um parâmetro, chamando uma função de interface para
// mostrar uma caixa de diálogo com o texto informado na chamada.
User Function Ola02()

    Local bCB := {| cMsg | MsgInfo(cMsg) }

    Eval(bCB,"Olá CodeBlock")
    Eval(bCB,"Adeus CodeBlock")

Return(Nil)


// CodeBlock para retornar o menor argumento, a partir de dois
// argumentos fornecidos na chamada, mostrando o resultado em uma
// caixa de diálogo no SmartClient
User Function Ola03()

    Local bCB := {| x1,x2 | IIF( X1 < x2 , x1 , x2 ) }
    Local nRet
    Local cRet

    nRet := Eval(bCB,10,5)

    MsgInfo( cValToChar(nRet),"Número")

    cRet := Eval(bCB,"ABC","ACD")

    MsgInfo( cRet,"String")

Return(Nil)

/*
Quando você cria um bloco de código para seu uso, você define 
quantos parâmetros ele deve receber, e ou qual será seu retorno.
Os parâmetros podem ser nomeados usando a regra de nomenclatura de
variáveis ADVPL, e o escopo dos parâmetros é restrito ao corpo do
CodeBlock. Atribuições em linha são permitidas no CodeBlock, inclusive
podemos passar parâmetros por referência na chamada do CodeBlock,
e obter assim mais de um retorno.
*/

// Passagem de parâmetros por referência para múltiplos retornos
User Function Ola04()

    Local bCB := {| x,y,z | y := x/2 , z := x*2 , x%2 == 0 }
    Local nTeste := 4
    Local lPar
    Local nY , nZ

    // O bloco de codigo recebe em x o valor de nTeste
    // e recebe em y e z a referência das variáveis
    // nY e nZ respectivamente
    lPar := Eval( bCB , nTeste , @nY , @nZ )

    MsgInfo(lPar , "O numero é par ? ")
    MsgInfo(nY , "Numero / 2 ")
    MsgInfo(nZ , "Numero * 2 ")

Return(Nil)



// Cálculo da média de valores em um array de números
User Function Ola05()

    Local aValores := {}
    Local nSoma := 0
    Local bSoma := {| nValor , nPos | nSoma += nValor }

    aadd(aValores,3)
    aadd(aValores,4)
    aadd(aValores,3)
    aadd(aValores,10)

    aEval(aValores,bSoma)

    MsgInfo(nSoma,"Valores Somados")


/*
Repare que no exemplo acima foi feito algo diferente:
A variável local nSoma foi declarada e inicializada
dentro da função Ola05(), mas não foi passada como
parâmetro para o CodeBlock, ela simplesmente foi usada
na expressão dentro do CodeBlock para acumular a soma
do elemento nValor recebido como parâmetro no CodeBlock.
Logo, um code-block declarado dentro de uma função pode
acessar diretamente as variáveis locais disponíveis nesta função.
*/

Return(Nil)
