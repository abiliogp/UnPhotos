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
    
    let imageDownloader: ImageDownloader
    let id: String
    
    init(photo: Photo?, imageDownloader: ImageDownloader) {
        self.photo = photo
        self.imageDownloader = imageDownloader
        self.id = photo?.urls.smallS3 ?? UUID().uuidString
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
