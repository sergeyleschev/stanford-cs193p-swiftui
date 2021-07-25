//
//  Dictionary.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 25.08.20.
//

import Foundation


extension Dictionary where Key == EmojiArtDocument, Value == String {
    var asPropertyList: [String: String] {
        var uuidToName = [String: String]()
        for (key, value) in self { uuidToName[key.id.uuidString] = value }
        return uuidToName
    }
    
    
    init(fromPropertyList plist: Any?) {
        self.init()
        let uuidToName = plist as? [String: String] ?? [:]
        for uuid in uuidToName.keys { self[EmojiArtDocument(id: UUID(uuidString: uuid))] = uuidToName[uuid] }
    }
}
