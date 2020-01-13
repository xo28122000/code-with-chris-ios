//
//  ViewController.swift
//  Match View
//
//  Created by J on 1/10/20.
//  Copyright © 2020 Jainam Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var model = CardModel()
    var cardArray = [Card]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
    }

    
    //    MARK: UIcollectionView Protocol methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
      
        
        let card = cardArray[indexPath.row]
        
        if(!card.isFlipped){
              cell.flip()
            card.isFlipped = true
        }
        else{
            cell.flipBack()
            card.isFlipped = false
        }
        
    }
    

}

