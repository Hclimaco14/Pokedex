//
//  LoadingViewController.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    
    var animation:AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.applyGradient(colours: [Coulors.lightBlue, Coulors.darkBlue])
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadLottie()
    }
    
    func loadLottie() {
        self.animationView.backgroundColor = .clear
        let animation = AnimationView(name: "pokeballLottie")
        animation.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.play()
        animation.backgroundBehavior = .continuePlaying
        self.animationView.addSubview(animation)
        self.animation = animation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            if DefaultManager.shared.getUser() != nil {
                self.goToHome()
            } else {
                self.goToSignIn()
            }
        })
    }
    
    func goToHome() {
        self.animation?.stop()
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
    func goToSignIn() {
        self.animation?.stop()
        let vc = SigninViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
    

}
