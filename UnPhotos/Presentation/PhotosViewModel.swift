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
    
    private let photosLoader: PhotosLoader
    
    private var cellViewModels: [String: PhotoCellViewModel] = [:]
    
    private var page = 0
    private var total = 0
    private var hasMorePages = true
    private var isLoading = false
    
    init(photosLoader: PhotosLoader) {
        self.photosLoader = photosLoader
    }
    
    convenience init() {
        self.init(photosLoader: RemotePhotosLoader())
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
    
    func viewModel(for photo: Photo) -> PhotoCellViewModel {
         if let existing = cellViewModels[photo.id] {
             return existing
         }
         let vm = PhotoCellViewModel(photo: photo, imageDownloader:
                .init())
         cellViewModels[photo.id] = vm
         return vm
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
            // Network errors
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
        page  = 0
        total = 0
        hasMorePages = true
        photos.removeAll()
    }
}
