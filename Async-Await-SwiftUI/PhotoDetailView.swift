//
//  PhotoDetailView.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 15.05.2023.
//

import SwiftUI

struct PhotoDetailView: View {
    
    var photo: Photo
    
    var body: some View {
        ScrollView {
            VStack {
                if let fullImage = URL(string: photo.urls.full){
                    AsyncImage(url: fullImage) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                                .frame(maxHeight: 500)
                                .shadow(radius: 8)
                                .accessibilityLabel(Text(photo.alt ?? ""))
                                .padding(.all)
                        } else {
                            EmptyView()
                        }
                    }

                } else {
                    PhotoPreviewView(photo: photo)
                }
                
                if let description = photo.description {
                    Text(description)
                        .padding(.all)
                }
                
                VStack {
                    HStack {
                        Text("Creator")
                            .bold()
                            .padding(.trailing,10)
                        if let userURL = URL(string: photo.user.links.html) {
                            Link(photo.user.name, destination: userURL)
                        } else {
                            Text(photo.user.name)
                        }
                        Spacer()
                    }
                }.padding(.all)
                
                
                
            }
            .navigationTitle(Text("Photo Detail"))
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhotoDetailView(photo: .init(description: "This climb to Roy’s Peak seemed like a great idea when I read the description on New Zealand’s Department of Conservation’s website. “Easy Walk”, they said. After a painstaking 3-hour climb, my feet were practically bleeding and I was quite dehydrated.  The only thing I wanted to do was run back down to go back to my hotel—but not before taking some shots of the exquisite view.", alt: "person standing on top of hill", urls: .init(full: "https://images.unsplash.com/photo-1498598457418-36ef20772bb9?crop=entropy&cs=srgb&fm=jpg&ixid=M3w0NDgxMTZ8MHwxfHNlYXJjaHwxfHxWaWV3fGVufDB8fHx8MTY4NDE2NzE1NXww&ixlib=rb-4.0.3&q=85", small: "https://images.unsplash.com/photo-1498598457418-36ef20772bb9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NDgxMTZ8MHwxfHNlYXJjaHwxfHxWaWV3fGVufDB8fHx8MTY4NDE2NzE1NXww&ixlib=rb-4.0.3&q=80&w=400"), user: .init(name: "Félix Lam", links: .init(html: "https://unsplash.com/@feliixlam"))))
        }
    }
}
