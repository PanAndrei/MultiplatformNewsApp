//
//  ArticleModel.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import Foundation

struct ArticleModel {
    let source      : Source
    let title       : String
    let url         : String
    let publishedAt : Date
    
    let author      : String?
    let description : String?
    let urlToImage  : String?
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else { return nil }
        return URL(string: urlToImage)
    }
    
    // todo coding keys
}

extension ArticleModel: Codable {}
extension ArticleModel: Equatable {}
extension ArticleModel: Identifiable {
    var id: String { url }
}

extension ArticleModel {
    static var previewData: [ArticleModel] {
        let previewDataURL = Bundle.main.url(forResource: "ArticleMoc", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(ArticleAPIResponse.self, from: data)
        return apiResponse.articles ?? []
    }
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}
