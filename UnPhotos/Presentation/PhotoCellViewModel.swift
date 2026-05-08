//
//  PhotoCellViewModel.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 05/05/2026.
//

import Combine
import SwiftUI

@MainActor
class PhotoCellViewModel: ObservableObject {
    
    let photo: Photo?
    
    @Published var image: Image?
    
    var imageDownloader: ImageDownloader
    
    var id: String {
        return photo?.urls.smallS3 ?? "id"
    }
    
    init(photo: Photo?, imageDownloader: ImageDownloader) {
        self.photo = photo
        self.imageDownloader = imageDownloader
    }
    
    func getImage()  async  {
        guard let photo = photo, let urlImage = URL(string: photo.urls.smallS3) else {
            return
        }
        
        do {
            guard let dataImage = try? await imageDownloader.download(from: urlImage) else {
                return
            }
            try Task.checkCancellation()
            guard let uiImage = UIImage(data: dataImage) else {
                return
            }
            self.image = Image(uiImage: uiImage)
        } catch {
            return
        }
    }
}
