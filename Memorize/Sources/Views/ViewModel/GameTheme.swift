//
//  GameTheme.swift
//  Memorize
//
//  Created by Sergey Leschev on 18.09.20.
//

import Foundation
import SwiftUI


struct Theme: Codable, Identifiable {
    var id = UUID()
    var name: String
    var emojis: [String]
    var removedEmojis: [String]
    
    var cardsNumber: Int
    var color: RGB
    var json: Data? { return try? JSONEncoder().encode(self) }
    
    static let techno = Theme(name: "Technology", emojis: ["🤖", "👾", "🦾", "🦿", "🎮", "🖲"], removedEmojis: [], cardsNumber: 6, color: UIColor.getRGB(.blue))
    static let zodiac = Theme(name: "Signs of zodiac", emojis: ["♌️", "♍️", "♏️", "♓️", "♉️", "♈️", "⛎", "♒️", "♋️", "♐️", "♊️", "♑️"], removedEmojis: [], cardsNumber: 12, color: UIColor.getRGB(.purple))
    static let animals = Theme(name: "Animals", emojis: ["🐶", "🐨", "🦁", "🐮", "🐷", "🐯", "🐼", "🦊", "🐻", "🐰"], removedEmojis: [], cardsNumber: 10, color: UIColor.getRGB(.gray))
    static let cats = Theme(name: "Cats", emojis: ["😹", "😸", "🙀", "😻", "😺", "😿", "😾"], removedEmojis: [], cardsNumber: 7, color: UIColor.getRGB(.red))
    static let vegetables = Theme(name: "Vegetables", emojis: ["🥦", "🍅", "🌶", "🌽", "🥕", "🥬", "🥒", "🧄", "🍆", "🧅"], removedEmojis: [], cardsNumber: 10, color: UIColor.getRGB(.orange))
    
    static var themes = [cats, techno, zodiac, animals, vegetables]
}
