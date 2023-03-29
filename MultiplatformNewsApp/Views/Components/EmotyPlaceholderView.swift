//
//  EmotyPlaceholderView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import SwiftUI

struct EmotyPlaceholderView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 50))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmotyPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        EmotyPlaceholderView(text: "No Bookmarks", image: Image(systemName: "bookmark"))
    }
}
