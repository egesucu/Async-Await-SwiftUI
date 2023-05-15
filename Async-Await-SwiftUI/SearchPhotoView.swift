//
//  SearchPhotoView.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 15.05.2023.
//

import SwiftUI

struct SearchPhotoView: View {
    
    @StateObject var photoListVM = PhotoListViewModel()
    @State private var searchContent = ""
    @State private var errorOccured = false
    @State private var errorText = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if errorOccured {
                    PhotoErrorView(errorText: $errorText)
                } else {
                    if searchContent.isEmpty {
                        Text("Start searching to see related photos.")
                    } else {
                        ScrollView {
                            ForEach(photoListVM.photos) { photo in
                                NavigationLink {
                                    PhotoDetailView(photo: photo)
                                } label: {
                                    PhotoPreviewView(photo: photo)
                                }
                            }
                            .padding(.all)
                        }
                    }
                }
            }
            .navigationTitle(Text("Search Photos"))
            .searchable(text: $searchContent)
            .onSubmit(of: .search, searchPhotos)
            .onChange(of: searchContent) { newValue in
                if newValue.isEmpty {
                    errorOccured = false
                    errorText = ""
                }
            }
            
        }
    }
    
    func searchPhotos() {
        if searchContent.isEmpty {
            errorText = "You did not enter any keywords."
            errorOccured = true
        } else {
            if searchContent.count > 2 {
                self.errorOccured = false
                Task {
                    await photoListVM.searchPhotos(with: searchContent, emptyResulted: {
                        self.errorText = "We couldn't find any solution related to your search."
                        self.errorOccured = true
                    })
                }
            } else {
                errorText = "You need to type at least 3 characters."
                errorOccured = true
            }
        }
    }
}

struct SearchPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotoView()
    }
}

struct PhotoErrorView: View {
    
    @Binding var errorText: String
    
    
    var body: some View {
        Text(errorText)
            .multilineTextAlignment(.center)
            .bold()
    }
}
