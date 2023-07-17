//
//  UserDefaultManager.swift
//  Pokedex
//
//  Created by Hector Climaco on 17/07/23.
//

import Foundation

enum DefaultKeys:String {
    case suiteName =  "pokedex-defaults"
    case pokemonList = "pokemons"
    case user = "localUser"
}


class DefaultManager {

    private var Usdefaults: UserDefaults?
    
    public static let shared = DefaultManager()
    
    init() {
        self.Usdefaults = UserDefaults(suiteName: DefaultKeys.suiteName.rawValue)
    }
    
    func clear() {
        guard let defaults = self.Usdefaults else { return }
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func saveUser(user: SigninModel.User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
           guard Usdefaults != nil else { return }
            Usdefaults?.set(encoded, forKey: DefaultKeys.user.rawValue)
        }
    }
    
    func getUser() -> SigninModel.User? {
        guard Usdefaults != nil else { return nil }
        if let userData = Usdefaults?.object(forKey: DefaultKeys.user.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let lead = try? decoder.decode(SigninModel.User.self, from: userData) {
                return lead
            }
            return nil
        }
        return nil
    }
    
    func savePokemons(pokemonList:[Home.Pokemon]) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(pokemonList) {
            guard Usdefaults != nil else { return false }
            Usdefaults?.set(data, forKey: DefaultKeys.pokemonList.rawValue)
            return true
        }
        return false
    }
    
    func getPokemons() -> [Home.Pokemon] {
        guard Usdefaults != nil else { return [] }
        if let pokemonsData = Usdefaults?.object(forKey: DefaultKeys.pokemonList.rawValue) as? Data {
            let decoder = PropertyListDecoder()
            if let pokemons = try? decoder.decode([Home.Pokemon].self, from: pokemonsData) {
                return pokemons
            }
            return []
        }
        return []
    }
    
    
}
