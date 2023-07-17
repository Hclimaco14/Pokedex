//
//  ProfileWorker.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//  
//

import UIKit
import FirebaseAuth

class ProfileWorker {
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        DefaultManager.shared.clear()
    }
    
}
