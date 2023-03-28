//
//  ArticleAPIResponse.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import Foundation

struct ArticleAPIResponse: Decodable {
    let status: String
    
    let totalResults: Int?
    let articles: [ArticleModel]?
    
    let code: String?
    let message: String?
    
    // todo coding keys
}
