//
//  RemoteHTTPClientTest.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 14/05/2026.
//

import Testing
import Foundation
@testable import UnPhotos

@Suite(.serialized)
struct RemoteHTTPClientTest {
    @Test("Get data from URL")
    func getFromURLSuccess() async throws {
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
        
        let sut = await RemoteHTTPClient(urlSession: urlSession)
        let (data, response) = try await sut.get(from: anyURL())
        
        #expect(data == jsonData)
        #expect(response.statusCode == 200)
    }
    
    @Test("Get error from URL")
    func getErrorFromURL() async throws {
        let urlConfiguration = URLSessionConfiguration.ephemeral
        urlConfiguration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: urlConfiguration)
        
        MockURLProtocol.requestHandler = { _ in
            throw HTTPErrors.other
        }
        
        let sut = await RemoteHTTPClient(urlSession: urlSession)
        
        await #expect(throws: HTTPErrors.other) {
            _ = try await sut.get(from: anyURL())
        }
    }
}
