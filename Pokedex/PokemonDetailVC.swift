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
    
    @IBOutlet weak var pokemonName: UILabel!
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
    @IBOutlet weak var nextEvoLbn: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonName.text = pokemonIn.name.capitalized
        let pokemonMainImage = UIImage(named: "\(pokemonIn.pokemonID)")
        pokedexIdLabel.text = "\(pokemonIn.pokemonID)"
        
        print(pokemonIn.pokemonID)
        
        mainImage.image = pokemonMainImage
        
        
        pokemonIn.downloadPokemonDetails {
            self.updateUI()
            
            
        }

    }
    
    func updateUI(){
        heightLabel.text = pokemonIn.height
        weightLabel.text = pokemonIn.weight
        attackLabel.text = pokemonIn.attack
        defenseLabel.text = pokemonIn.defense
        typeLabel.text = pokemonIn.type
        descriptionLabel.text = pokemonIn.description1
        //
        evoImage.image = UIImage(named: "\(pokemonIn.evolutionID)")
        
        if pokemonIn.evolutionName != ""{
            nextEvoLbn.text = "Next evolution \(pokemonIn.evolutionName) condition or LVL: \(pokemonIn.evolutionLVL)"
        }
        else{
            nextEvoLbn.text = "There is no evolution"
        }
        
        
    }
    
    @IBAction func backBtnToPokeList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    
    

}
