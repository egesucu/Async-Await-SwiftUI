//
//  PhotoListViewModel.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 13.05.2023.
//

import SwiftUI


class PhotoListViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var isSearching = false
    
    let networkManager = NetworkManager()
    
    @MainActor
    func searchPhotos(with searchTerm: String, emptyResulted: () -> ()) async {
        self.photos.removeAll()
        isSearching = true
        let requestURL = networkManager.buildURL(searchTerm: searchTerm)
        if let requestURL {
            self.photos = await executeSearch(url: requestURL, forSearch: true)
            if self.photos.isEmpty {
                emptyResulted()
            }
        }
        isSearching = false
    }
    
    @MainActor
    func listPhotos() async {
        isSearching = true
        let requestURL = networkManager.buildURL()
        if let requestURL {
            self.photos = await executeSearch(url: requestURL)
        }
    }
    
    private func executeSearch(url: URL, forSearch: Bool = false) async -> [Photo] {
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               return []
            }
            if forSearch {
                let dataResponse = try JSONDecoder().decode(DataResponse.self, from: data)
                return dataResponse.results
            } else {
                let dataResponse = try JSONDecoder().decode([Photo].self, from: data)
                return dataResponse
            }
            
        } catch let error {
            print(error)
        }
        return []
    }
    
}
