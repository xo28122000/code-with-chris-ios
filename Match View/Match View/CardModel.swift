//
//  CardModel.swift
//  Match View
//
//  Created by J on 1/11/20.
//  Copyright © 2020 Jainam Shah. All rights reserved.
//

import Foundation

class CardModel{
    func getards()->[Card]{
        var generatedCardArray = [Card]()
        
        for _ in 1...8{
            let randomNumber = arc4random_uniform(13) + 1
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            generatedCardArray.append(cardOne)
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            generatedCardArray.append(cardTwo)
        }
        
        
        return generatedCardArray
    }
}
