//
//  NewsAPI.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 28.03.2023.
//

import Foundation

struct NewsAPI {
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKEY = "9d3a3d6cb8684dd0a39af3fafed57431"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from category: Category) async throws -> [ArticleModel] {
        try await fetchArticles(from: generateNewsURL(from: category))
    }
    
    func search(for query: String) async throws -> [ArticleModel] {
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateNewsURL(from category: Category) -> URL { // TODO: to parameters
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKEY)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    }
    
    private func generateSearchURL(from query: String) -> URL {
        let percentEncodingString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query

        var url = "https://newsapi.org/v2/everything?"
        url += "apiKey=\(apiKEY)"
        url += "&language=en"
        url += "&q=\(percentEncodingString)"
        return URL(string: url)!
    }
    
    private func fetchArticles(from url: URL) async throws -> [ArticleModel] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(ArticleAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "An error occured")
            }
        default:
            throw generateError(description: "A server error occured")
        }
    }
}
