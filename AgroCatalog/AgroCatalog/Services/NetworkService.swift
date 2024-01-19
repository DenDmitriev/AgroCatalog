//
//  NetworkService.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import Foundation

final class NetworkService {
    
    static let host = "shans.d2.i-partner.ru"
    static let scheme = "http"
    
    enum Method {
        case categories
        case catalog(id: Int?)
        case catalogItem(id: Int)
    }
    
    static func request(method: Method) async throws -> Data {
        switch method {
        case .categories:
            try await getCategories()
        case .catalog(let id):
            try await getCatalog(by: id)
        case .catalogItem(let id):
            try await getCatalog(item: id)
        }
    }
    
    static func url(for path: String?) -> URL? {
        guard let path else { return nil }
        let host = "http://shans.d2.i-partner.ru"
        return URL(string: host + path)
    }
    
    /// API Request for categories
    /// GET /api/ppp/categories HTTP/1.1
    /// Host: shans.d2.i-partner.ru
    static private func getCategories() async throws -> Data {
        let path = "/api/ppp/categories"
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        guard let url = components.url else { throw NetworkServiceError.invalidURL }
        let urlRequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        return data
    }
    
    /// API Request catalog drugs by category
    /// GET /api/ppp/index/?id={Category ID} HTTP/1.1
    /// Host: shans.d2.i-partner.ru
    static private func getCatalog(by categoryId: Int?) async throws -> Data {
        let path = "/api/ppp/index"
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        if let categoryId {
            components.queryItems = [
                URLQueryItem(name: "id", value: "\(categoryId)")
            ]
        }
        
        guard let url = components.url else { throw NetworkServiceError.invalidURL }
        let urlRequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        return data
    }
    
    /// API Request http://shans.d2.i-partner.ru/api/ppp/item/?id
    static private func getCatalog(item id: Int) async throws -> Data {
        let path = "/api/ppp/item"
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        components.queryItems = [
            URLQueryItem(name: "id", value: "\(id)")
        ]
        
        guard let url = components.url else { throw NetworkServiceError.invalidURL }
        let urlRequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        return data
    }
}

enum NetworkServiceError: LocalizedError {
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            String(localized: "Invalid URL")
        }
    }
}
