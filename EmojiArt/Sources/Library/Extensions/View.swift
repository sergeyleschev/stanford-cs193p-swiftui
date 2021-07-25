//
//  View.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 25.08.20.
//

import SwiftUI


extension View {
    func spinning() -> some View { modifier(Spinning()) }
    
    
    func font(animatableWithSize size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}
