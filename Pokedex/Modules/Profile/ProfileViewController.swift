//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Hector Climaco on 16/07/23.
//  
//

import UIKit

protocol ProfileDisplayLogic {
    func displayLogout()
}

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var logoutImageView: UIImageView!
    @IBOutlet weak var memberSinceLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    // MARK: - Variables
    
    var interactor: ProfileBusinessLogic?
    var router: ProfileRoutingLogic?
    
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
        configuereView()
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = ProfileInteractor()
        let presenter       = ProfilePresenter()
        let router          = ProfileRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    func configuereView() {
        self.title = "Perfil"
        self.view.backgroundColor = Coulors.baseRed
        if let date = DefaultManager.shared.getUser()?.registerDate {
            let df = DateFormatter()
            df.dateFormat = "dd 'de' MMM 'del' yyyy"
            df.locale = Locale(identifier: "es_MX")
            let timeStr = "Miembro desde: \(df.string(from:date).lowercased())"
            
            self.memberSinceLabel.attributedText = timeStr.toNSAttributedString(attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: Coulors.white])
        }
        
        self.logoutButton.titleLabel?.attributedText = "Logout".toNSAttributedString(attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : Coulors.white])
        
        self.logoutButton.corner(10)
        self.logoutButton.backgroundColor = Coulors.yellow
        
    }
    
    // MARK: - Private
    
    
    // MARK: - Actions
    @IBAction func Logout(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "¿Esta seguro que desea salir?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Aceptar", style: .default){ _ in
            self.interactor?.logout()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    
}

extension ProfileViewController: ProfileDisplayLogic {
    func displayLogout() {
        router?.goToSignIn()
    }
}
