//
//  RemotePhotosLoaderTest.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 14/05/2026.
//

import Testing
import Foundation
@testable import UnPhotos

struct RemotePhotosLoaderTest {
    @Test("Get remote photos success")
    func testGetRemotePhotosSuccess() async throws {
        let dataPhotos = try makeJsonData()
        let mockHttpClient = MockHTTPClient(result: dataPhotos)
        
        let sut = await RemotePhotosLoader(client: mockHttpClient)
        let result = try await sut.search(query: "", page: 0, perPage: 0)
        #expect(result.results.count == 1)
    }
    
    @Test("Get remote photos fails on invalid data")
    func testGetRemotePhotosFails() async throws {
        let invalidData = Data("Invalid".utf8)

        let mockHttpClient = MockHTTPClient(result: invalidData)
        let sut = await RemotePhotosLoader(client: mockHttpClient)
        
        await #expect(throws: HTTPErrors.invalidData) {
            _ = try await sut.search(query: "", page: 0, perPage: 0)
        }
    }
}
