//
//  ImageCacher.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 08/05/2026.
//
import Foundation

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
