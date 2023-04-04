//
//  MultiplatformNewsAppMacApp.swift
//  MultiplatformNewsAppMac
//
//  Created by Andrei Panasenko on 04.04.2023.
//

import SwiftUI

@main
struct MultiplatformNewsAppMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            SidebarCommands()
        }
    }
}
