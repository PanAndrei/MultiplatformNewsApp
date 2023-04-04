//
//  TabContentView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 30.03.2023.
//

import SwiftUI

struct TabContentView: View {
    @Binding var selectionItemID: MenuItems.ID?
    
    private var selection: Binding<TabMenuItem> {
        Binding {
            TabMenuItem(menuItem: selectionItemID)
        } set: { newValue in
            selectionItemID = newValue.menuItemId(category: selectedCategory ?? .general)
        }
    }
    
    private var selectedCategory: Category? {
        let menuItem = MenuItems(id: selectionItemID)
        if case .categiry(let category) = menuItem {
            return category
        } else {
            return nil
        }
    }
    
    var body: some View {
        TabView(selection: selection) {
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
            NewsTabView(category: selectedCategory ?? .general)
        case .search:
            BookmarkTabView()
        case .saved:
            SearchTabView()
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView(selectionItemID: .constant(nil))
    }
}
