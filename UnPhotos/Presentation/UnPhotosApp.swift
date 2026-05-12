//
//  UnPhotosApp.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import SwiftUI

@main
struct UnPhotosApp: App {
    @StateObject private var coordinator = PhotosCoordinator()
    @StateObject private var photosViewModel = PhotosViewModel(photosLoader: RemotePhotosLoader())

    var body: some Scene {
        WindowGroup {
            RootView(viewModel: photosViewModel)
                .environmentObject(coordinator)
        }
    }
}
