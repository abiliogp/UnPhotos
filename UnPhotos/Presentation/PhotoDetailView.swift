//
//  PhotoDetailView.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 04/05/2026.
//

import SwiftUI

struct PhotoDetailView: View {
    let viewModel: PhotoDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            PhotoCellView(
                photo: viewModel.photo,
                imageDownloader: viewModel.imageDownloader
            )
                
            Divider()
            
            Group {
                Text("Description: \(viewModel.description)")
            
                Text("Tags: \(viewModel.tags)")
            }.padding(.horizontal, 16)
        }
    }
}

#Preview {
    Preview.AsyncPreview { viewModel in
        PhotoDetailView(viewModel: viewModel)
    } action: {
        let photo = try await LocalPhotosLoader.shared.getPhoto()
        return PhotoDetailViewModel(
            photo: photo,
            imageDownloader: .init()
        )
    }
}
