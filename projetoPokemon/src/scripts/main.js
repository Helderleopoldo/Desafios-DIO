
const pokemonList = document.getElementById("pokemonList")
const loadMoreButton = document.getElementById("loadMoreButton")

const maxRecords = 151
const limit = 8
let offset = 0


function convertPokemonToLi(pokemon) {
    return `
         <li class="pokemon ${pokemon.type}">
            <div class="pokemon-title">                                               
                <h3 class="name">${pokemon.name}</h3>
                <span class="number">#${pokemon.number}</span>  
            </div>  
            <div class="info">                                            
                        <ul class="abilities">
                            <span class="abilities-title">Abilities</span>
                            ${pokemon.abilities.map((ability) => `<li>${ability}</li>`).join('')}
                        </ul>                                        
                        <ul class="stats">
                             <span class="stats-title">Stats</span>                          
                            ${pokemon.stats.map((stat) => `<li>${stat.name}: ${stat.base_stat}</li>`).join('')}
                        </ul>                   
            </div>    

            <div class="detail">
                <ol class="types">                    
                    ${pokemon.types.map((type) => `<li class="type ${type}">${type}</li>`).join('')}                                     
                </ol>                
                 <img src="${pokemon.photo}"
                     alt="${pokemon.name}">
            </div>                         
         </li>
    `
}


function addPokemonEvents() {
    const pokemonItems = document.querySelectorAll('.pokemon');

    pokemonItems.forEach(item => {
        item.addEventListener('mouseover', () => {
            const info = item.querySelector('.info');
            const detail = item.querySelector('.detail');
            info.style.display = 'grid';
            detail.style.display = 'none';

        });

        item.addEventListener('mouseout', () => {
            const info = item.querySelector('.info');
            const detail = item.querySelector('.detail');
            info.style.display = 'none';
            detail.style.display = 'flex';
        });
    });
}


function loadPokemonItens(offset, limit) {
    pokeApi.getPokemons(offset, limit).then((pokemons = []) => {
        pokemonList.innerHTML += pokemons.map(convertPokemonToLi).join('')
        addPokemonEvents()
    })
}

loadPokemonItens(offset, limit)

loadMoreButton.addEventListener('click', () => {
    offset += limit
    const qtdRecordsWithNexPage = offset + limit

    if (qtdRecordsWithNexPage >= maxRecords) {
        const newLimit = maxRecords - offset
        loadPokemonItens(offset, newLimit)

        loadMoreButton.parentElement.removeChild(loadMoreButton)
    } else {
        loadPokemonItens(offset, limit)
    }
})


// const newList = pokemons.map((pokemon) => {
//     return convertPokemonToLi(pokemon)
// })
// console.log(newList)

// for tradicional
// const listItens = []
// for (let i = 0; i < pokemons.length; i++) {
//     const pokemon = pokemons[i]
//     listItens.push(convertPokemonToLi(pokemon))
// }




/*  declarando funções de forma tradicional, mais verbosa.
    .then(function (response) {
        response.json().then(function (responseBody) {
            console.log(responseBody)
        })
    })
    .catch(function (error) {
        console.log(error)
    })
    .finally(function () {
        console.log('Requisição concluída.')
    })*/