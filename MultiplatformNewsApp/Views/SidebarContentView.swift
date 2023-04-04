//
//  SidebarContentView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 30.03.2023.
//

import SwiftUI

struct SidebarContentView: View {
    @Binding var selectionItemID: MenuItems.ID?
    
    private var selection: Binding<MenuItems.ID?> {
        Binding {
            selectionItemID ?? MenuItems.categiry(.general).id
        } set: { newValue in
            if let menuItem = newValue {
                selectionItemID = menuItem
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(selection: selection) {
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
        NavigationLink(destination: viewForMenuItem(item), tag: item.id, selection: selection) {
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
        SidebarContentView(selectionItemID: .constant(nil))
    }
}
