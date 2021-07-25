//
//  StripedPattern.swift
//  SetGame
//
//  Created by Sergey Leschev on 14.10.20.
//

import SwiftUI

struct FigureShadingModifier: ViewModifier {
    var shadingType: GeometricCard.Shading
    var stripeWidth = 2
    var interval = 2

    
    func body(content: Content) -> some View {
        Group {
            switch shadingType {
            case .open:
                ZStack {
                    content.opacity(0)
                    Color.clear.mask(content)
                }
            case .solid:
                content
            case .striped:
                ZStack {
                    content.opacity(0)
                StripedPattern(stripeWidth: stripeWidth, interval: interval)
                    .mask(content)
                }
            }
        }
    }
}


struct StripedPattern: Shape {
    var stripeWidth: Int
    var interval: Int

    
    func path(in rect: CGRect) -> Path {
        let numberOfStripes = Int(rect.width) / stripeWidth
        var path = Path()
        
        path.move(to: rect.origin)

        for index in 0...numberOfStripes where index % interval == 0 {
            path.addRect(CGRect( x: CGFloat(index * stripeWidth), y: 0, width: CGFloat(stripeWidth), height: rect.height))
        }
        return path
    }
}


struct StripedPattern_Previews: PreviewProvider {
    static var previews: some View { StripedPattern(stripeWidth: 2, interval: 3) }
}
