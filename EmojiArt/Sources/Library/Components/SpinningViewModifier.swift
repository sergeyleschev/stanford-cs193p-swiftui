//
//  SpinningViewModifier.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 12.09.20.
//

import SwiftUI


struct Spinning: ViewModifier {
    @State var isVisible = false
    

    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isVisible ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear { isVisible = true }
    }

}
