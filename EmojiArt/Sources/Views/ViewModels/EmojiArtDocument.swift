//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 24.09.20.
//

import SwiftUI
import Combine


class EmojiArtDocument: ObservableObject {
    static let palette: String = "⛰️🌋🗻🏕️🏖️🏜️🏝️"
    
    let id: UUID
    var url: URL? { didSet { self.save(emojiArt) } } // Use URL instead of UserDefaults for storing data
    var emojis: [Emoji] { emojiArt.emojis }
    private var autosaveCancellable: AnyCancellable?

    @Published private(set) var backgroundImage: UIImage?

    // Steady States are replaced from the View, became Publish non-private
    @Published var steadyStateZoomScale: CGFloat = 1.0
    @Published var steadyStatePanOffset: CGSize = .zero
    
    @Published private var emojiArt: EmojiArt = EmojiArt()
    

    init(id: UUID? = nil) {
        self.id = id ?? UUID()
        let defaultsKey = "EmojiArtDocument.\(self.id.uuidString)"
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: defaultsKey)) ?? EmojiArt()
        autosaveCancellable = $emojiArt.sink { emojiArt in
            UserDefaults.standard.set(emojiArt.json, forKey: defaultsKey)
        }
        fetchBackgroundImageData()
    }
  
    
    init(url: URL) {
        self.id = UUID()
        self.url = url
        self.emojiArt = EmojiArt(json: try? Data(contentsOf: url)) ?? EmojiArt()
        fetchBackgroundImageData()
        autosaveCancellable = $emojiArt.sink { emojiArt in self.save(emojiArt) }
    }
 
    
    private func save(_ emojiArt: EmojiArt) {
        if url != nil { try? emojiArt.json?.write(to: url!) }
    }
    

    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }

    
    func removeEmoji(_ emoji: Emoji) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) { emojiArt.emojis.remove(at: index) }
    }

    
    func moveEmoji(_ emoji: Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }

    
    func scaleEmoji(_ emoji: Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }

    
    var backgroundURL: URL? {
        get { emojiArt.backgroundURL  }
        set {
            emojiArt.backgroundURL = newValue?.imageURL
            fetchBackgroundImageData()
        }
    }
    
    
    private var fetchImageCancellable: AnyCancellable?

    
    private func fetchBackgroundImageData() {
        backgroundImage = nil   // if image is heavy, it will show a user that we're processing
        
        // Data Flow
        if let url = emojiArt.backgroundURL?.imageURL {
            fetchImageCancellable?.cancel()  // in case if another image is chosen before the previous was loaded

            // B) Short version
            fetchImageCancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { data, urlResponse in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)   // .sink with a error handling; assign works only with 'Never' failure
                .assign(to: \.backgroundImage, on: self)
            
            
            // A) Detailed version
            /*
            let session = URLSession.shared
            let publisher = session.dataTaskPublisher(for: url)
                .map { data, urlResponse in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
            fetchImageCancellable = publisher.assign(to: \.backgroundImage, on: self)
             */
        }
        
        // Multithreading
        /*
         if let url = emojiArt.backgroundURL {   /// more common to use URLSessions
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {     /// can take a lot of time
                    DispatchQueue.main.async {
                        if url == self.emojiArt.backgroundURL {     /// in case user dragged another image faster then it loaded
                            self.backgroundImage = UIImage(data: imageData)  /// UI cannot be happing on bg thread
                        }
                    }
                }
            }
        }
        */
    }
}


extension EmojiArtDocument: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: EmojiArtDocument, rhs: EmojiArtDocument) -> Bool { lhs.id == rhs.id }
}


extension Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}


extension EmojiArtDocument {
    private static let PaletteKey = "EmojiArtDocument.PalettesKey"
    
    
    private(set) var paletteNames: [String: String] {
        get {
            UserDefaults.standard.object(forKey: Self.PaletteKey) as? [String: String] ?? [
                "🥶🥰😀😅😂🤡😇😉🙃😎🥳😡🤯🤥😴🙄👿😷🤧": "Faces",
                "🍟🥒🍞☕️🥨🥓🍔🍕🍰🍎🍿🍏": "Food",
                "🐟🐼🐵🦆🕷🦓🐪🦒🦨🦋🐢🐏🐶🐑🦙🐄🐰🐝": "Animals",
                "⛵⛳️🎾🎼🏈⚾️🏐🏓🥌⛷🚴‍♂️🎳⚽️🎭": "Activities"
            ]
        } set {
            UserDefaults.standard.set(newValue, forKey: Self.PaletteKey)
            objectWillChange.send()
        }
    }
    
    
    var sortedPalettes: [String] { paletteNames.keys.sorted(by: { paletteNames[$0]! < paletteNames[$1]! }) }
    var defaultPalette: String { sortedPalettes.first ?? "🎗" }
    func renamePalette(_ palette: String, to name: String) { paletteNames[palette] = name }
    func addPalette(_ palette: String, named name: String) { paletteNames[name] = palette }
    func removePalette(named name: String) { paletteNames[name] = nil }
    
    
    @discardableResult func addEmoji(_ emoji: String, toPalette palette: String) -> String {
        changePalette(palette, to: (emoji + palette).uniqued())
    }
    
    
    @discardableResult func removeEmoji(_ emojisToRemove: String, fromPalette palette: String) -> String {
        changePalette(palette, to: palette.filter { !emojisToRemove.contains($0) })
    }
    
    
    private func changePalette(_ palette: String, to newPalette: String) -> String {
        let name = paletteNames[palette] ?? ""
        paletteNames[palette] = nil
        paletteNames[newPalette] = name
        return newPalette
    }
    
    
    private func palette(offsetBy offset: Int, from otherPalette: String) -> String {
        if let currentIndex = mostLikelyIndex(of: otherPalette) {
            let newIndex = (currentIndex + (offset >= 0 ? offset : sortedPalettes.count - abs(offset) % sortedPalettes.count)) % sortedPalettes.count
            return sortedPalettes[newIndex]
        } else {
            return defaultPalette
        }
    }
    
    func palette(after otherPalette: String) -> String { palette(offsetBy: +1, from: otherPalette) }
    func palette(before otherPalette: String) -> String { palette(offsetBy: -1, from: otherPalette) }
    
    
    private func mostLikelyIndex(of palette: String) -> Int? {
        let paletteSet = Set(palette)
        var best: (index: Int, score: Int)?
        let palettes = sortedPalettes
        for index in palettes.indices {
            let score = paletteSet.intersection(Set(palettes[index])).count
            if score > (best?.score ?? 0) { best = (index, score) }
        }
        return best?.index
    }

}
