//
//  Constants.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//

import Foundation
import UIKit

internal struct Constants {
    static let baseURL = "https://pokeapi.co/api/v2/"
    static let paginationSize = 20
    static let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,}(\\.[A-Za-z]+)?"
}


let spaceUnit    = 8

public enum SpaceUnits {
    public static let zero    = CGFloat(0)
    public static let quarter = CGFloat(spaceUnit/4)
    public static let half    = CGFloat(spaceUnit/2)
    public static let one     = CGFloat(spaceUnit)
    public static let two     = CGFloat(spaceUnit*2)
    public static let three   = CGFloat(spaceUnit*3)
    public static let four   = CGFloat(spaceUnit*4)
    public static let five    = CGFloat(spaceUnit*5)
    public static let ten     = CGFloat(spaceUnit*10)
}

enum Coulors {
    static let yellow = UIColor(named: "Yellow") ??  UIColor(red: 249/255, green: 198/255, blue: 35/255, alpha: 1)
    static let white =  UIColor.white
    static let lightBlue = UIColor(named: "LightBlue") ??  UIColor(red: 92/255 , green: 152/255 , blue: 219/255, alpha: 1)
    static let darkBlue = UIColor(named: "DarkBlue") ?? UIColor(red: 14/255 , green: 67/255 , blue: 126/255, alpha: 1)
    static let baseRed =  UIColor(named: "BaseRed") ?? UIColor(red: 238/255 , green: 82/255 , blue: 80/255, alpha: 1)
}
