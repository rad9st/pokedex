//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Radosław Stelmasiak on 26.04.2017.
//  Copyright © 2017 Radosław Stelmasiak. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemonIn: Pokemon!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evoImage: UIImageView!
    @IBOutlet weak var evoDescriptionLbn: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backBtnToPokeList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    
    

}
