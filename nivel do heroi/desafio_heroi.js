

/* # 1️⃣ Desafio Classificador de nível de Herói

**O Que deve ser utilizado**

- Variáveis
- Operadores
- Laços de repetição
- Estruturas de decisões

## Objetivo

Crie uma variável para armazenar o nome e a quantidade de experiência (XP) de um herói, depois utilize uma estrutura de decisão para apresentar alguma das mensagens abaixo:

Se XP for menor do que 1.000 = Ferro
Se XP for entre 1.001 e 2.000 = Bronze
Se XP for entre 2.001 e 5.000 = Prata
Se XP for entre 5.001 e 7.000 = Ouro
Se XP for entre 7.001 e 8.000 = Platina
Se XP for entre 8.001 e 9.000 = Ascendente
Se XP for entre 9.001 e 10.000= Imortal
Se XP for maior ou igual a 10.001 = Radiante

## Saída

Ao final deve se exibir uma mensagem:
"O Herói de nome **{nome}** está no nível de **{nivel}**"  */

// função para executar entrada direto no terminal
const prompt = require('prompt-sync')();
// entrada de usuário para quantidade de herois
let n = parseInt(prompt("Digite o número de heróis que deseja comparar: "));
let nivel_heroi = []; // Array para armazenar os heróis e seus níveis
for (let i = 0; i < n; i++) {
    // entrada do usuário para armazenamento dos heróis
    let heroiInput = prompt("Digite os heróis no formato (nome:nivel) separados por vírgula: ");
    let herois = heroiInput.split(", ");

    // forEach para tratamento da entrada do usuário
    herois.forEach(heroi => {
        let [nome, experiencia] = heroi.split(":");
        experiencia = parseInt(experiencia);

        // tratamento de erro de usuário
        if (!nome || isNaN(experiencia)) {
            console.log("Entrada inválida. Por favor, insira no formato (nome:nivel).");
            return;
        }
        // processamento de dados
        if (experiencia < 1000) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Ferro"`);
        } else if (experiencia >= 1001 && experiencia <= 2000) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Bronze"`);
        } else if (experiencia >= 2001 && experiencia <= 5000) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Prata"`);
        } else if (experiencia >= 5001 && experiencia <= 7000) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Ouro"`);
        } else if (experiencia >= 7001 && experiencia <= 8000) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Platina"`);
        } else if (experiencia >= 8001 && experiencia <= 9000) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Ascendente"`);
        } else if (experiencia >= 9001 && experiencia <= 10000) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Imortal"`);
        } else if (experiencia >= 10001) {
            nivel_heroi.push(`O herói ${nome}: tem ${experiencia} é nivel "Radiante"`);
        }
    })
}
// saida de dados
console.log(nivel_heroi);

