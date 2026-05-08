//
//  ContentView.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import SwiftUI

struct PhotosView: View {
    @StateObject var viewModel: PhotosViewModel
    let coordinator: PhotosCoordinator
    let imageDownloader: ImageDownloader
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.photos, id: \.id) { photo in
                        PhotoCellView(viewModel: viewModel.viewModel(for: photo))
                            .task {
                                try? await viewModel.loadMoreIfNeeded(currentPhoto: photo)
                            }
                            .onTapGesture {
                                coordinator.goToDetail(photo: photo)
                            }
                    }
                    .padding()
                }
            }
        }
        .searchable(text: $viewModel.query)
        .onSubmit(of: .search) {
            Task {
                try await viewModel.search()
            }
        }
    }
}

#Preview {
    PhotosView(
        viewModel: PhotosViewModel(photosLoader: LocalPhotosLoader()),
        coordinator: .init(),
        imageDownloader: .init()
    )
}
