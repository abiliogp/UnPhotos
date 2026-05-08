//
//  LocalPhotosLoader.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 08/05/2026.
//
import Foundation

class LocalPhotosLoader: PhotosLoader {
    static let shared = LocalPhotosLoader()
    
    private var cachedResult: ListPhotos?
    
    func getResult() async throws -> ListPhotos {
        if let cached = cachedResult {
            return cached
        }
        cachedResult = try await search(query: "", page: 0, perPage: 0)
        return cachedResult!
    }
    
    func getPhoto() async throws -> Photo {
        try await getResult().results.first!
    }
    
    func search(query: String, page: Int, perPage: Int) async throws -> ListPhotos {
        guard let url = Bundle.main.url(forResource: "photos", withExtension: ".json") else {
            throw URLError(.badURL)
        }
        let data = try Data(contentsOf: url)
        let result = try JSONDecoder().decode(ListPhotos.self, from: data)
        return result
    }
}
