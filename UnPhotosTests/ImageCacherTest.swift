//
//  ImageCacherTest.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 14/05/2026.
//

import Testing
import Foundation
@testable import UnPhotos

struct ImageCacherTest {
    @Test("Put images in cache concurrently")
    func putImagesInCache() async throws {
        let sut = ImageCacher()
        let data = try makeJsonData()
        
        await withTaskGroup(of: Void.self) { group in
            for index in 0..<10 {
                group.addTask {
                    await sut.put(key: "\(index)", value: data)
                }
            }
        }
        
        
        await withTaskGroup { group in
            for index in 0..<10 {
                group.addTask {
                    let result = await sut.get(key: "\(index)")
                    #expect(result == data)
                }
            }
        }
    }
}
