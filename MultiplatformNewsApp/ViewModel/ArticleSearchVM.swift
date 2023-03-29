//
//  ArticleSearchVM.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 29.03.2023.
//

import Foundation

@MainActor
class ArticleSearchVM: ObservableObject {
    @Published var phase: DataFetchPhase<[ArticleModel]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    
    private let newsAPI = NewsAPI.shared
    private let historyLimit = 10
    private let historyDataStore = PlistDataStore<[String]>(filename: "histories")
    
    static let shared = ArticleSearchVM()
    
    private init() {
        load()
    }
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty { return }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            if searchQuery != self.searchQuery { return }
            phase = .failure(error)
        }
    }
    
    func addHistory(_ text: String) {
        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) {
            history.remove(at: index)
        } else if history.count == historyLimit {
            history.remove(at: 0)
        }
        
        history.insert(text, at: 0)
        historiesUpdate()
    }
    
    func removeHistory(_ text: String) {
        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) else { return }
        history.remove(at: index)
        historiesUpdate()
    }
    
    func removeAllHistory() {
        history.removeAll()
        historiesUpdate()
    }
    
    private func load() {
        async {
            self.history = await historyDataStore.load() ?? []
        }
    }
    
    private func historiesUpdate() {
        let history = self.history
        async {
            await historyDataStore.save(history)
        }
    }
}
