//
//  ImageDownloaderTest.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 14/05/2026.
//

import Testing
import Foundation
@testable import UnPhotos

@Suite(.serialized)
struct ImageDownloaderTest {
    @Test("Retrieve Data When Cached")
    func testRetrieveDataWhenCached() async throws {
        let data = try makeJsonData()
        let url = anyURL()
        let imageCache = ImageCacher()
        await imageCache.put(key: url.absoluteString, value: data)
        let sut = ImageDownloader(memoryCache: imageCache)
        
        let result = try await sut.download(from: url)
        
        #expect(result == data)
    }
    
    @Test("Get Image from Network when not cachec")
    func testGetFromNetworkWhenNotCached() async throws {
        let urlConfiguration = URLSessionConfiguration.ephemeral
        urlConfiguration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: urlConfiguration)
        let jsonData = try makeJsonData()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (response, jsonData)
        }
        
        let sut = ImageDownloader(urlSession: urlSession)
        let result = try await sut.download(from: anyURL())
        #expect(result == jsonData)
    }
    
    @Test("Get Image throw error when network not ok")
    func testThrowErrorWhenNetworkFails() async throws {
        let urlConfiguration = URLSessionConfiguration.ephemeral
        urlConfiguration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: urlConfiguration)
        let jsonData = try makeJsonData()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (response, jsonData)
        }
        
        let sut = ImageDownloader(urlSession: urlSession)
        
        await #expect(throws: (any Error).self) {
            try await sut.download(from: anyURL())
        }
    }
}
