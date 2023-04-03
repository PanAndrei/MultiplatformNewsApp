//
//  SearchTabView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 29.03.2023.
//

import SwiftUI

struct SearchTabView: View {
    @StateObject var searvhVM = ArticleSearchVM.shared
    
    var body: some View {
        ArticleListView(articles: articles)
            .overlay(overlayView)
            .navigationTitle("Search")
            .searchable(text: $searvhVM.searchQuery, placement: .navigationBarDrawer) { suggestionsView }
            .onSubmit(of: .search, search)
            .onChange(of: searvhVM.searchQuery) { newValue in
                if newValue.isEmpty {
                    searvhVM.phase = .empty
            }
        }
    }
    
    private var articles: [ArticleModel] {
        if case .success(let articles) = searvhVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    private var suggestionsView: some View {
        ForEach(["swift", "covid", "another"], id: \.self) { text in
            Button {
                searvhVM.searchQuery = text
            } label: {
                Text(text)
            }
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searvhVM.phase {
        case .empty:
            if !searvhVM.searchQuery.isEmpty {
                ProgressView()
            } else if !searvhVM.history.isEmpty {
                SearchHistoryListView(searchVM: searvhVM) { newValue in
                    searvhVM.searchQuery = newValue
                }
            } else {
                EmotyPlaceholderView(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
            }
        case .success(let articles) where articles.isEmpty:
            EmotyPlaceholderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                search()
            }
        default:
            EmptyView()
        }
    }
    
    private func search() {
        let searchQuery = searvhVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searvhVM.addHistory(searchQuery)
        }
        Task {
            await searvhVM.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    @StateObject static var articleBookmarksVM = ArticleBookmarkVM.shared
    
    static var previews: some View {
        SearchTabView()
            .environmentObject(articleBookmarksVM)
    }
}
