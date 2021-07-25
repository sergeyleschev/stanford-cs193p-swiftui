//
//  DiamondShape.swift
//  SetGame
//
//  Created by Sergey Leschev on 14.10.20.
//

import SwiftUI


struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        
        return path
    }
}


struct DiamondShape_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
            .frame(width: 100)
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(.blue)
    }
}
