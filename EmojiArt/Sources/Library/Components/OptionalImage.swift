//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Sergey Leschev on 28.09.20.
//

import SwiftUI


struct OptionalImage: View {
    var uiImage: UIImage?

    
    var body: some View {
        Group { if uiImage != nil { Image(uiImage: uiImage!) } }
    }
}


struct OptionalImage_Previews: PreviewProvider {
    static var previews: some View { OptionalImage() }
}
