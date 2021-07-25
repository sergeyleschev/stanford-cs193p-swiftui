//
//  StarShape.swift
//  SetGame
//
//  Created by Sergey Leschev on 14.10.20.
//

import SwiftUI


struct Star: Shape {
    let corners: Int
    let smoothness: CGFloat
    
    
    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() }
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2)
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        var path = Path()
        var bottomEdge: CGFloat = 0

        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        
        for corner in 0..<(corners * 2) {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat
            
            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                bottom = innerY * sinAngle
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }
            
            if bottom > bottomEdge { bottomEdge = bottom }
            currentAngle += angleAdjustment
        }
        path.closeSubpath()
        
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}


struct StarShape_Previews: PreviewProvider {
    static var previews: some View {
        Star(corners: 5, smoothness: 0.65)
            .frame(width: 100)
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(.blue)
    }
}
