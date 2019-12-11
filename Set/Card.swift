//
//  Card.swift
//  Set
//
//  Created by David Rozmajzl on 7/2/19.
//  Copyright © 2019 David Rozmajzl. All rights reserved.
//

import Foundation

class Card : Equatable{
    static func == (lhs: Card, rhs: Card) -> Bool {
        if lhs.shapeId == rhs.shapeId {
            if lhs.quantityId == rhs.quantityId {
                if lhs.colorId == rhs.colorId {
                    return lhs.styleId == rhs.styleId
                }
            }
        }
        return false
    }
    
    
    var isMatched = false
    var hasBeenRemovedFromDeck = false
    
    var shapeId: Int
    var quantityId: Int
    var colorId: Int
    var styleId: Int
    
    init(_ shape: Int, _ quantity: Int, _ color: Int, _ style: Int) {
        shapeId = shape
        quantityId = quantity
        colorId = color
        styleId = style
    }
}
