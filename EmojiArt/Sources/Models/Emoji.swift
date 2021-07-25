//
//  Emoji.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 24.09.20.
//

import Foundation


struct Emoji: Codable, Identifiable, Hashable {
    let id: Int
    let text: String
    var x: Int
    var y: Int
    var size: Int

    
    init(id: Int, text: String, x: Int, y: Int, size: Int) {
        self.id = id
        self.text = text
        self.x = x
        self.y = y
        self.size = size
    }
}
