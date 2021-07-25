//
//  SetCategory.swift
//  SetGame
//
//  Created by Sergey Leschev on 06.10.20.
//

import Foundation


protocol SetCategory: Equatable { associatedtype Content }


extension SetCategory {
    static func isCorrectSet<Content: Equatable>(contentA: Content, contentB: Content, contentC: Content) -> Bool {
        (contentA == contentB && contentB == contentC) || (contentA != contentB && contentB != contentC && contentC != contentA)
    }
}
