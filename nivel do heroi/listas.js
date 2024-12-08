const prompt = require('prompt-sync')();
let dados = prompt().split(", ");
let resultado = []
dados.forEach(item => {
    let [nome, quantidade] = item.split(":");
    quantidade = parseInt(quantidade);
    if (quantidade < 5) {
        resultado.push(`${nome}: Baixo`)
    } else {
        resultado.push(`${nome}: Adequado`)
    }
});
console.log(resultado.join(", "));

