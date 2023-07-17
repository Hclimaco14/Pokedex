//
//  Extensions.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//

import Foundation
import UIKit


extension UIView {
    func addBlurEffect() {
        DispatchQueue.main.async {
          let blurEffect = UIBlurEffect(style: .light)
          let blurEffectView = UIVisualEffectView(effect: blurEffect)
          blurEffectView.frame = self.bounds

          blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
          self.addSubview(blurEffectView)
        }
      }
      
      @discardableResult
      func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
      }
      
      @discardableResult
      func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
      }
    
    func corner(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
      
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toNSAttributedString(attributes: [NSAttributedString.Key : Any]? ) -> NSAttributedString {
        return NSAttributedString(string: self,attributes: attributes)
    }
}

extension Int {
    func toIdFormat() -> String {
        return "#" + String(format: "%03d", self)
    }
}

extension UIViewController {
    func setColorNavigation(backgroud: UIColor, titleText: UIColor){
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroud
        appearance.titleTextAttributes = [.foregroundColor: titleText,
                                          .font: UIFont.boldSystemFont(ofSize: 24)]
              
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.tintColor = Coulors.white
    }
    
    func setRightButtons( rightButton: UIButton, rightAction: Selector,rightIcon: String) {
        let nav = self.navigationController?.navigationBar
        nav!.isTranslucent = false
        nav!.barTintColor = Coulors.white
        
        rightButton.addTarget(self, action: rightAction, for: UIControl.Event.touchUpInside)
        let rightBarButtonItem: UIBarButtonItem = getCustomRightBarButtonSettings(rightButton, imgNormal: UIImage(named:rightIcon)!)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        if #available(iOS 15, *) {
            let font15 = UIFont.systemFont(ofSize: 15)
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = Coulors.baseRed
            appearance.titleTextAttributes = [ .font : font15, .foregroundColor : Coulors.white]
            nav?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            nav?.shadowImage = UIImage()
            nav?.scrollEdgeAppearance = appearance
            nav?.standardAppearance = appearance
        }
    }
    
    func getCustomRightBarButtonSettings(_ button:UIButton, imgNormal:UIImage,needPading:Bool = true) -> UIBarButtonItem {
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(imgNormal, for: UIControl.State())
        if needPading {
            button.imageEdgeInsets.right   = -(SpaceUnits.two + SpaceUnits.half)
        } else {
            button.imageEdgeInsets.right   = -(SpaceUnits.four)
        }
        button.imageEdgeInsets.bottom = 10.0
        return UIBarButtonItem(customView: button)
    }
}
