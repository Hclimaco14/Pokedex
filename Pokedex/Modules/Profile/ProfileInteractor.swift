//
//  ProfileInteractor.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//  
//


import Foundation


protocol ProfileBusinessLogic {
    func logout()
}

class ProfileInteractor:  ProfileBusinessLogic {
    
    var presenter: ProfilePresentationLogic?
    
    let worker = ProfileWorker()
    
    func logout() {
        worker.logout()
        presenter?.presentLogout()
    }
    
}
