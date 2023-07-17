//
//  DetailPresenter.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//

import UIKit

protocol DetailPresentationLogic {
    func presentSomething()
}

class DetailPresenter: DetailPresentationLogic {
    
    var view: DetailDisplayLogic?
    
    func presentSomething() {
        
    }
}
