/*
 # 2️⃣ Calculadora de partidas Rankeadas
**O Que deve ser utilizado**

- Variáveis
- Operadores
- Laços de repetição
- Estruturas de decisões
- Funções

## Objetivo:

Crie uma função que recebe como parâmetro a quantidade de vitórias e derrotas de um jogador,
depois disso retorne o resultado para uma variável, o saldo de Rankeadas deve ser feito através do calculo (vitórias - derrotas)

Se vitórias for menor do que 10 = Ferro
Se vitórias for entre 11 e 20 = Bronze
Se vitórias for entre 21 e 50 = Prata
Se vitórias for entre 51 e 80 = Ouro
Se vitórias for entre 81 e 90 = Diamante
Se vitórias for entre 91 e 100= Lendário
Se vitórias for maior ou igual a 101 = Imortal

## Saída

Ao final deve se exibir uma mensagem:
"O Herói tem de saldo de **{saldoVitorias}** está no nível de **{nivel}**"
*/

const prompt = require('prompt-sync')();

console.log()
console.log("********** Consulta de partidas rankeadas. ********** ");
console.log()

const jogadores = [];

const MENSAGEM_OPCAO_INICIAL = "Digite 1 para consulta de ranking ou 2 para sair. "
const MENSAGEM_VITORIAS = "Digite o número de vitorias do jogador. "
const MENSAGEM_DERROTAS = "Digite o número de derrotas do jogador. "

let opcao = parseInt(prompt(MENSAGEM_OPCAO_INICIAL));
console.log()
while (opcao === 1) {
    if (isNaN(opcao)) {
        console.log("Opção inválida, digite um número inteiro. ")
        opcao = parseInt(prompt(MENSAGEM_OPCAO_INICIAL))
        continue;
    } else if (opcao === 2) {
        console.log("Consulta finalizada. Jogadores rankeados:  ");
    }
    console.log()

    const nome = prompt("Digite o nome do jogador para consultar.  ")

    const vitorias = parseInt(prompt(MENSAGEM_VITORIAS))
    if (isNaN(vitorias)) {
        console.log("Opção inválida, digite um número inteiro para vitórias. ")
        continue;
    }

    const derrotas = parseInt(prompt(MENSAGEM_DERROTAS))
    if (isNaN(derrotas)) {
        console.log("Opção inválida, digite um número inteiro para derrotas. ")
        continue;
    }
    console.log()
    const saldoVitorias = vitorias - derrotas
    const nivel = definirNivel(saldoVitorias)
    jogadores.push({
        nome: nome,
        saldoVitorias: saldoVitorias,
        nivel: nivel
    })

    opcao = parseInt(prompt("Digite 1 para continuar consulta ou 2 para finalizar. "))
    console.log()
}
function definirNivel(saldoVitorias) {
    if (saldoVitorias < 10) {
        return "Ferro";
    } else if (saldoVitorias >= 11 && saldoVitorias <= 20) {
        return "Bronze";
    } else if (saldoVitorias >= 21 && saldoVitorias <= 50) {
        return "Prata";
    } else if (saldoVitorias >= 51 && saldoVitorias <= 80) {
        return "Ouro";
    } else if (saldoVitorias >= 81 && saldoVitorias <= 90) {
        return "Diamante";
    } else if (saldoVitorias >= 91 && saldoVitorias <= 100) {
        return "Lendário";
    } else {
        return "Imortal";
    }
}
if (opcao === 2) {
    console.log("Saindo do consulor de ranking.")
}
console.log()
jogadores.forEach(jogador => {
    console.log(`O jogador: ${jogador.nome}, tem um saldo de ${jogador.saldoVitorias} vitórias e está no nivel ${jogador.nivel}.`)
})
console.log()