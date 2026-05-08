//
//  PhotoDetailViewModel.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 04/05/2026.
//

class PhotoDetailViewModel {
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var description: String {
        photo.description ?? "--"
    }
    
    var photoDetailViewModel: PhotoCellViewModel {
        .init(photo: photo)
    }
}
