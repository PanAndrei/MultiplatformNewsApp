//
//  ArticleListView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import SwiftUI

struct ArticleListView: View {
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selectedArticle: ArticleModel?
#elseif os(macOS)
    @Environment(\.colorScheme) private var colorScheme
#endif
    
    let articles: [ArticleModel]
    
    var body: some View {
        rootView
#if os(iOS)
            .sheet(item: $selectedArticle) {
                SafariView(url: $0.articleURL)
                    .edgesIgnoringSafeArea(.bottom)
            }
#endif
    }
    
    @ViewBuilder
    private var rootView: some View {
#if os(iOS)
        switch horizontalSizeClass {
        case .regular:
            gridView
        default:
            listView
        }
#elseif os(macOS)
        gridView
#endif
    }
    
#if os(iOS)
    private var listView: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        handleOnTapGesture(article: article)
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
#endif
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(articles) { article in
                    ArticleRowView(article: article)
                        .onTapGesture {
handleOnTapGesture(article: article)
                        }
#if os(iOS)
                        .frame(height: 360)
                        .background(Color(uiColor: .systemBackground))
                        
#elseif os(macOS)
                        .frame(height: 376)
                        .background(Color(nsColor: colorScheme == .light ? .textBackgroundColor : .windowBackgroundColor))
#endif
                        .mask(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 4)
                        .padding(.bottom, 4)
                }
            }
            .padding()
        }
#if os(iOS)
        .background(Color(uiColor: .secondarySystemBackground))
#endif

    }
    
    private func handleOnTapGesture(article: ArticleModel) {
#if os(iOS)
        selectedArticle = article
#elseif os(macOS)
        NSWorkspace.shared.open(article.articleURL)
#endif
    }
    
    private var gridItems: [GridItem] {
#if os(iOS)
        [GridItem(.adaptive(minimum: 300), spacing: 8)]
#else
        [GridItem(.adaptive(minimum: 272, maximum: 272), spacing: 8)]
#endif
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
