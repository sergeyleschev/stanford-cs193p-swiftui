//
//  AnimatableSystemFontModifier.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 28.09.20.
//

import SwiftUI


struct AnimatableSystemFontModifier: AnimatableModifier {
    var size: CGFloat
    var weight: Font.Weight = .regular
    var design: Font.Design = .default

    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    
    func body(content: Content) -> some View {
        content.font(Font.system(size: size, weight: weight, design: design))
    }
    
}
