//
//  ViewController.swift
//  Set
//
//  Created by David Rozmajzl on 7/2/19.
//  Copyright © 2019 David Rozmajzl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        removeCardsFromDeckAndDisplay(12)
    }
    
    private var game = Set()
    @IBOutlet var setCardButtons: [UIButton]!
    private var cardPairs = [UIButton:Int]() // Button on screen : Index of card in deck
    
    private let shapes = ["▲", "●", "■"]
    private let colors = [UIColor.red, UIColor.green, UIColor.blue]
    private let alpha = [CGFloat(1), CGFloat(1), CGFloat(0.4)]
    private let stroke = [nil, 10, nil]
    
    private func removeCardsFromDeckAndDisplay(_ numberOfCards: Int) {
        if game.deckIsEmpty() {
            print("Cannot add more cards to the deck")
            return
        }
        var cardsRemoved = 0
        for button in setCardButtons {
            if button.attributedTitle(for: .normal) == nil {
                // Make sure the button is able to be clicked
                button.isEnabled = true
                // Make sure the button shows up on screen with white background
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                // Select a random card from the deck
                let randomIndex = game.chooseRandomCardIndex()
                // Match button with card in deck
                cardPairs[button] = randomIndex
                // Set the correct quantity of shapes for the button and store in a string
                let buttonText = String(repeating: shapes[game.deck[randomIndex].shapeId], count: game.deck[randomIndex].quantityId + 1)
                let buttonAttributes: [NSAttributedString.Key : Any] =
                    [
                    .foregroundColor : colors[game.deck[randomIndex].colorId].withAlphaComponent(alpha[game.deck[randomIndex].styleId]),
                    .strokeWidth : stroke[game.deck[randomIndex].styleId] ?? 0
                    ]
                // Convert the string to an NSAttributedString
                let buttonContents = NSAttributedString(string: buttonText, attributes: buttonAttributes)
                // Set the button title to the specialized string
                button.setAttributedTitle(buttonContents, for: .normal)
                cardsRemoved += 1
                if cardsRemoved == numberOfCards {
                    break
                }
            }
        }
    }
    
    @IBAction func addCards(_ sender: UIButton) {
        removeCardsFromDeckAndDisplay(3)
    }
    
    @IBAction func chooseCard(_ sender: UIButton) {
        highlightCard(sender)
        if game.selectedCards.count == 3 {
            if game.findAMatch() {
                resetMatchedCards()
                removeCardsFromDeckAndDisplay(3)
            } else {
                resetUnmatchedCards()
            }
        }
    }
    
    private func resetMatchedCards() {
        for button in setCardButtons {
            if button.backgroundColor == #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setAttributedTitle(nil, for: UIControl.State.normal)
            }
        }
    }
    
    private func resetUnmatchedCards() {
        for button in setCardButtons {
            if button.backgroundColor == #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
    }
    
    private func highlightCard(_ sender: UIButton) {
        // To select a button
        print(setCardButtons.firstIndex(of: sender)!)
        if sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
            // Add the button to the selected deck
            game.selectCard(game.deck[cardPairs[sender]!])
            sender.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        } else {
            // To deselect a button
            // Remove the button from the selected deck
            game.deselectCard(game.deck[cardPairs[sender]!])
            sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
