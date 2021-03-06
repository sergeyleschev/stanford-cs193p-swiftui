//
//  EmojiArtDocumentChooser.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 15.09.20.
//

import SwiftUI


struct EmojiArtDocumentChooser: View {
    @EnvironmentObject var store: Store
    @State private var editMode: EditMode = .inactive
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.documents) { document in
                    NavigationLink(destination:
                        EmojiArtDocumentView(document: document)
                            .navigationBarTitle(store.name(for: document))
                    ) {
                        EditableText(store.name(for: document), isEditing: editMode.isEditing) { name in
                            store.setName(name, for: document)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { store.documents[$0] }.forEach { document in
                        store.removeDocument(document)
                    }
                }
            }
            .navigationTitle(Text("Emoji Art"))
            .navigationBarItems(leading: Button(action: {
                store.addDocument()
            }, label: {
                Image(systemName: "plus") }
            ), trailing: EditButton())
            .environment(\.editMode, $editMode)
            .onAppear {
                if store.documents.isEmpty {
                    store.addDocument()
                    store.addDocument(named: "New file")
                }
            }
        }
    }
}


struct EmojiArtDocumentChooser_Previews: PreviewProvider {
    static var previews: some View { EmojiArtDocumentChooser() }
}
