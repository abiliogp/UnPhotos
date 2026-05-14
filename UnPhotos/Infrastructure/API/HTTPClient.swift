//
//  HTTPClient.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL) async throws -> (Data, HTTPURLResponse)
}

class RemoteHTTPClient: HTTPClient {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func get(from url: URL) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await urlSession.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                return (data, httpResponse)
            } else {
                throw HTTPErrors.other
            }
        } catch {
            throw HTTPErrors.other
        }
    }
}
