//
//  ImageDownloader.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 05/05/2026.
//

import Foundation

final actor ImageDownloader {
    private var urlCache: URLCache
    private let urlSession: URLSession
    private var memoryCache: ImageCacher

    init() {
        self.urlCache = URLCache(
            memoryCapacity: 1024 * 1024 * 100,
            diskCapacity: 1024 * 1024 * 100
        )
        
        let config: URLSessionConfiguration = .default
        config.urlCache = urlCache
        config.requestCachePolicy = .returnCacheDataElseLoad
        
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

final actor ImageCacher {
    private var memoryCache: NSCache<NSString, NSData>
    
    init(memoryCache: NSCache<NSString, NSData> = NSCache()) {
        self.memoryCache = memoryCache
        self.memoryCache.countLimit = 100
    }
    
    func get(key: String) -> Data? {
        return memoryCache.object(forKey: key as NSString) as? Data
    }
    
    func put(key: String, value: Data) {
        memoryCache.setObject(value as NSData, forKey: key as NSString)
    }
}
