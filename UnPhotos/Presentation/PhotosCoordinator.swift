//
//  PhotosCoordinator.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 04/05/2026.
//

import SwiftUI
import Combine

final class PhotosCoordinator: ObservableObject {
    enum Route: Hashable {
        case detailView(photo: Photo)
    }
    
    @Published var path = NavigationPath()
    let imageDownloader = ImageDownloader()
    
    func goToDetail(photo: Photo) {
        path.append(Route.detailView(photo: photo))
    }
    
    func goBack() {
        path.removeLast()
    }
}

