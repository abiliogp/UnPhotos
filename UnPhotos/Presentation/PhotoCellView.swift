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
                    .frame(minWidth: 0, maxHeight: 200)
                    .fixedSize()
            } else {
                ProgressView()
            }
        }
        .task(id: viewModel.photo.id) {
            await viewModel.getImage()
        }
        .foregroundStyle(.tint)
    }
}

