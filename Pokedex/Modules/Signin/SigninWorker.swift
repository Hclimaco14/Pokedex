//
//  SigninWorker.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//

import UIKit

class SigninWorker {
    
    func saveUser(id:String, username: String) {
        let user = SigninModel.User(id: id, username: username, registerDate: Date())
        DefaultManager.shared.saveUser(user: user)
    }
    
}
