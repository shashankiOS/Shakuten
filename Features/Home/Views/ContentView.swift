//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Image("shakuten")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 50)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 24) {
                
                    HomeHeroBannerView(banner: viewModel.featuredBanner)
                    HomeCategoryStripView(
                        categories: viewModel.categories,
                        selectedCategoryID: viewModel.selectedCategoryID,
                        onCategorySelected: viewModel.selectCategory
                    )

                    if let errorMessage = viewModel.errorMessage {
                        ErrorStateView(message: errorMessage) {
                            Task { await viewModel.load() }
                        }
                    } else {
                        ForEach(viewModel.rails) { rail in
                            HomeRailSectionView(title: rail.title, shows: rail.shows)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .background(backgroundGradient)
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
            .navigationDestination(for: Show.self) { show in
                VidePlayScreen(show: show)
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView().tint(.white)
                }
            }
        
        
        .task {
            await viewModel.loadIfNeeded()
        }
    }

    
}

#Preview {
    ContentView(viewModel: HomeViewModel(catalogService: MockCatalogService()))
}
