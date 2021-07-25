//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Sergey Leschev on 30.09.20.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    private let gameColor = Color.pink
    private let cornerRadius: CGFloat = 25
    private let flipAnimationDuration: Double = 0.75

    var themeColor: Color { Color(viewModel.theme.color) }

    @ObservedObject var viewModel: EmojiMemoryGame

    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.theme.name)
                    .font(.largeTitle)
                    .layoutPriority(1)
                Spacer()
                HStack {
                    Spacer()
                    Text("Score")
                    Text("\(viewModel.score)")
                        .foregroundColor(gameColor)
                }
            }
            .padding(.horizontal, 5)
            
            Grid(viewModel.cards) { card in
                CardView(card: card, themeColor: self.themeColor)
                    .onTapGesture {
                        withAnimation(.linear(duration: flipAnimationDuration)) {
                            self.viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
            }
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }) {
                Text("New Game")
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(gameColor)
                    )
            }
            .padding(.top, 10)
        }
        .padding(.top, 15)
        .padding()
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
    
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: Theme.cats)
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}

            
