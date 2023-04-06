//
//  FocusedValue+RefreshAction.swift
//  MultiplatformNewsAppMac
//
//  Created by Andrei Panasenko on 06.04.2023.
//

import SwiftUI

fileprivate var _refreshAction: (() -> Void)?

extension FocusedValues {
    var refershAction: (() -> Void)? {
        get {
            _refreshAction
        }
        
        set {
            _refreshAction = newValue
        }
    }
    
    struct RefreshActionKey: FocusedValueKey {
        typealias Value = () -> Void
    }
}
