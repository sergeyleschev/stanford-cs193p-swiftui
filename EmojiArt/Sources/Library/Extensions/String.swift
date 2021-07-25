//
//  String.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 12.09.20.
//

import Foundation


extension String {
    func uniqued() -> String {
        var uniqued = ""
        for charecter in self {
            if !uniqued.contains(charecter) {
                uniqued.append(charecter)
            }
        }
        return uniqued
    }
}


extension String {
    func uniqued<StringCollection>(withRespectTo otherStrings: StringCollection) -> String where StringCollection: Collection, StringCollection.Element == String {
        var unique = self
        while otherStrings.contains(unique) {
            unique = unique.incremented
        }
        return unique
    }
    
    
    var incremented: String {
        let prefix = String(self.reversed().drop(while: { $0.isNumber }).reversed())
        if let number = Int(self.dropFirst(prefix.count)) {
            return "\(prefix)\(number + 1)"
        } else {
            return "\(self) 1"
        }
    }
}
