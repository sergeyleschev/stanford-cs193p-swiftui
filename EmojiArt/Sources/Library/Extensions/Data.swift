//
//  Data.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 25.08.20.
//

import Foundation


extension Data {
    var utf8: String? { String(data: self, encoding: .utf8)}
}
