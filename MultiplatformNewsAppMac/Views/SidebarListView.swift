//
//  SidebarListView.swift
//  MultiplatformNewsAppMac
//
//  Created by Andrei Panasenko on 04.04.2023.
//

import SwiftUI

struct SidebarListView: View {
    @Binding var selection: MenuItems.ID?
    
    var body: some View {
        ZStack {
            navigationLink
                .opacity(0)
            
            List(selection: $selection) {
                Section {
                    listRow(MenuItems.saved)
                        .tag(MenuItems.saved.id)
                } header: {
                    Text("News")
                }
                .collapsible(false)
                
                Section {
                    ForEach(Category.menuItems) {
                        listRow($0)
                            .tag($0.id)
                    }
                } header: {
                    Text("Categories")
                }
                .collapsible(false)
            }
            .listStyle(.sidebar)
            .frame(minWidth: 220)
            .padding(.top)
        }
    }
    
    @ViewBuilder
    private func viewForMenuItem(_ item: MenuItems) -> some View {
        switch item {
        case .search:
            Text("search")
        case .saved:
            Text("saved")
        case .categiry(let category):
            NewsTabView(category: category)
        }
    }
    
    @ViewBuilder
    private var navigationLink: some View {
        if let selectedMenuItem = MenuItems(id: selection) {
            NavigationLink(destination: viewForMenuItem(selectedMenuItem), tag: selectedMenuItem.id, selection: $selection) {
                EmptyView()
            }
        }
    }
    
    private func listRow(_ item: MenuItems) -> some View {
        Label {
            Text(item.text)
                .padding(.leading, 4)
        } icon: {
            Image(systemName: item.systemImage)
        }
        .font(.title2)
        .padding(.vertical, 4)
    }
}

struct SidebarListView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarListView(selection: .constant(nil))
    }
}
