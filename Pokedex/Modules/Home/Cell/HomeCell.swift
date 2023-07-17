//
//  HomeCell.swift
//  Pokedex
//
//  Created by Hector Climaco on 15/07/23.
//

import UIKit
import SDWebImage

class HomeCell: UITableViewCell {
    
    static let identifier:String = "HomeCell"
    
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var idLbl: UILabel!
    
    
    var pokemon: Home.Pokemon! {
        didSet {
            configureView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureView() {
        self.selectionStyle = .none
        
        if let pokeImgURL = self.pokemon.sprites?.other?.officialArtwork?.frontDefault {
            self.pokemonImg.sd_setImage(with: URL(string: pokeImgURL), placeholderImage: UIImage(named: "Pokeball"))
        }
        
        let attributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        nameLbl.attributedText = pokemon.name?.capitalized.toNSAttributedString(attributes: attributes)
        
        if let type = pokemon.types.first??.type?.name,
           let image = UIImage(named: "Type_Icon_\(type.capitalized)") {
                typeImageView.image = image
        }
        
        
        idLbl.attributedText = pokemon.id.toIdFormat().toNSAttributedString(attributes: attributes)
    }
}
