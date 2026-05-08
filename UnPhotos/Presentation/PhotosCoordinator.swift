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
    
    func goToDetail(photo: Photo) {
        path.append(Route.detailView(photo: photo))
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func start() -> some View {
        let photosViewModel = PhotosViewModel()
        return PhotosView(viewModel: photosViewModel, coordinator: self, imageDownloader: .init())
    }
}

