//
//  Photo.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 13.05.2023.
//

import Foundation

typealias UnsplashURL = String

struct DataResponse: Codable {
    var results: [Photo]
}


struct Photo: Codable, Hashable, Identifiable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.description == rhs.description
    }
    
    var id = UUID().uuidString
    
    var description: String?
    var alt: String?
    var urls: PhotoUrl
    var user: PhotoUser
    
    enum CodingKeys: String, CodingKey {
        case alt = "alt_description"
        case description, urls, user
    }
}

struct PhotoUrl: Codable, Hashable {
    
    static func == (lhs: PhotoUrl, rhs: PhotoUrl) -> Bool {
        lhs.full == rhs.full
    }
    
    var full: UnsplashURL
    var small: UnsplashURL
}

struct PhotoUser: Codable, Hashable {
    
    static func == (lhs: PhotoUser, rhs: PhotoUser) -> Bool {
        lhs.name == rhs.name
    }
    
    var name: String
    var links: PhotoUserLink
}

struct PhotoUserLink: Codable, Hashable {
    static func == (lhs: PhotoUserLink, rhs: PhotoUserLink) -> Bool {
        lhs.html == rhs.html
    }
    var html: UnsplashURL
}
