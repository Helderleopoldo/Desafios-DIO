const emojis = [
    "🦁", "🦁", "🦊", "🦊", "🦝", "🦝", "🐶", "🐶", "🐱", "🐱",
    "🐯", "🐯", "🐷", "🐷", "🐮", "🐮", "🐵", "🐵", "🐺", "🐺"
];

let openCards = [];

const time = document.querySelector(".time");
let timeLeft = 60;
let countdownTimer = setInterval(countdown, 1000);

function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}
shuffleArray(emojis);

for (let i = 0; i < emojis.length; i++) {
    let box = document.createElement("div");
    box.className = "card";
    box.innerHTML = emojis[i];
    box.onclick = handleClick;
    document.querySelector(".game").appendChild(box);
}
function handleClick() {
    if (openCards.length < 2) {
        this.classList.add("boxOpen");
        openCards.push(this);
    }
    if (openCards.length === 2) {
        setTimeout(checkMatch, 600);
    }
};
function checkMatch() {
    if (openCards[0].innerHTML === openCards[1].innerHTML) {
        openCards[0].classList.add("boxMatch");
        openCards[1].classList.add("boxMatch");
    } else {
        openCards[0].classList.remove("boxOpen");
        openCards[1].classList.remove("boxOpen");
    }
    openCards = [];
    if (document.querySelectorAll(".boxMatch").length === emojis.length) {
        alert(" Parabéns, Você venceu!!! ")
        window.location.reload()
    };
};
function countdown() {
    timeLeft--;
    time.textContent = timeLeft;
    if (timeLeft == 0) {
        alert("Game Over, não foi dessa vez!!!");
        clearInterval(countdownTimer);
        window.location.reload();
    };
};


