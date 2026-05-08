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
    
    let photo: Photo
    
    @Published var image: Image?
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func getImage(imageDownloader: ImageDownloader = .init())  async  {
        do {
            guard let urlImage = URL(string: photo.urls.small) else {
                return
            }
            guard let dataImage = try await imageDownloader.download(from: urlImage) else {
                return
            }
            self.image = Image(uiImage: UIImage(data: dataImage)!)
        } catch {
        }
    }
    
}
