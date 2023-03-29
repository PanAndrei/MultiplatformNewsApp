//
//  MultiplatformNewsAppApp.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 27.03.2023.
//

import SwiftUI

@main
struct MultiplatformNewsAppApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkVM.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
