//
//  TabBarView.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedIndex = 0
    
    init() {
       
        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemGray6
           
            UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoriteListView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
