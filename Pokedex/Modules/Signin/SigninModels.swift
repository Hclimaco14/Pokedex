//
//  SigninModels.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//

import UIKit

enum SigninModel {
    
    enum ErrorSignIn: Error {
        case emptyFields
        case badEmailFormat
        case saveCredentials
        case accessWithGoogle
        
        var message:String{
            switch self {
            case .emptyFields:
                return "Campos Vacios"
            case .badEmailFormat:
                return "Formato de Email incorrecto"
            case .saveCredentials:
                return "Error al guarda acceso con Google"
            case .accessWithGoogle:
                return "Error en acceso con Google"
            }
        }
    }
    
    struct User: Codable {
        var id: String
        var username: String
        var registerDate: Date
    }
}
