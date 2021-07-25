//
//  AnyTransition.swift
//  SetGame
//
//  Created by Sergey Leschev on 20.10.20.
//

import SwiftUI


extension AnyTransition {
    static func offsetWithOpacity(width: CGFloat, height: CGFloat) -> AnyTransition {
        AnyTransition.offset(CGSize(width: width, height: height)).combined(with: .opacity)
    }
}
