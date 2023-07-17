//
//  DetailRouter.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//  
//


import UIKit

protocol DetailRoutingLogic {
    func routeToSomewhere()
}

class DetailRouter: DetailRoutingLogic {
    
    var view: DetailViewController?
    
    func routeToSomewhere() {
        
    }
    
}
