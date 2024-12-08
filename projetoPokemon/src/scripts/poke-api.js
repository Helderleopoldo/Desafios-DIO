

const pokeApi = {}

function convertPokeApiToPokemon(pokeDetails) {
    const pokemon = new Pokemon()
    pokemon.number = pokeDetails.id
    pokemon.name = pokeDetails.name

    const types = pokeDetails.types.map((typeSlot) => typeSlot.type.name)
    const [type] = types
    pokemon.types = types
    pokemon.type = type

    const stats = pokeDetails.stats.map((statSlot) => {
        return {
            name: statSlot.stat.name,
            base_stat: statSlot.base_stat
        }
    })

    pokemon.stats = stats.slice(0, 3)

    const abilities = pokeDetails.abilities.map((abilitieSlot) => abilitieSlot.ability.name)
    const [ability] = abilities
    pokemon.abilities = abilities
    pokemon.ability = ability

    pokemon.photo = pokeDetails.sprites.other.dream_world.front_default

    return pokemon
}

// puxa os detalhes dos pokemons da API
pokeApi.getPokemonsDetail = (pokemon) => {
    return fetch(pokemon.url)
        .then((response) => response.json())
        .then(convertPokeApiToPokemon)
}

// acessa e retorna dados da API
pokeApi.getPokemons = (offset, limit) => {
    const url = `https://pokeapi.co/api/v2/pokemon?offset=${offset}&limit=${limit}`
    return fetch(url) //retorna o result da API
        // Declaração mais limpa com arrowFunction (=>)
        .then((response) => response.json()) //convertendo o objeto HTTP-response num objeto JSON para manipular posteriormente.
        .then((jsonBody) => jsonBody.results) // Retorno do primeiro then para manipulação.
        .then((pokemons) => pokemons.map(pokeApi.getPokemonsDetail))
        .then((detailRequests) => Promise.all(detailRequests))
        .then((pokemonsDetails) => pokemonsDetails)

        .catch((error) => console.error(error))
}