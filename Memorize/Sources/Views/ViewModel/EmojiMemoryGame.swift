//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sergey Leschev on 31.08.20.
//

import Foundation
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card

    var theme: Theme
    var cards: [Card] { model.cards }
    var score: Int { model.score }

    @Published private var model: MemoryGame<String>

    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairs = theme.cardsNumber ?? Int.random(in: 2...emojis.count)
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in emojis[pairIndex] }
    }
    
        
    func choose(card: Card) { model.choose(card: card) }
    
    func resetGame() {
        theme = Theme.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }

}
