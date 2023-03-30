//
//  ArticleListView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import SwiftUI

struct ArticleListView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selectedArticle: ArticleModel?
    let articles: [ArticleModel]
    
    var body: some View {
        rootView
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder
    private var rootView: some View {
        switch horizontalSizeClass {
        case .regular:
            gridView
        default:
            listView
        }
    }
    
    private var listView: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                      selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: 8) {
                ForEach(articles) { article in
                    ArticleRowView(article: article)
                        .onTapGesture {
                          selectedArticle = article
                        }
                        .frame(height: 360)
                        .background(Color(uiColor: .systemBackground))
                        .mask(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 4)
                        .padding(.bottom, 4)
                }
            }
            .padding()
        }
        .background(Color(uiColor: .secondarySystemBackground))
    }
}

struct ArticleListView_Previews: PreviewProvider {
    @StateObject static var articleBookmarksVM = ArticleBookmarkVM.shared

    static var previews: some View {
        NavigationView {
            ArticleListView(articles: ArticleModel.previewData)
                .environmentObject(articleBookmarksVM)
        }
    }
}
