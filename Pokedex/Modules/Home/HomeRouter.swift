//
//  HomeRouter.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//


import UIKit

protocol HomeRoutingLogic {
    func routeToDetail(pokemon: Home.Pokemon)
    func goToLogout()
}

class HomeRouter: HomeRoutingLogic {
    
    var view: HomeViewController?
    
    func routeToDetail(pokemon: Home.Pokemon) {
        let vc = DetailViewController()
        vc.pokemon = pokemon
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToLogout() {
        let vc = ProfileViewController()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
