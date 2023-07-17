//
//  SigninPresenter.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//

import UIKit

protocol SigninPresentationLogic {
    func presentError(error: SigninModel.ErrorSignIn)
    func presentSuccesSignIn()
}

class SigninPresenter: SigninPresentationLogic {
    
    var view: SigninDisplayLogic?
    
    func presentError(error: SigninModel.ErrorSignIn) {
        view?.displayError(error: error.message)
    }
    
    func presentSuccesSignIn() {
        view?.displaySuccess()
    }
    
}
