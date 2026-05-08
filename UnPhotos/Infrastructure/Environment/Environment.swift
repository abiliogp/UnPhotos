//
//  Environment.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import Foundation

enum Environment {
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Missing config for dict")
        }
        return dict
    }()
    
    static func getValue(for key: Keys.Plist) -> String {
        guard let value = infoDict[key.rawValue] as? String else {
            fatalError("Missing config for \(key.rawValue)")
        }
        return value
    }
}
