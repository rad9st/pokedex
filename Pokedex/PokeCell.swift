//
//  PokeCell.swift
//  Pokedex
//
//  Created by Radosław Stelmasiak on 20.04.2017.
//  Copyright © 2017 Radosław Stelmasiak. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        nameLbl.text = pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemon.pokemonID)")
    }
    
    
}
