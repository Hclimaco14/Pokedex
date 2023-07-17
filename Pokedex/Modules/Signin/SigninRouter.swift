//
//  SigninRouter.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//


import UIKit

protocol SigninRoutingLogic {
    func goToHome()
}

class SigninRouter: SigninRoutingLogic {
    
    var view: SigninViewController?
    
    func goToHome() {
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
}
