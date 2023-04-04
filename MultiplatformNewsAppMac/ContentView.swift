//
//  ContentView.swift
//  MultiplatformNewsAppMac
//
//  Created by Andrei Panasenko on 04.04.2023.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("item_selection") private var selectedMenuItemID: MenuItems.ID? // todo
    
    private var selection: Binding<MenuItems.ID?> {
        Binding {
            selectedMenuItemID ?? MenuItems.categiry(.general).id
        } set: { newValue in
            if let newValue = newValue {
                selectedMenuItemID = newValue
            }
        }
    }
    
    var body: some View {
        NavigationView {
            SidebarListView(selection: selection)
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button {
                            toggleSidebar()
                        } label: {
                            Image(systemName: "sidebar.left")
                        }

                    }
                }
        }
        .frame(minWidth: 1000, minHeight: 390)
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
