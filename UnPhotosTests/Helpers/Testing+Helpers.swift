//
//  Testing+Helpers.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 14/05/2026.
//

import Testing
import Foundation

func makeJsonData() throws -> Data {
    let url = Bundle.main.url(forResource: "photos", withExtension: ".json")!
    let data = try Data(contentsOf: url)
    return data
}

func makeURLResponse(statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func anyURL() -> URL {
    return URL(string: "www.test.com")!
}
