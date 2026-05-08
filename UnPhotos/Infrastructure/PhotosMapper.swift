//
//  PhotosMapper.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import Foundation

enum PhotosMapper {
    static func map(data: Data, response: URLResponse) async throws -> ListPhotos {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw HTTPErrors.other
        }
        
        guard let photos = try? JSONDecoder().decode(ListPhotos.self, from: data) else {
            throw HTTPErrors.invalidData
        }
        return photos
    }
}
