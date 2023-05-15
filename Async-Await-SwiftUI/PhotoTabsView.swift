//
//  PhotoTabsView.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 15.05.2023.
//

import SwiftUI

struct PhotoTabsView: View {
    var body: some View {
        TabView {
            PhotoListView()
                .tabItem {
                    Label("Editor Picks", systemImage: "photo")
                }
            SearchPhotoView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct PhotoTabsView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoTabsView()
    }
}
