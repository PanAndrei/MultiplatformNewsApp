//
//  TabContentView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 30.03.2023.
//

import SwiftUI

struct TabContentView: View {
    
    
    var body: some View {
        TabView {
            ForEach(TabMenuItem.allCases) { item in
                NavigationView {
                    viewForTabView(item)
                }
                .tabItem {
                    Label(item.text, systemImage: item.systemImage)
                }
                .tag(item)
            }
        }
    }
    
    @ViewBuilder
    private func viewForTabView(_ item: TabMenuItem) -> some View {
        switch item {
        case .news:
            NewsTabView()
        case .search:
            BookmarkTabView()
        case .saved:
            SearchTabView()
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
