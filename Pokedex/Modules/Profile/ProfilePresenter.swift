//
//  ProfilePresenter.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//  
//

import UIKit

protocol ProfilePresentationLogic {
    func presentLogout()
}

class ProfilePresenter: ProfilePresentationLogic {
    
    var view: ProfileDisplayLogic?
    
    func presentLogout() {
        
        view?.displayLogout()
    }
}
