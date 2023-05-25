//
//  PhotoListView.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 13.05.2023.
//

import SwiftUI

struct PhotoListView: View {
    
    @StateObject var photoListVM = PhotoListViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(photoListVM.photos) { photo in
                        PhotoPreviewView(photo: photo)
                    }
                    .padding(.all)
                }
                .padding(.all)
                
            }
            .task(listPhotos)
            .navigationTitle(Text("Editor Picks"))
        .padding()
        }
    }
    
    @Sendable
    func listPhotos() async {
        await photoListVM.listPhotos()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}

struct PhotoPreviewView: View {
    
    var photo: Photo
    
    
    var body: some View {
        if let smallImageURL = URL(string: photo.urls.small) {
            VStack{
                AsyncImage(url: smallImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding(.all)
                        .shadow(radius: 8)
                    
                } placeholder: {
                    ProgressView()
                }
                
            }
        }
    }
}
