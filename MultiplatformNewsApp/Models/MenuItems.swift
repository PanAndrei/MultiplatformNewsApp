//
//  MenuItems.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 30.03.2023.
//

import Foundation

enum MenuItems: CaseIterable {
    case search
    case saved
    case categiry(Category)
    
    var text: String {
        switch self {
        case .search:
           return "Search"
        case .saved:
           return "Saved"
        case .categiry(let category):
            return category.text
        }
    }
    
    var systemImage: String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .saved:
            return "bookmark"
        case .categiry(let category):
            return category.systemImage
        }
    }
    
    static var allCases: [MenuItems] {
        return [.search, saved] + Category.menuItems
    }
}

extension MenuItems: Identifiable {
    var id: String {
        switch self {
        case .search:
            return "search"
        case .saved:
            return "saved"
        case .categiry(let category):
            return category.rawValue
        }
    }
}
