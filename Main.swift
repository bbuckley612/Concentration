//
//  Main.swift
//  Test
//
//  Created by Brian Buckley on 3/25/20.
//  Copyright © 2020 Helping Hand Food Pantry. All rights reserved.
//

import Foundation

class Main {
    var cards = [Card]()
    var cardNum = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func shuffle() {
        for _ in 0...((cards.count - 1) * 3) {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count - 1)))
            let cardBeingMoved = cards.remove(at: randomIndex)
            cards.insert(cardBeingMoved, at: (cards.count - 1))
        }
    }
    
    func restart() {
        for card in 0...(cards.count - 1) {
            cards[card].isMatched = false
            cards[card].isFaceUp = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
        shuffle()
    }
    
    init(numberOfPairsOfCards: Int) {
        cardNum = numberOfPairsOfCards
        for _ in 1...cardNum {
            let card = Card()
            cards += [card, card]
        }
        shuffle()
    }
}
