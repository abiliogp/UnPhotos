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

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.photos, id: \.id) { photo in
                    PhotoCellView(
                        photo: photo,
                        imageDownloader: coordinator.imageDownloader,
                    )
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
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(
                title: Text("Search got error"),
                message: Text(viewModel.errorDescription),
                dismissButton: Alert.Button.default(Text("Retry")) {
                    Task {
                        try await viewModel.search()
                    }
                })
            
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
        viewModel: PhotosViewModel(
            photosLoader: LocalPhotosLoader(),
        ),
        coordinator: .init(),
    )
}
