//
//  ArticleNewsVM.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

class ArticleNewsVM: ObservableObject {
    @Published var phase = DataFetchPhase<[ArticleModel]>.empty
    
    private let newsAPI = NewsAPI.shared
}
