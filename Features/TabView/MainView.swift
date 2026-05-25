//
//  MainView.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//
import SwiftUI

struct MainTabView: View {

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.2)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {

            NavigationStack {
                ContentView(viewModel: HomeViewModel(catalogService: MockCatalogService()))
                    .toolbar(.hidden, for: .navigationBar)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            NavigationStack {
                SearchView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }

            NavigationStack {
                DownloadView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .tabItem {
                Image(systemName: "arrow.down.circle")
                Text("Downloads")
            }

            NavigationStack {
                ProfileView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
        .tint(.black)
    }
}
