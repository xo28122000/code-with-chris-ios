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
    
    var firstFlippedCardIndex: IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 10 * 1000
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }

    //    MARK: Timer methods
    
    @objc func timerElapsed(){
        
        milliseconds -= 1
        
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        timerLabel.text =  "Time Remaining \(seconds)"
        
        if(milliseconds <= 0){
            timer?.invalidate()
            
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
        }
    }
    
    //    MARK: UIcollectionView Protocol methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
//        if(card.isMatched){
//            cell.remove()
//        }
//
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
      
        
        let card = cardArray[indexPath.row]
        
        if(!card.isFlipped && !card.isMatched){
            cell.flip()
            card.isFlipped = true
            if(firstFlippedCardIndex == nil){
                firstFlippedCardIndex = indexPath
            }
            else{
                checkForMtches(indexPath)
            }
            
        }
        else{
//            if card is already flipped
        }
        
    }
    
    
    
    //    MARK: Game logic
    
    func checkForMtches(_ secondFlippedCardIndex: IndexPath ){
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if( cardOne.imageName == cardTwo.imageName ){
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()
        }
        else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        
//         solving the problem of cell going out of sectioon and then matched
        if(cardOneCell == nil){
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        
        firstFlippedCardIndex = nil
        
    }
    
    
    func checkGameEnded(){
        
        var isWon = true
        var title:String
        var message:String
        
        for card in cardArray{
            if(card.isMatched == false){
                isWon = false
                break
            }
        }
        
        if(isWon){
            title = "Congratulations!"
            message = "You've WON !!"
            if(milliseconds > 0){
                timer?.invalidate()
            }
        }
        else{
            if(milliseconds > 0){
                return
            }
            else{
                title = "Game Over..."
                message = "You Lost."
            }
        }
        
        showAlert(title, message)
        
    }
    
    
    func showAlert(_ title:String,_ message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    

}//end of view controccler class

