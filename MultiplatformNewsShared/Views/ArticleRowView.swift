//
//  ArticleRowView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import SwiftUI

struct ArticleRowView: View {
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif
    @EnvironmentObject var artileBookmarksVM: ArticleBookmarkVM
    
    let article: ArticleModel
    
    var body: some View {
#if os(iOS)
        switch horizontalSizeClass {
        case .regular:
            GeometryReader { contentView(proxy: $0) }
        default:
            contentView()
        }
#elseif os(macOS)
        GeometryReader { contentView(proxy: $0) }
#endif
    }
    
    @ViewBuilder
    private func contentView(proxy: GeometryProxy? = nil) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: article.imageURL) { phase in // todo to cashe image
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    HStack{
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
#if os(iOS)
            .asynkImageFrame(horizontalSezeClass: horizontalSizeClass ?? .compact)
#elseif os(macOS)
            .frame(height: 180)
#endif
            .background(Color.gray.opacity(0.6))
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(article.descriptionText)
                    .font(.headline)
                    .lineLimit(2)
                
#if os(iOS)
                if horizontalSizeClass == .regular {
                    Spacer()
                }
#endif
                
                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button {
                        toggleBookmark(for: article)
                    } label: {
                        Image(systemName: artileBookmarksVM.isBookmark(for: article) ? "bookmark.fill" : "bookmark")
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        presentShareSheet(url: article.articleURL, proxy: proxy)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    private func toggleBookmark(for article: ArticleModel) {
        if artileBookmarksVM.isBookmark(for: article) {
            artileBookmarksVM.removeBiikmark(for: article)
        } else {
            artileBookmarksVM.addBookmark(for: article)
        }
    }
}

#if os(iOS)
extension View {
    @ViewBuilder
    func asynkImageFrame(horizontalSezeClass: UserInterfaceSizeClass) -> some View {
        switch horizontalSezeClass {
        case .regular:
            frame(height: 180)
        default:
            frame(minHeight: 200, maxHeight: 300)
        }
    }
}
#endif

extension View { // todo refactor
    func presentShareSheet(url: URL, proxy: GeometryProxy? = nil) {
#if os(iOS)
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        guard let rootVC = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController else { return }
        
        activityVC.popoverPresentationController?.sourceView = rootVC.view
        
        if let proxy = proxy {
            activityVC.popoverPresentationController?.sourceRect = proxy.frame(in: .global)
        }
        
        rootVC.present(activityVC, animated: true)
#endif
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    @StateObject static var articleBookmarksVM = ArticleBookmarkVM.shared

    static var previews: some View {
        NavigationView {
            List {
                ArticleRowView(article: .previewData[1])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .environmentObject(articleBookmarksVM)
    }
}