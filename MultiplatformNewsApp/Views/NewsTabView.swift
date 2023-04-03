//
//  NewsTabView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import SwiftUI

struct NewsTabView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @StateObject var articleNewsVM: ArticleNewsVM
    
    init(articles: [ArticleModel]? = nil, category: Category = .general) {
        self._articleNewsVM = StateObject(wrappedValue: ArticleNewsVM(articles: articles, selectedCathegory: category))
    }
    
    var body: some View {
        ArticleListView(articles: articles)
            .overlay(overlayView)
            .task(id: articleNewsVM.fetchTaskToken, loadTask)
            .refreshable {
                refreshTask()
            }
            .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    navigationBarItem
                }
            }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmotyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                refreshTask()
            }
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var navigationBarItem: some View {
        switch horizontalSizeClass {
        case .regular:
            Button {
                refreshTask()
            } label: {
                Image(systemName: "arrow.clockwise")
            }
        default:
            Menu {
                Picker("Category", selection: $articleNewsVM.fetchTaskToken.category) {
                    ForEach(Category.allCases) {
                        Text($0.text)
                            .tag($0)
                    }
                }
            } label: {
                Image(systemName: "fiberchannel")
                    .imageScale(.large)
            }
        }
    }
    
    private var articles: [ArticleModel] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @Sendable
    private func loadTask() async {
        await articleNewsVM.loadArticles()
    }
    
    private func refreshTask() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
    }
}

struct NewsTabView_Previews: PreviewProvider {    
    @StateObject static var articleBookmarksVM = ArticleBookmarkVM.shared
    
    static var previews: some View {
        NewsTabView(articles: ArticleModel.previewData)
            .environmentObject(articleBookmarksVM)
    }
}
