//
//  URL.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 25.08.20.
//

import Foundation


extension URL {
    
    var imageURL: URL {
        if isFileURL {
            var url = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first
            url = url?.appendingPathComponent(self.lastPathComponent)
            if url != nil { return url! }
        }
        
        for query in query?.components(separatedBy: "&") ?? [] {
            let queryComponents = query.components(separatedBy: "=")
            if queryComponents.count == 2 {
                if queryComponents[0] == "imgurl", let url = URL(string: queryComponents[1].removingPercentEncoding ?? "") { return url }
            }
        }
        return self.baseURL ?? self
    }

}
