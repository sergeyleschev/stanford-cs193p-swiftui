//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sergey Leschev on 31.08.20.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    var score = 0
    
    
    mutating func choose(card: Card) {
        let faceupCardIndeces = cards.indices.filter { cards[$0].isFaceUp }
        
        if faceupCardIndeces.count > 1 {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].alreadyBeenSeen = true
                    cards[index].isFaceUp = false
                }
            }
        }
        
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            cards[chosenIndex].isFaceUp = true
            if faceupCardIndeces.count == 1 {
                if cards[faceupCardIndeces[0]].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[faceupCardIndeces[0]].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].alreadyBeenSeen { score -= 1 }
                    if cards[faceupCardIndeces[0]].alreadyBeenSeen { score -= 1 }
                }
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet { if isFaceUp { startUsingBonusTime() } else { stopUsingBonusTime() } }
        }
        
        var isMatched: Bool = false {
            didSet { stopUsingBonusTime() }
        }
        
        var alreadyBeenSeen: Bool = false
        var content: CardContent
        var id: Int
        var bonusTimeLimit: TimeInterval = 6
        

        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        

        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval { max(0, bonusTimeLimit - faceUpTime) }
        var bonusRemaining: Double { (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0 }
        var hasEarnedBonus: Bool { isMatched && bonusTimeRemaining > 0 }
        var isConsumingBonusTime: Bool { isFaceUp && !isMatched && bonusTimeRemaining > 0 }
        
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil { lastFaceUpDate = Date() }
        }
        
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    
    }
    
}
