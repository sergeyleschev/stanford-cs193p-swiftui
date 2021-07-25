//
//  Set+Identifiable.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 07.09.20.
//

import Foundation


extension Set where Element: Identifiable {
    mutating func toggleMatching(_ element: Element) {
        if contains(matching: element) {
           remove(element)
        } else {
           insert(element)
        }
    }
}
