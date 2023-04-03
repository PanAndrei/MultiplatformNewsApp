//
//  TabMenuItem.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 03.04.2023.
//

import Foundation

enum TabMenuItem: String {
    case news
    case search
    case saved
    
    var text: String { rawValue.capitalized }
    var systemImage: String {
        switch self {
        case .news:
            return "newspaper"
        case .search:
            return "magnifyingglass"
        case .saved:
            return "bookmark"
        }
    }
    
    init(menuItem: MenuItems.ID?) {
        switch MenuItems(id: menuItem) {
        case .search:
            self = .search
        case .saved:
            self = .saved
        default:
            self = .news
        }
    }
    
    func menuItemId(category: Category?) -> MenuItems.ID {
        switch self {
        case .news:
            return MenuItems.categiry(category ?? .general).id
        case .search:
            return MenuItems.search.id
        case .saved:
            return MenuItems.saved.id
        }
    }
}

extension TabMenuItem: Identifiable, CaseIterable {
    var id: Self { self }
}
