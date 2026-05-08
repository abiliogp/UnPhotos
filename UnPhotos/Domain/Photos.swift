//
//  Photos.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 30/04/2026.
//

import Foundation

// MARK: - ListPhotos
public struct ListPhotos: Codable {
    var total: Int
    var totalPages: Int
    var results: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Photo
public struct Photo: Codable, Hashable, Equatable {
    var id: String
    var slug: String
    var width: Int
    var height: Int
    var description: String?
    var urls: PhotoUrls
    var links: ResultLinks
    var tags: [Tag]?
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case width
        case height
        case description
        case urls
        case links
        case tags
        case user
    }
   
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - ResultLinks
public struct ResultLinks: Codable {
    var linksSelf: String
    var html: String
    var download: String
    var downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
}

// MARK: - Tag
public struct Tag: Codable {
    var title: String
    var source: Source?
}

// MARK: - Source
public struct Source: Codable {
    var title: String
    var subtitle: String
    var description: String
    var metaTitle: String
    var metaDescription: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case description
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
    }
}

// MARK: - PhotoUrls
public struct PhotoUrls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
    var smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User
struct User: Codable {
    var username: String
    var name: String
    var firstName: String
    var lastName: String?
    var bio: String?
    var location: String?

    enum CodingKeys: String, CodingKey {
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
        case location
    }
}
