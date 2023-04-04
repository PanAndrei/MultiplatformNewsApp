//
//  BookmarkTabView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 29.03.2023.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var artileBookmarksVM: ArticleBookmarkVM
    
    @State var searchText: String = ""
    
    var body: some View {
        let articles = self.articles // TODO: calculate in vm
        
        ArticleListView(articles: articles)
            .overlay(overlayView(isEmpty: articles.isEmpty))
            .navigationTitle("Saved articles")
#if os(macOS)
            .navigationSubtitle("\(articles.count) bookmark(s)")
#endif
            .searchable(text: $searchText)
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmotyPlaceholderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
    
    private var articles: [ArticleModel] {
        if searchText.isEmpty {
            return artileBookmarksVM.bookmarks
        } else {
            return artileBookmarksVM.bookmarks.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    @StateObject static var articleBookmarksVM = ArticleBookmarkVM.shared
    
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(articleBookmarksVM)
    }
}
