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
        VStack {
            PhotoCellView(viewModel: viewModel.photoDetailViewModel)
                
            Divider()
            Text("Description: \(viewModel.description)")
        }
        
    }
}
