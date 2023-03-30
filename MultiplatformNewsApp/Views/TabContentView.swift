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
            NavigationView {
                NewsTabView()
            }
            .tabItem {
                Label("News", systemImage: "newspaper")
            }
            NavigationView {
                SearchTabView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            NavigationView {
                BookmarkTabView()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark")
            }
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
