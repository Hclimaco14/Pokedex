//
//  SigninInteractor.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//


import Foundation
import UIKit
import FirebaseAuth
import GoogleSignIn

protocol SigninBusinessLogic {
    func signIn(username:String?, password: String?)
    func signInGoogle(view:UIViewController)
}

class SigninInteractor:  SigninBusinessLogic {
    
    var presenter: SigninPresentationLogic?
    
    let worker = SigninWorker()
    
    
    func signIn(username:String?, password: String?) {
        if let user = username, let pass = password,
           !user.isEmpty, !pass.isEmpty {
            
            if validateEmail(input: user) {
                worker.saveUser(id:UUID().uuidString ,username: user)
                presenter?.presentSuccesSignIn()
            } else {
                presenter?.presentError(error: .badEmailFormat)
            }
            
        } else {
            presenter?.presentError(error: .emptyFields)
        }
    }
    
    func signInGoogle(view:UIViewController) {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { signInResult, error in
            guard error == nil else { return }
            
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else {
                self.presenter?.presentError(error: .saveCredentials)
                return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
         
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    self.presenter?.presentError(error: .accessWithGoogle)
                    return
                }
                self.worker.saveUser(id: result?.user.uid ?? "", username: result?.user.email ?? "")
                self.presenter?.presentSuccesSignIn()
            }
        }
    }
    

    private func validateEmail(input: String) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", Constants.emailRegEx)
        return emailTest.evaluate(with: input)
    }
    
}
