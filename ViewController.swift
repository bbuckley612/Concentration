//
//  ViewController.swift
//  Test
//
//  Created by Brian Buckley on 3/16/20.
//  Copyright © 2020 Helping Hand Food Pantry. All rights reserved.
//
//https://coderwall.com/p/cjuzng/swift-instantiate-a-view-controller-using-its-storyboard-name-in-xcode
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Main(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var connection: ThemeViewController = ThemeViewController(nibName: nil, bundle: nil)
    
    var flipCount = 0 {
        didSet {
            flipCountText.text = "FLIPS: \(flipCount)"
        }
    }
    
    var scoreCount = 0 {
        didSet {
            scoreCountText.text = "SCORE: \(scoreCount)"
        }
    }
    
    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WinnerViewController") as UIViewController
    
    let viewController2:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThemeViewController") as UIViewController
    
    @IBOutlet var graphic: UILabel!
    
    @IBOutlet var flipCountText: UILabel!
    
    @IBOutlet var scoreCountText: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNum = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNum)
            updateViewFromModel()
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        restartGame()
    }
    
    @IBAction func changeTheme(_ sender: UIButton) {
        self.present(viewController2, animated: true)
    }
    
    func restartGame() {
        game.restart()
        flipCount = 0
        scoreCount = 0
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        var remaining = 0
        var matches = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                if card.isMatched {
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                    matches += 1
                } else {
                    button.backgroundColor = connection.themeColor
                    remaining += 1
                }
            }
        }
        if remaining == 0 {
            winner()
        } else {
            matches += 2 - remaining % 2
            scoreCount = matches - (flipCount - matches)
        }
    }
    
    func winner() {
        self.present(viewController, animated: true)
    }
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, connection.emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(connection.emojiChoices.count - 1)))
            emoji[card.identifier] = connection.emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = connection.themeColor
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

