//
//  PhotosViewModel.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//
import Combine
import Foundation

@MainActor
class PhotosViewModel: ObservableObject {
    @Published private(set) var photos: [Photo] = []
    @Published var query: String = ""
    @Published var errorDescription = ""
    @Published var isShowingError = false
    
    private let photosLoader: PhotosLoader
    
    private var page = 1
    private var hasMorePages = true
    private var isLoading = false
    
    init(
        photosLoader: PhotosLoader,
    ) {
        self.photosLoader = photosLoader
    }
    
    func search() async throws {
        clear()
        try await loadNextPage()
    }
    
    func loadMoreIfNeeded(currentPhoto: Photo) async throws {
        guard shouldLoadMore(photo: currentPhoto) else {
            return
        }
        
        try await loadNextPage()
    }
    
    private func loadNextPage() async throws {
        guard !isLoading, hasMorePages, !query.isEmpty else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await photosLoader.search(query: query, page: page, perPage: 5)
            addNewPhotos(response.results)
            hasMorePages = page < response.totalPages
            page += 1
        } catch is CancellationError {
            throw CancellationError()
        } catch {
            self.errorDescription = error.localizedDescription
            self.isShowingError = true
        }
    }
    
    private func addNewPhotos(_ newPhotos: [Photo]) {
        let existingPhotos = Set(self.photos.map(\.id))
        let filtered = newPhotos.filter {
            !existingPhotos.contains($0.id)
        }
        
        self.photos.append(contentsOf: filtered)
    }
    
    private func shouldLoadMore(photo: Photo) -> Bool {
        return photos.last?.id == photo.id
    }
    
    private func clear() {
        page  = 1
        hasMorePages = true
        photos.removeAll()
        errorDescription = ""
        isShowingError = false
    }
}
