//
//  Store.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 15.09.20.
//

import SwiftUI
import Combine


class Store: ObservableObject {
    let name: String
    var documents: [EmojiArtDocument] { documentNames.keys.sorted { documentNames[$0]! < documentNames[$1]! } }
    private var directory: URL?
    private var autosave: AnyCancellable?
    

    @Published private var documentNames = [EmojiArtDocument: String]()

    
    init(named name: String = "Emoji Art") {
        self.name = name
        let defaultsKey = "Store.\(name)"
        documentNames = Dictionary(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey))
        autosave = $documentNames.sink { names in
            UserDefaults.standard.set(names.asPropertyList, forKey: defaultsKey)
        }
    }
    
    
    init(directory: URL) {
        self.name = directory.lastPathComponent
        self.directory = directory
        do {
            let documents = try FileManager.default.contentsOfDirectory(atPath: directory.path)
            for document in documents {
                let emojiArtDocument = EmojiArtDocument(url: directory.appendingPathComponent(document))
                documentNames[emojiArtDocument] = document
            }
        } catch {
            print("Store: couldn't create store from directory \(directory): \(error.localizedDescription)")
        }
    }


    func name(for document: EmojiArtDocument) -> String {
        if documentNames[document] == nil { documentNames[document] = "Untitled" }
        return documentNames[document]!
    }
    
    
    func setNameUD(_ name: String, for document: EmojiArtDocument) { documentNames[document] = name }
    func addDocumentUD(named name: String = "Untitled") { documentNames[EmojiArtDocument()] = name }
    func removeDocumentUD(_ document: EmojiArtDocument) { documentNames[document] = nil }

    
    func setName(_ name: String, for document: EmojiArtDocument) {
        if let url = directory?.appendingPathComponent(name) {
            if !documentNames.values.contains(name) {
                removeDocument(document)
                document.url = url
                documentNames[document] = name
            }
        } else {
            documentNames[document] = name
        }
    }
    
    
    func addDocument(named name: String = "Untitled") {
        let uniqueName = name.uniqued(withRespectTo: documentNames.values)
        let document: EmojiArtDocument
        if let url = directory?.appendingPathComponent(uniqueName) {
            document = EmojiArtDocument(url: url)
        } else {
            document = EmojiArtDocument()
        }
        documentNames[document] = uniqueName
    }
    

    func removeDocument(_ document: EmojiArtDocument) {
        if let name = documentNames[document], let url = directory?.appendingPathComponent(name) {
            try? FileManager.default.removeItem(at: url)
        }
        documentNames[document] = nil
    }

}
