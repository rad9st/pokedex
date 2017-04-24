//
//  ViewController.swift
//  Pokedex
//
//  Created by Radosław Stelmasiak on 19.04.2017.
//  Copyright © 2017 Radosław Stelmasiak. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
 
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemons = [Pokemon]()
    var filtredPokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        
        let path = Bundle.main.path(forResource: "pokTitleXY", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do{
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let pokemon = Pokemon(name: name, pokedexId: pokeId)
                pokemons.append(pokemon)
                
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            let pokemon: Pokemon!
            
            if inSearchMode {
                pokemon = filtredPokemons[indexPath.row]
                cell.configureCell(pokemon)
            }
            else{
                pokemon = pokemons[indexPath.row]
                cell.configureCell(pokemon)
            }
            
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
        //ustawienie wielkości komórki
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
        }
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
        }
        else{
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filtredPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
        
    }
    
}

