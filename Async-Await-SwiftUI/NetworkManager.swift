//
//  NetworkManager.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 13.05.2023.
//

import Foundation

struct URLPath {
    static let search = "search"
    static let photos = "photos"
}


class NetworkManager {
    final let baseURL = URL(string: "https://api.unsplash.com")
    
    func buildURL(searchTerm: String = "") -> URL? {
        if searchTerm.isEmpty {
            if let baseURL {
                let reader = KeyReader.shared
                let licenseQuery = URLQueryItem(name: "client_id", value: reader.accessKey)
                let requestURL = baseURL
                    .appending(path: URLPath.photos)
                    .appending(queryItems: [licenseQuery])
                return requestURL
            } else {
                return nil
            }
        } else {
            if let baseURL {
                let reader = KeyReader.shared
                let licenseQuery = URLQueryItem(name: "client_id", value: reader.accessKey)
                let searchQuery = URLQueryItem(name: "query", value: searchTerm)
                let requestURL = baseURL
                    .appending(path: URLPath.search)
                    .appending(path: URLPath.photos)
                    .appending(queryItems: [licenseQuery, searchQuery])
                return requestURL
                
            } else {
                return nil
            }
        }
    }
}


