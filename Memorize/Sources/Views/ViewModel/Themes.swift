//
//  Themes.swift
//  Memorize
//
//  Created by Sergey Leschev on 10.12.20.
//

import SwiftUI
import Combine


class Themes: ObservableObject {
    static let saveKey = "SavedThemesForEmojiMemoryGame"

    @Published private(set) var savedThemes: [Theme]

    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Theme].self, from: data) {
                self.savedThemes = decoded
                return
            }
        }
        self.savedThemes = [Theme.techno, Theme.zodiac, Theme.animals, Theme.cats, Theme.vegetables]
    }
    

    private func save() {
        if let encoded = try? JSONEncoder().encode(savedThemes) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    

    func addTheme(_ theme: Theme) {
        if let index = savedThemes.firstIndex(matching: theme) {
            savedThemes[index] = theme
        } else {
            savedThemes.append(theme)
        }
        save()
    }
    

    func removeTheme(_ theme: Theme) {
        if let index = savedThemes.firstIndex(matching: theme) {
            savedThemes.remove(at: index)
            save()
        }
    }

}
