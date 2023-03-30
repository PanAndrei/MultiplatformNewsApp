//
//  SidebarContentView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 30.03.2023.
//

import SwiftUI

struct SidebarContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach([MenuItems.saved, MenuItems.search]) {
                    navigationLinkForMenuItem($0)
                }
                
                Section {
                    ForEach(Category.menuItems) {
                        navigationLinkForMenuItem($0)
                    }
                } header: {
                    Text("Categories")
                }
                .navigationTitle("News")
            }
            .listStyle(.sidebar)
            
            NewsTabView()
        }
    }
    
    private func navigationLinkForMenuItem(_ item: MenuItems) -> some View {
        NavigationLink(destination: viewForMenuItem(item)) {
            Label(item.text, systemImage: item.systemImage)
        }
    }
    
    @ViewBuilder
    private func viewForMenuItem(_ item: MenuItems) -> some View {
        switch item {
        case .search:
            SearchTabView()
        case .saved:
            BookmarkTabView()
        case .categiry(let category):
            NewsTabView(category: category)
        }
    }
}

struct SidebarContentView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarContentView()
    }
}
