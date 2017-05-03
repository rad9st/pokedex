//
//  pokemon.swift
//  Pokedex
//
//  Created by Radosław Stelmasiak on 20.04.2017.
//  Copyright © 2017 Radosław Stelmasiak. All rights reserved.
//

import Foundation

class Pokemon{
    
    private var _name:String!
    private var _pokemonId:Int!
    private var _description:String!
    private var _type:String!
    private var _height:String!
    private var _weight:String!
    private var _defense:String!
    private var _attakc:String!
    private var _evolutionTxt:String!
    
    
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
