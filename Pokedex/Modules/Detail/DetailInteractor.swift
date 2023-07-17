//
//  DetailInteractor.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//


import Foundation


protocol DetailBusinessLogic {
    func doSomething()
}

class DetailInteractor:  DetailBusinessLogic {
    
    var presenter: DetailPresentationLogic?
    
    let worker = DetailWorker()
    
    func doSomething() {
        presenter?.presentSomething()
    }
    
}
