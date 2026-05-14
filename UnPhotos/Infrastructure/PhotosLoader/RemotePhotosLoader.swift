//
//  RemotePhotosLoader.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import Foundation

protocol PhotosLoader {
    func search(query: String, page: Int, perPage: Int) async throws -> ListPhotos
}

class RemotePhotosLoader : PhotosLoader {
    private let client: HTTPClient
    
    init(client: HTTPClient = RemoteHTTPClient()) {
        self.client = client
    }
    
    func search(query: String, page: Int, perPage: Int) async throws -> ListPhotos {
        guard let url = URL(string: Environment.getValue(for: .Endpoint)) else {
            throw HTTPErrors.invalidURL
        }
        
        let queryItems: [URLQueryItem] = [
            .init(key: .query, value: query),
            .init(key: .clientId, value: Environment.getValue(for: .ApiID)),
            .init(key: .page, value: String(page)),
            .init(key: .perPage, value: String(perPage))
        ]
        
        let (data, response) = try await client.get(from: url.appending(queryItems: queryItems))
        return try await PhotosMapper.map(data: data, response: response)
    }
}

private extension URLQueryItem {
    enum Keys: String {
        case query = "query"
        case clientId = "client_id"
        case page = "page"
        case perPage = "per_page"
    }

    init(key: Keys, value: String) {
        self = URLQueryItem.init(name: key.rawValue, value: value)
    }
}

