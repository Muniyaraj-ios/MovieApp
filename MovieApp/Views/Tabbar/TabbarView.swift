//
//  TabbarView.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import SwiftUI

struct TabbarView: View {
    @State var selectedTab = Tab.popular
    
    enum Tab: Int {
        case popular, favourites
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MoviesListView().tabItem{
                self.tabbarItem(text: "Movies", image: "film")
            }.tag(Tab.popular)
            EmptyView().tabItem{
                self.tabbarItem(text: "Favourites", image: "heart.circle")
            }.tag(Tab.favourites)
        }
    }
}
