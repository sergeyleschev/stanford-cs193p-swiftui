//
//  EditableText.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 15.09.20.
//

import SwiftUI

struct EditableText: View {
    var text = ""
    var isEditing: Bool
    var onChanged: (String) -> Void

    @State private var editableText = ""
    
    
    init(_ text: String, isEditing: Bool, onChanged: @escaping (String) -> Void) {
        self.text = text
        self.isEditing = isEditing
        self.onChanged = onChanged
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField(text, text: $editableText, onEditingChanged: { began in
                callOnChangedIfChanged()
            })
            .opacity(isEditing ? 1 : 0)
            .disabled(!isEditing)
            
            if !isEditing {
                Text(text)
                    .opacity(isEditing ? 0 : 1)
                    .onAppear {
                        callOnChangedIfChanged()
                    }
            }
        }
        .onAppear { editableText = text }
    }

    
    func callOnChangedIfChanged() {
        if editableText != text { onChanged(editableText) }
    }
}


struct EditableText_Previews: PreviewProvider {
    static var previews: some View { EditableText("Text", isEditing: true, onChanged: { began in }) }
}
