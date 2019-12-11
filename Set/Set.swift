//
//  Set.swift
//  Set
//
//  Created by David Rozmajzl on 7/2/19.
//  Copyright © 2019 David Rozmajzl. All rights reserved.
//

import Foundation

class Set {
    var deck = [Card]()
    var selectedCards = [Card]()
    
    private let numberOfPropertyVariations = 3
    private let numberOfDifferentProperties = 4
    
    init(){
        for shape in 0..<numberOfPropertyVariations {
            for quantity in 0..<numberOfPropertyVariations {
                for color in 0..<numberOfPropertyVariations{
                    for style in 0..<numberOfPropertyVariations {
                        // Creating 81 cards with every variation
                        let card = Card(shape, quantity, color, style)
                        // Pushing each card into the deck array
                        deck += [card]
                    }
                }
            }
        }
    }
    
    func deckIsEmpty() -> Bool {
        for card in deck {
            if card.hasBeenRemovedFromDeck == false {
                return false
            }
        }
        return true
    }
    
    func chooseRandomCardIndex() -> Int {
        assert(!deckIsEmpty())
        // Find random index within the range of number of cards
        var index = Int.random(in: 0..<deck.count)
        while deck[index].hasBeenRemovedFromDeck {
            // Make sure the card at the random index hasn't already been selected
            index = Int.random(in: 0..<deck.count)
        }
        // Mark the card as removed from the deck
        deck[index].hasBeenRemovedFromDeck = true
        // Return the card's index
        return index
    }
    
    func selectCard(_ card: Card) {
        selectedCards += [card]
    }
    
    func deselectCard(_ card: Card) {
        selectedCards.remove(at: selectedCards.firstIndex(of: card)!)
    }
    
    func findAMatch() -> Bool {
        let card1 = selectedCards[0]
        let card2 = selectedCards[1]
        let card3 = selectedCards[2]
        // Clear the selectedCards deck
        selectedCards.removeAll()
        if cardPropertiesAreSame(card1.shapeId, card2.shapeId, card3.shapeId) || cardPropertiesAreDifferent(card1.shapeId, card2.shapeId, card3.shapeId){
            if cardPropertiesAreSame(card1.quantityId, card2.quantityId, card3.quantityId) || cardPropertiesAreDifferent(card1.quantityId, card2.quantityId, card3.quantityId){
                if cardPropertiesAreSame(card1.colorId, card2.colorId, card3.colorId) || cardPropertiesAreDifferent(card1.colorId, card2.colorId, card3.colorId) {
                    if cardPropertiesAreSame(card1.styleId, card2.styleId, card3.styleId) || cardPropertiesAreDifferent(card1.styleId, card2.styleId, card3.styleId){
                        // Mark all cards as matched
                        deck[deck.firstIndex(of: card1)!].isMatched = true
                        deck[deck.firstIndex(of: card2)!].isMatched = true
                        deck[deck.firstIndex(of: card3)!].isMatched = true
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // Returns true if all properties are the same and false otherwise
    private func cardPropertiesAreSame(_ property1: Int, _ property2: Int, _ property3: Int) -> Bool{
        if property1 == property2 {
            return property2 == property3
        }
        return false
    }
    
    // Returns true if all properties are different and false otherwise
    private func cardPropertiesAreDifferent(_ property1: Int, _ property2: Int, _ property3: Int) -> Bool{
        if property1 != property2, property1 != property3, property2 != property3 {
            return true
        }
        return false
    }
}
