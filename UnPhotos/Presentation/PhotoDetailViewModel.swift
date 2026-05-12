//
//  PhotoDetailViewModel.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 04/05/2026.
//

class PhotoDetailViewModel {
    let photo: Photo
    let imageDownloader: ImageDownloader
    
    init(photo: Photo, imageDownloader: ImageDownloader) {
        self.photo = photo
        self.imageDownloader = imageDownloader
    }
    
    var description: String {
        photo.description ?? photo.altDescription ?? "--"
    }

    var tags: String {
        photo.tags?.compactMap(\.title).joined(separator: ", ") ?? "--"
    }
}
