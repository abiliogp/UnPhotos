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
    
    var id: String {
        return photo?.id ?? UUID().uuidString
    }
    
    init(photo: Photo?) {
        self.photo = photo
    }
    
    func getImage(imageDownloader: ImageDownloader = .init())  async  {
        do {
            guard let photo = photo else {
                return
            }
            guard let urlImage = URL(string: photo.urls.smallS3) else {
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
