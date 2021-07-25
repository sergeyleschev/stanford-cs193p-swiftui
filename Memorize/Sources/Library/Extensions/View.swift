//
//  View.swift
//  Memorize
//
//  Created by Sergey Leschev on 10.10.20.
//

import SwiftUI


extension View {
    func cardify(isFaceUp: Bool, themeColor: Color) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, themeColor: themeColor))
    }
}
