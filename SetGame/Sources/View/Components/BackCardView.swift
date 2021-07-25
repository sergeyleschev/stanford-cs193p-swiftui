//
//  BackCardView.swift
//  SetGame
//
//  Created by Sergey Leschev on 20.10.20.
//

import SwiftUI


struct BackCardView: View {
    private let cardProportion: CGFloat = 4/7


    var body: some View {
        Image("cardBg")
            .resizable()
            .aspectRatio(cardProportion, contentMode: .fill)
            .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 1, y: 2)
    }
    
}


struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView()
            .frame(width: 200, height: 200)
    }
}
