//
//  RootView.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 04/05/2026.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var coordinator: PhotosCoordinator
    let viewModel: PhotosViewModel
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            PhotosView(
                viewModel: viewModel,
                coordinator: coordinator
            ).navigationDestination(for: PhotosCoordinator.Route.self) { route in
                    switch (route) {
                    case let .detailView(photo: photo):
                        PhotoDetailView(viewModel: PhotoDetailViewModel(
                            photo: photo,
                            imageDownloader: coordinator.imageDownloader
                        ))
                    }
                }
        }
    }
}
