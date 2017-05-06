//
//  pokemon.swift
//  Pokedex
//
//  Created by Radosław Stelmasiak on 20.04.2017.
//  Copyright © 2017 Radosław Stelmasiak. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _name:String!
    private var _pokemonId:Int!
    private var _description:String!
    private var _type:String!
    private var _height:String!
    private var _weight:String!
    private var _defense:String!
    private var _attack:String!
    private var _pokemonURL:String!
    
    // next evo
    private var _evolutionTxt:String!
    private var _evolutionID:String!
    private var _evolutionName:String!
    private var _evolutionLVL:String!
    
    var evolutionID:String{
        if _evolutionID == nil{
            self._evolutionID = ""
        }
        return self._evolutionID
    }
    
    var evolutionName:String{
        if _evolutionName == nil{
            self._evolutionName = ""
        }
        return self._evolutionName
    }
    
    var evolutionLVL:String{
        if _evolutionLVL == nil{
            self._evolutionLVL = ""
        }
        return self._evolutionLVL
    }
    
    var attack:String{
        if _attack == nil{
            self._attack = ""
        }
        return self._attack
    }
    
    var defense:String{
        if _defense == nil{
            self._defense = ""
        }
        return self._defense
    }
    
    var type:String{
        if _type == nil{
            self._type = ""
        }
        return self._type
    }
    
    var description1:String{
        
        if _description == nil{
            self._description = ""
        }
        return self._description
    }
    
    var weight:String{
        if _weight == nil{
            self._weight = ""
        }
        return self._weight
    }
    
    var height:String{
        if _height == nil {
            self._height = ""
        }
        return _height
    }
    
    var evolutionTxt:String{
        if _evolutionTxt == nil{
            self._evolutionTxt = ""
        }
        return self._evolutionTxt
    }
    
    var name: String {
        return _name
    }
    
    var pokemonID: Int {
        return _pokemonId
    }
    
    init(name: String, pokedexId:Int) {
        self._name = name
        self._pokemonId = pokedexId
        
        self._pokemonURL = "\(URL_POKEMON)\(pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            
            if let dictionary = response.value as? Dictionary<String,AnyObject>{
                
                if let weight = dictionary["weight"] as? String{
                    self._weight = weight
                }
                
                if let attack = dictionary["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dictionary["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                if let height = dictionary["height"] as? String{
                    self._height = height
                }
                
                if let types = dictionary["types"] as? [Dictionary<String,String>], types.count > 0 {
                    
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    if types.count > 1{
                        for typ in 1..<types.count{
                            if let name = types[typ]["name"]{
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                    
                }
                else{
                    self._type = ""
                }
                
                if let descArr = dictionary["descriptions"] as? [Dictionary<String,String>], descArr.count > 0{
                    
                    if let url = descArr[0]["resource_uri"]{
                        let descUrl = "\(URL_API)\(url)"
                        
                        
                        Alamofire.request(descUrl).responseJSON(completionHandler: { (responseDescription) in
                            
                            if let dictionaryDescription = responseDescription.value as? Dictionary<String,AnyObject>{

                                if let desc = dictionaryDescription["description"] as? String{
                                    self._description = desc
                                }
                            }
                            completed()
                        })
                    }
                    
                }else{
                    self._description = ""
                }
                
                if let evolutions = dictionary["evolutions"] as? [Dictionary<String,AnyObject>], evolutions.count > 0{
                    
                    if let nextEvolution = evolutions[0]["to"] as? String{
                        
                        if nextEvolution.range(of: "mega") == nil{
                            
                            self._evolutionName = nextEvolution
                            
                            if let urlEvo = evolutions[0]["resource_uri"] as? String{
                                
                                let extractEvoNumber = urlEvo.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let evoID = extractEvoNumber.replacingOccurrences(of: "/", with: "")
                                self._evolutionID = evoID
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                    if let evoMethod = evolutions[0]["method"] as? String{
                        if evoMethod == "level_up"{
                            if let evoLvl = evolutions[0]["level"] as? Int{
                                self._evolutionLVL = "\(evoLvl)"
                            }
                        }
                        else if evoMethod == "other"{
                            if let evoOther = evolutions[0]["detail"] as? String{
                                self._evolutionLVL = evoOther
                            }
                        }
                        else if evoMethod == "stone"{
                            self._evolutionLVL = ""
                    }
                        else{
                            self._evolutionLVL = ""
                        }
                    
                    
                }
                
                completed()
                
            
            }
        }
        
    }
    
    }
}
