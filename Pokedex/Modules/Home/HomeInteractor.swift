//
//  HomeInteractor.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//


import Foundation


protocol HomeBusinessLogic {
    func getList(startIndex: Int)
    func findPokemon(value: String)
}

class HomeInteractor: HomeBusinessLogic {
    
    var presenter: HomePresentationLogic?
    
    let worker = HomeWorker()
    
    private var pokemonList:[Home.Pokemon] = []
    
    private var startPaginationValue = 0
    
    let possibleInternetErrors = [
        NSURLErrorNotConnectedToInternet,
        NSURLErrorNetworkConnectionLost,
        NSURLErrorCannotConnectToHost,
        NSURLErrorCannotFindHost,
    ]
    
    func getList(startIndex: Int) {
        let request = Home.Request.PokemonList(startValue: startIndex, paginationSize: Constants.paginationSize)
        
        worker.getList(request: request) { result in
            
            switch result {
            case .success(let list):
            
                self.startPaginationValue = list.next != nil ? startIndex + Constants.paginationSize : -1
                
                for pokemon in list.results {
                    if let name = pokemon?.url {
                        self.fetchPokemon(urlStr: name)
                    }
                }
            case .failure(let error):
                if self.possibleInternetErrors.contains(error.statusCode) {
                    self.presenter?.presentListPokemons(pokemons: self.worker.getPokemons())
                }
            }
        }
    }
    
    func fetchPokemon(urlStr: String) {
        let request = Home.Request.Pokemon(url: urlStr, name: nil)
        worker.fetchPokemon(request: request) { result in
            switch result {
            case .success(let pokemon):
                if !self.pokemonList.contains(where: { $0.id == pokemon.id }) {
                    self.pokemonList.append(pokemon)
                }
                if self.pokemonList.count >= (self.startPaginationValue - 5) {
                    self.sortPokemonListbyID()
                    self.worker.savePokemons(pokemons: self.pokemonList)
                    self.presenter?.presentListPokemons(pokemons: self.pokemonList)
                }
                
            case .failure(let error):
                if self.possibleInternetErrors.contains(error.statusCode){
                    self.presenter?.presentListPokemons(pokemons: self.worker.getPokemons())
                }
            }
        }
    }
    
    func findPokemon(value: String) {
        var pokemons:[Home.Pokemon] = []
        pokemons = pokemonList.filter({ containsValue(for: $0, stringValue: value) })
        presenter?.presentPokemonsFilter(pokemons: pokemons)
    }
    
    fileprivate func containsValue(for pokemon: Home.Pokemon, stringValue: String) -> Bool{
        let name = pokemon.name ?? ""
        if String(pokemon.id).contains(stringValue) || name.lowercased().contains(stringValue.lowercased()) {
            return true
        } else {
            return false
        }
    }
    
    
    
    fileprivate func sortPokemonListbyID() {
        self.pokemonList = self.pokemonList.sorted(by: { $0.id < $1.id})
    }
    
}
