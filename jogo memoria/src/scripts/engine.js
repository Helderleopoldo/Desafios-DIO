const emojis = [
    "🦁", "🦁", "🦊", "🦊", "🦝", "🦝", "🐶", "🐶", "🐱", "🐱",
    "🐯", "🐯", "🐷", "🐷", "🐮", "🐮", "🐵", "🐵", "🐺", "🐺"
]

let openCards = []

function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}
shuffleArray(emojis)

for (let i = 0; i < emojis.length; i++) {
    let box = document.createElement("div")
    box.className = "card"
    box.innerHTML = emojis[i]
    document.querySelector(".game").appendChild(box)
}