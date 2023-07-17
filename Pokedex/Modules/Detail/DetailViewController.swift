//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//  
//

import UIKit
import SDWebImage

protocol DetailDisplayLogic {
    func displaySomething()
}

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonXPLbl: UILabel!
    @IBOutlet weak var pokemonHPLbl: UILabel!
    @IBOutlet weak var pokemonTypeLbl: UILabel!
    @IBOutlet weak var pokemonTypeDescriptionLbl: UILabel!
    @IBOutlet weak var pokemonHeightLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokemonRandomMoveValueLbl: UILabel!
    @IBOutlet weak var pokemonAbilitiesValueLbl: UILabel!
    
    @IBOutlet weak var pokemonAttackValueLbl: UILabel!
    @IBOutlet weak var pokemonDefenseValueLbl: UILabel!
    @IBOutlet weak var pokemonSpecialAttackValueLbl: UILabel!
    @IBOutlet weak var pokemonSpecialDefenseValueLbl: UILabel!
    @IBOutlet weak var pokemonSpeedValueLbl: UILabel!
    
    // MARK: - Variables
    var pokemon: Home.Pokemon?
    
    var interactor: DetailBusinessLogic?
    var router: DetailRoutingLogic?
    
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
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setColorNavigation(backgroud: Coulors.baseRed, titleText: Coulors.white)
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = DetailInteractor()
        let presenter       = DetailPresenter()
        let router          = DetailRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    // MARK: - Private
    
    
    // MARK: - Actions
    func loadData(){
        if let safePokemon = pokemon{
            if let pokeName = safePokemon.name?.capitalizingFirstLetter(){
                self.title = pokeName
            }
            
            if let pokeImgURL = safePokemon.sprites?.other?.officialArtwork?.frontDefault{
                self.pokemonImg.sd_setImage(with: URL(string: pokeImgURL), placeholderImage: UIImage(named: "Pokeball"))
            } else if let defaultURL = safePokemon.sprites?.frontDefault{
                self.pokemonImg.sd_setImage(with: URL(string: defaultURL), placeholderImage: UIImage(named: "Pokeball"))
            }
            
            //        stats
            if let pokeHp = safePokemon.stats?.filter({ $0.stat?.name == "hp" }) {
                pokemonHPLbl.text = "\(pokeHp[0].baseStat ?? 0) HP"
            }
            if let pokeAttack = safePokemon.stats?.filter({ $0.stat?.name == "attack" }) {
                pokemonAttackValueLbl.text = pokeAttack[0].baseStat?.description
            }
            if let pokeDefense = safePokemon.stats?.filter({ $0.stat?.name == "defense" }) {
                pokemonDefenseValueLbl.text = pokeDefense[0].baseStat?.description
            }
            if let pokeSpecAttack = safePokemon.stats?.filter({$0.stat?.name == "special-attack"}) {
                pokemonSpecialAttackValueLbl.text = pokeSpecAttack[0].baseStat?.description
            }
            if let pokeSpecDefense = safePokemon.stats?.filter({$0.stat?.name == "special-defense"}) {
                pokemonSpecialDefenseValueLbl.text = pokeSpecDefense[0].baseStat?.description
            }
            if let pokeSpecDefense = safePokemon.stats?.filter({$0.stat?.name == "speed"}) {
                pokemonSpeedValueLbl.text = pokeSpecDefense[0].baseStat?.description
            }
            pokemonXPLbl.text = "\(safePokemon.baseExperience ?? 0) XP"
            //type
            if let type = safePokemon.types[0]?.type?.name?.capitalizingFirstLetter() {
                self.pokemonImg.backgroundColor = UIColor(named: type)
                self.pokemonImg.corner(10)
                pokemonTypeLbl.text = type
            }
            
            if safePokemon.types.count > 1,let typeDescription = safePokemon.types[1]?.type?.name?.capitalizingFirstLetter() {
                pokemonTypeDescriptionLbl.text = typeDescription
            } else {
                pokemonTypeDescriptionLbl.isHidden = true
            }
            //size
            pokemonHeightLbl.text = "\(String(safePokemon.height!)), m"
            pokemonWeightLbl.text = "\(String(safePokemon.weight!)), kg"
            //Abilities
            pokemonAbilitiesValueLbl.text = safePokemon.abilities[0]?.ability?.name?.capitalizingFirstLetter()
            //Random Move
            if let randomMove = safePokemon.moves?.randomElement(){
                pokemonRandomMoveValueLbl.text = randomMove.move?.name?.capitalizingFirstLetter()
            }

        }
    }
    
}

extension DetailViewController: DetailDisplayLogic {
    func displaySomething() {}
}
