//
//  PhotoDetailView.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import SwiftUI

struct PhotoCellView: View {
    @StateObject private var viewModel: PhotoCellViewModel
    
    init(photo: Photo?, imageDownloader: ImageDownloader) {
        self._viewModel = StateObject(wrappedValue: PhotoCellViewModel(photo: photo, imageDownloader: imageDownloader))
    }
    
    var body: some View {
        Group {
            if let image = viewModel.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(.gray)
        .cornerRadius(8)
        .padding(16)
        .task(id: viewModel.id) {
            await viewModel.getImage()
        }
    }
}

#Preview("Photo Ready") {
    Preview.AsyncPreview { photo in
        PhotoCellView(photo: photo, imageDownloader: .init())
    } action: {
        let photo = try? await LocalPhotosLoader.shared.getPhoto()
        return photo!
    }
}

#Preview("Photo Loading") {
    PhotoCellView(
        photo: nil,
        imageDownloader: .init(),
    )
}
