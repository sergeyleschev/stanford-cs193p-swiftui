//
//  ClassicSetGame.swift
//  SetGame
//
//  Created by Sergey Leschev on 29.09.20.
//

import Foundation


class ClassicSetGame: ObservableObject {
    private let initialNumberOfCards = 12

    @Published private var game: GameSet<GeometricCard>
    
    var deck: [GeometricCard] { game.deck }
    var discardPile: [GeometricCard] { game.discardPile }
    var cardsInGame: [GeometricCard] { game.cardsInGame }
    var score: Int { game.score }
 
    
    init(cards: [GeometricCard]) { game = GameSet(cards: cards) }
    
    func dealCards() { game.dealCards() }
    func dealInitialCards() { game.dealCards(initialNumberOfCards) }
    func choose(card: GeometricCard) { game.choose(card: card) }
    
    
    func restart() {
         let cards = GeometricCard.generateAll()
         game = GameSet(cards: cards)
         dealInitialCards()
    }

}
