//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 24.09.20.
//

import Foundation


struct EmojiArt: Codable {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    var json: Data? { try? JSONEncoder().encode(self) }

    private var uniqueEmojiId = 0


    init?(json: Data?) {
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        } else {
            return nil
        }
    }

    init() { }


    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: x, y: y, size: size))
    }
}
