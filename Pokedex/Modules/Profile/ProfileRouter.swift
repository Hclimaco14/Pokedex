//
//  ProfileRouter.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//  
//


import UIKit

protocol ProfileRoutingLogic {
    func goToSignIn()
}

class ProfileRouter: ProfileRoutingLogic {
    
    var view: ProfileViewController?
    
    func goToSignIn() {
        let vc = SigninViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
}
