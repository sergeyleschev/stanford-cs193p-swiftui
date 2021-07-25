//
//  Array.swift
//  Memorize
//
//  Created by Sergey Leschev on 10.09.20.
//

import Foundation


extension Array {
    var only: Element? { count == 1 ? first : nil }
}


extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count where self[index].id == matching.id { return index }
        return nil
    }
}
