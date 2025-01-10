
#include "totvs.ch"


user function calculadora()
local a, b, operacao, resultado

    a := 0
    b := 0
    operacao := ""
    resultado := 0

    // Entrada de dados
    a := read("Digite o primeiro número: ")
    b := read("Digite o segundo número: ")
    operacao := read("Digite a operação (+, -, *, /): ")

    // Realiza a operação selecionada
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
                error("Não é possível dividir por zero")
        otherwise
            error("Operação inválida")

    // Exibe o resultado
    write("O resultado de ", a, " ", operacao, " ", b, " é igual a ", resultado)

return
