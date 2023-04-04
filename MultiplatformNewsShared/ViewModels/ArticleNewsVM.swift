//
//  ArticleNewsVM.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import SwiftUI

enum DataFetchPhase<T> { // TODO: to another file
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

@MainActor
class ArticleNewsVM: ObservableObject {
    @Published var phase = DataFetchPhase<[ArticleModel]>.empty
    @Published var fetchTaskToken: FetchTaskToken {
        didSet {
            if oldValue.category != fetchTaskToken.category {
                selectionItemID = MenuItems.categiry(fetchTaskToken.category).id
            }
        }
    }
    
    @AppStorage("item_selection") private var selectionItemID: MenuItems.ID?
    
    private let newsAPI = NewsAPI.shared
    
    init(articles: [ArticleModel]? = nil, selectedCathegory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCathegory, token: Date())
    }
    
    func loadArticles() async {
        phase = .success(ArticleModel.previewData)
//        if Task.isCancelled { return }
//        phase = .empty
//        do {
//            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
//            if Task.isCancelled { return }
//            phase = .success(articles)
//        } catch {
//            if Task.isCancelled { return }
//            print(error.localizedDescription)
//            phase = .failure(error)
//        }
    }
}
