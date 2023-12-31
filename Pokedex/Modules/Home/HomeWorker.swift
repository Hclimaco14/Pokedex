//
//  HomeWorker.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//

import UIKit

class HomeWorker {
    
    private let serviceMager: ServiceMaganerProtocol
    
    public init(serviceManager: ServiceMaganerProtocol = ServicesManager()) {
        self.serviceMager = serviceManager
    }
    
    func getList(request: Home.Request.PokemonList,
                 _ result: @escaping(Result<Home.Response.PokemonList, RequestError>) -> Void)  {
        
        let urlString = Constants.baseURL + "pokemon?offset=\(request.startValue)&limit=\(request.paginationSize)"
        guard let requestURL  = URL(string: urlString) else { return }
        
        serviceMager.fetchRequest(with: requestURL, completion: result)
    }
    
    func fetchPokemon(request: Home.Request.Pokemon,
                      _ result: @escaping(Result<Home.Pokemon, RequestError>) -> Void) {
        
        guard let url = request.url,let requestURL  = URL(string: url) else { return }
        
        serviceMager.fetchRequest(with: requestURL, completion: result)
    }
    
    func savePokemons(pokemons:[Home.Pokemon]) {
        let _ = DefaultManager.shared.savePokemons(pokemonList: pokemons)
    }
    
    func getPokemons() -> [Home.Pokemon] {
        return DefaultManager.shared.getPokemons()
    }
}
