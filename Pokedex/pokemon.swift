//
//  pokemon.swift
//  Pokedex
//
//  Created by Radosław Stelmasiak on 20.04.2017.
//  Copyright © 2017 Radosław Stelmasiak. All rights reserved.
//

import Foundation

class Pokemon{
    
    fileprivate var _name:String!
    fileprivate var _pokemonId:Int!
    
    var name: String {
        return _name
    }
    
    var pokemonID: Int {
        return _pokemonId
    }
    
    init(name: String, pokedexId:Int) {
        self._name = name
        self._pokemonId = pokedexId
    }
}
