//
//  ContentView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 27.03.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @AppStorage("item_selection") var selectionItemID: MenuItems.ID?
    
    var body: some View {
        switch horizontalSizeClass {
        case .regular:
            SidebarContentView(selectionItemID: $selectionItemID)
        default:
            TabContentView(selectionItemID: $selectionItemID)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
