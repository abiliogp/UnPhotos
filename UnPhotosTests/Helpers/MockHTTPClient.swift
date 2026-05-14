//
//  MockHTTPClient.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 14/05/2026.
//

import Foundation
@testable import UnPhotos

class MockHTTPClient: HTTPClient {
    private let result: Data
    private let response: HTTPURLResponse
    
    init(result: Data, responseStatusCode: Int = 200) {
        self.result = result
        self.response = makeURLResponse(statusCode: responseStatusCode)
    }
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        return (result, response)
    }
}
