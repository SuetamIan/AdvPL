
#include "totvs.ch"


user function calculadora()
local a, b, operacao, resultado

    a := 0
    b := 0
    operacao := ""
    resultado := 0

    // Entrada de dados
    a := read("Digite o primeiro n�mero: ")
    b := read("Digite o segundo n�mero: ")
    operacao := read("Digite a opera��o (+, -, *, /): ")

    // Realiza a opera��o selecionada
    switch operacao
        case "+"
            resultado := a + b
        case "-"
            resultado := a - b
        case "*"
            resultado := a * b
        case "/"
            if b <> 0
                resultado := a / b
            else
                error("N�o � poss�vel dividir por zero")
        otherwise
            error("Opera��o inv�lida")

    // Exibe o resultado
    write("O resultado de ", a, " ", operacao, " ", b, " � igual a ", resultado)

return
