//
//  NewsCommands.swift
//  MultiplatformNewsAppMac
//
//  Created by Andrei Panasenko on 06.04.2023.
//

import SwiftUI

struct NewsCommands: Commands {
    var body: some Commands {
        CommandGroup(before: .sidebar) {
            BodyView()
                .keyboardShortcut("R", modifiers: [.command])
        }
    }
    
    struct BodyView: View {
        @FocusedValue(\.refershAction) private var refreshAction: (() -> Void)?
        
        var body: some View {
            Button {
                refreshAction?()
            } label: {
                Text("Refersh News")
            }
        }
    }
}
