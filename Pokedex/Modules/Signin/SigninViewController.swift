//
//  SigninViewController.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//

import UIKit

import GoogleSignIn
import FirebaseCore

protocol SigninDisplayLogic {
    func displayError(error: String)
    func displaySuccess()
}

class SigninViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInButtonGoogle: GIDSignInButton!
    
    // MARK: - Variables
    
    var interactor: SigninBusinessLogic?
    var router: SigninRoutingLogic?
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = SigninInteractor()
        let presenter       = SigninPresenter()
        let router          = SigninRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    func configureView() {
        self.view.applyGradient(colours: [Coulors.lightBlue, Coulors.darkBlue])
        self.signInButton.corner(10)
        
        self.signInButtonGoogle.corner(10)
        
        signInButton.titleLabel?.attributedText = "SignIn".toNSAttributedString(attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),])
        
        signInButton.backgroundColor = Coulors.yellow
        
        let attributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : Coulors.lightBlue]
        userTextField.attributedPlaceholder = "Username".toNSAttributedString(attributes:attributes)
        passwordTextField.attributedPlaceholder = "Password".toNSAttributedString(attributes:attributes)
        passwordTextField.isSecureTextEntry = true
        
        signInButton.addTarget(self, action: #selector(signInAction), for: .touchDown)
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
    }
    
    // MARK: - Private
    func showError(message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    // MARK: - Actions
    
    @objc func signInAction() {
        interactor?.signIn(username: userTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func signIn(sender: Any) {
        self.interactor?.signInGoogle(view: self)
    }
    
}

extension SigninViewController: SigninDisplayLogic {
    func displayError(error: String) {
        showError(message: error)
    }
    
    func displaySuccess() {
        router?.goToHome()
    }
}
