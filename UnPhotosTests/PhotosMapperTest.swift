//
//  PhotosMapperTest.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 13/05/2026.
//

import Testing
import Foundation
@testable import UnPhotos

struct PhotosMapperTest {
    @Test
    func testPhotosMapperSuccessWhenOK() async throws {
        let data = try makeJsonData()
        let response = try await PhotosMapper.map(data: data, response: makeURLResponse(statusCode: 200))
        
        await response.results.forEach {
            #expect($0.id == "jDCNQ3pVyaw")
            #expect($0.width == 4024)
            #expect($0.height == 5030)
        }
    }
    
    @Test
    func testPhotosMapperFailWhenAnyNOKCode() async throws {
        let data = try makeJsonData()
        let samples = [199, 201, 300, 500]
        for statusCode in samples {
            await #expect(throws: HTTPErrors.other.self) {
                try await PhotosMapper.map(data: data, response: makeURLResponse(statusCode: statusCode))
            }
        }
    }
    
    @Test
    func testMapGotError() async throws {
        let invalidData = Data("Invalid".utf8)
        
        await #expect(throws: HTTPErrors.invalidData.self) {
            try await PhotosMapper.map(data: invalidData, response: makeURLResponse(statusCode: 200))
        }
    }
}
