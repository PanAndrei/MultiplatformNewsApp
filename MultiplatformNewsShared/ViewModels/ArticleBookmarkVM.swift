//
//  ArticleBookmarkVM.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 29.03.2023.
//

import SwiftUI

@MainActor
class ArticleBookmarkVM: ObservableObject {
    @Published private(set) var bookmarks: [ArticleModel] = []
    
    private let bookmarkStore = PlistDataStore<[ArticleModel]>(filename: "bookmarks")
    
    static let shared = ArticleBookmarkVM()
    
    private init() {
        Task {
            await load()
        }
    }
    
    func isBookmark(for article: ArticleModel) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article: ArticleModel) {
        guard !isBookmark(for: article) else { return }
        
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBiikmark(for article: ArticleModel) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }
        
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    private func load() async {
        bookmarks = await bookmarkStore.load() ?? []
    }
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }
}
