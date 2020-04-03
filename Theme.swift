//
//  Card.swift
//  Test
//
//  Created by Brian Buckley on 3/25/20.
//  Copyright © 2020 Helping Hand Food Pantry. All rights reserved.
//

import Foundation

struct Theme {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
