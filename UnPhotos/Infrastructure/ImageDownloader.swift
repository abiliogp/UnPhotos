//
//  ImageDownloader.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 05/05/2026.
//

import Foundation

final actor ImageDownloader {
    private let urlCache: URLCache
    private let urlSession: URLSession
    private let memoryCache: ImageCacher
    
    init() {
        self.urlCache = URLCache(
            memoryCapacity: 1024 * 1024 * 100,
            diskCapacity: 1024 * 1024 * 100
        )
        
        let config: URLSessionConfiguration = .default
        config.urlCache = urlCache
        config.requestCachePolicy = .useProtocolCachePolicy
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        
        urlSession = URLSession(configuration: config)
        
        memoryCache = ImageCacher()
    }
    
    func download(from url: URL) async throws -> Data? {
        if let imageCached = await memoryCache.get(key: url.absoluteString) {
            return imageCached
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        await memoryCache.put(key: url.absoluteString, value: data)
        
        return data
    }
}
