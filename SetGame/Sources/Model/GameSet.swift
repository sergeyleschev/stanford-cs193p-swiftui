//
//  GameSet.swift
//  SetGame
//
//  Created by Sergey Leschev on 29.09.20.
//

import Foundation


struct GameSet<Card> where Card: SetCard {
    private(set) var deck: [Card]
    private(set) var cardsInGame: [Card]
    private(set) var discardPile: [Card]
    private(set) var score: Int = 0
    private var selectedCards: [Card] { cardsInGame.filter { $0.isSelected } }
    private let setSize = 3
    private let maxCardsForBonus = 18
    private let maxPoints = 5
    private let minPoints = 1

    
    init(cards: [Card]) {
        deck = cards.map(\.facedDown.unselected).shuffled()
        cardsInGame = []
        discardPile = []
    }
    
    
    mutating func dealCards(_ quantity: Int = 3) {
        let newCards = deck.prefix(quantity).map(\.facedUp)
        cardsInGame.append(contentsOf: newCards)
        deck = Array(deck.dropFirst(quantity))
    }
  
    
    mutating func choose(card: Card) {
        guard selectedCards.count < setSize else { return }
        
        for index in cardsInGame.indices where cardsInGame[index] == card { cardsInGame[index].isSelected.toggle() }
        checkForSet()
    }

    
    private mutating func checkForSet() {
        guard selectedCards.count == setSize else { return }
        
        if Card.isSet(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2]) {
            discardSelectedCards()
        } else {
            unselectCards()
        }
    }
    
    
    private mutating func discardSelectedCards() {
        for _ in selectedCards.indices {
            if let index = cardsInGame.firstIndex(of: selectedCards.first!) {
                cardsInGame[index].isMatched = true
                let cardToRemove = cardsInGame.remove(at: index)
                discardPile.append(cardToRemove.unselected)
            }
        }
        earnPoints()
        dealCards()
    }
    
    
    private mutating func unselectCards() {
        for index in cardsInGame.indices where selectedCards.contains(cardsInGame[index]) { cardsInGame[index].isSelected = false }
        penalizePoints()
    }
    
    
    private mutating func earnPoints() {
        if cardsInGame.count <= maxCardsForBonus && deck.count > 0 {
            score += maxPoints
        } else {
            score += minPoints
        }
    }
    
    
    private mutating func penalizePoints() {
        score -= maxPoints
        if score < 0 { score = 0 }
    }
    
}


