//
//  PhotoDetailView.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import SwiftUI

struct PhotoCellView: View {
    @ObservedObject var viewModel: PhotoCellViewModel
    
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
    Preview.AsyncPreview { result in
        PhotoCellView(viewModel: result)
    } action: {
        let photo = try? await LocalPhotosLoader.shared.getPhoto()
        return .init(photo: photo)
    }
}

#Preview("Photo Loading") {
    PhotoCellView(viewModel: .init(photo: nil))
}
