//
//  MockURLProtocol.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 14/05/2026.
//

import Foundation
final class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((
        URLRequest
    ) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let handler = Self.requestHandler else {
            fatalError("Handler unavailable.")
        }
        
        do {
            let (response, data) = try handler(request)
            
            client?.urlProtocol(
                self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
            
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
