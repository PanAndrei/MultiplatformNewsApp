//
//  ContentView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 27.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArticleListView(articles: ArticleModel.previewData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
