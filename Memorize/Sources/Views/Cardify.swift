//
//  Cardify.swift
//  Memorize
//
//  Created by Sergey Leschev on 21.09.20.
//

import Foundation
import SwiftUI


struct Cardify: AnimatableModifier {
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let themeColorOpacity = 0.4

    var rotation: Double
    var isFaceUp: Bool { rotation < 90 }
    var themeColor: Color
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    var gradientFromThemeColor: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [themeColor, themeColor.opacity(themeColorOpacity)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    
    init(isFaceUp: Bool, themeColor: Color) {
        self.themeColor = themeColor
        rotation = isFaceUp ? 0 : 180
    }
    
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .fill(Color.white)
                content
            }.opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(gradientFromThemeColor)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
}
