//
//  LocalPhotosLoaderTest.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 13/05/2026.
//

import Testing
@testable import UnPhotos

struct LocalPhotosLoaderTest {
    @Test("Get Result Success")
    func testGetResultSuccess() async throws {
        let sut = await LocalPhotosLoader()
        let result = try await sut.getResult()
        #expect(result.results.count == 1)
    }
    
    @Test("Get Photo Success")
    func testGetPhotoSuccess() async throws {
        let sut = await LocalPhotosLoader()
        let photo = try await sut.getPhoto()
        #expect(photo.id == "jDCNQ3pVyaw")
    }
    
    @Test("Get Result call Search")
    func testGetResultCallsSearch() async throws {
        let sut = await LocalPhotosLoader()
        
        try await confirmation() { confirm in
            _ = try await sut.getResult()
            confirm.callAsFunction(count: 1)
        }
    }
}
