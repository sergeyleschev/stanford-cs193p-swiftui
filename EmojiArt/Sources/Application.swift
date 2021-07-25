//
//  Application.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 24.09.20.
//

import SwiftUI


@main
struct Application: App {
    @StateObject var store = Store(directory: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
    

    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentChooser()
                .environmentObject(store)
        }
    }

}
