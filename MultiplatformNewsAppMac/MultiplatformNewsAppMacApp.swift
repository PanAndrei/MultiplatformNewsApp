//
//  MultiplatformNewsAppMacApp.swift
//  MultiplatformNewsAppMac
//
//  Created by Andrei Panasenko on 04.04.2023.
//

import SwiftUI

@main
struct MultiplatformNewsAppMacApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkVM.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
        .commands {
            SidebarCommands()
            NewsCommands()
        }
    }
}
