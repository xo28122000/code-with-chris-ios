//
//  ViewController.swift
//  Match View
//
//  Created by J on 1/10/20.
//  Copyright © 2020 Jainam Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = CardModel()
    var cardArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardArray = model.getards()
    }


}

