/* # 1️⃣ Desafio Classificador de nível de Herói
versão com console.table() para melhor organização e exibição dos dados
*/

// função para executar entrada direto no terminal
//const prompt = require('prompt-sync')();

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
        // tratamento de erro do usuário
        if (!nome || isNaN(experiencia)) {
            console.log("Entrada inválida. Por favor, insira no formato (nome:nivel).");
            return;
        }
        // processando os dados para definição do nivel
        let nivel;
        if (experiencia < 1000) {
            nivel = "Ferro";
        } else if (experiencia >= 1001 && experiencia <= 2000) {
            nivel = "Bronze";
        } else if (experiencia >= 2001 && experiencia <= 5000) {
            nivel = "Prata";
        } else if (experiencia >= 5001 && experiencia <= 7000) {
            nivel = "Ouro";
        } else if (experiencia >= 7001 && experiencia <= 8000) {
            nivel = "Platina";
        } else if (experiencia >= 8001 && experiencia <= 9000) {
            nivel = "Ascendente";
        } else if (experiencia >= 9001 && experiencia <= 10000) {
            nivel = "Imortal";
        } else if (experiencia >= 10001) {
            nivel = "Radiante";
        }

        // Adicionando um objeto com as informações do herói ao array
        nivel_heroi.push({
            Nome: nome,
            Experiencia: experiencia,
            Nivel: nivel
        });
    });
}
// Ordenando os heróis pelo nível de experiência em ordem decrescente
nivel_heroi.sort((a, b) => b.Experiencia - a.Experiencia);

// Adicionando o ranking
nivel_heroi = nivel_heroi.map((heroi, index) => ({
    Ranking: index + 1, // Rank começa em 1
    Nome: heroi.Nome,
    Experiencia: heroi.Experiencia,
    Nivel: heroi.Nivel
}));

// Usando console.table para exibir os resultados de forma mais organizada
//console.table(nivel_heroi);
console.table(nivel_heroi.map(({ Ranking, Nome, Experiencia, Nivel }) => ({ Ranking, Nome, Experiencia, Nivel })));