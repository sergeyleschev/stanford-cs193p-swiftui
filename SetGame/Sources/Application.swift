//
//  Application.swift
//  SetGame
//
//  Created by Sergey Lesche on 29.09.20.
//

import SwiftUI


@main struct Application: App {
    @StateObject var viewModel = ClassicSetGame(cards: GeometricCard.generateAll())
    
    
    var body: some Scene {
        WindowGroup { ContentView(game: viewModel) }
    }
}
