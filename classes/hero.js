// Desafio DIO de classes

//const prompt = require('prompt-sync')();

class heroes {
    constructor(name, age, heroClass, attackType) {
        this.name = name
        this.age = age
        this.heroClass = heroClass
        this.attackType = attackType
    }
    describe() {
        console.log(`${this.name}, é um heroi com ${this.age} anos. `)
        console.log(` É um heroi classe: ${this.heroClass} com ataque tipo: ${this.attackType}`)
    }

    attack(attackPower) {
        console.log(`O heroi ${this.name} atacou com ${attackPower} de força usando ${this.attackType}`)
    }
}
console.log(" ********** classificação de Herois ********** ")

const mago = new heroes("Merlin", "350", "mago", "mágia")
const guerreiro = new heroes("Aragorn", "45", "guerreiro", "fisíco")
const ninja = new heroes("Shao-lin", "38", "ninja", "shuriken")
const hunter = new heroes("Dibala", "35", "caçador", "arco e flecha")

console.log()
mago.describe()
mago.attack(1200)

console.log()
guerreiro.describe()
guerreiro.attack(1100)

console.log()
ninja.describe()
ninja.attack(1150)

console.log()
hunter.describe()
hunter.attack(1300)
console.log()

