//
//  View.swift
//  SetGame
//
//  Created by Sergey Leschev on 20.10.20.
//

import SwiftUI


extension View {
    func shading(_ shadingType: GeometricCard.Shading) -> some View {
        modifier(FigureShadingModifier(shadingType: shadingType))
    }
}

