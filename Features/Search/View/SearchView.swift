//
//  SearchView.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    var searchViewModel = SearchViewModel(filterModel: FilterModel(id: 1, Region: "Korea", format: "3D", genres: "Romance", title: "han"))
    @State private var selectedCategory: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Search Bar

            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.white)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray5).opacity(0.1))
            .cornerRadius(10)
           
            
            // MARK: - Catogery Section

            SearchCatogeryViewList(catogeries: searchViewModel.regions, title: "Region")
            { category in
                                
                                selectedCategory = category
                            }

            SearchCatogeryViewList(catogeries: searchViewModel.genres, title: "Genre")
            { category in
                                
                                selectedCategory = category
                            }

            SearchCatogeryViewList(catogeries: searchViewModel.format, title: "Format")
            { category in
                                
                                selectedCategory = category
                            }


            Spacer()
        }
        .padding()
        .background(backgroundGradient)
        .navigationDestination(isPresented: Binding(
                        get: { selectedCategory != nil },
                        set: { if !$0 { selectedCategory = nil } }
                    )) {
                        if let selectedCategory {
                            SearchCatogeryGridView(
                                viewModel: searchViewModel
                            , catogery: selectedCategory
                            )
                        }
                    }
    }
    
}
#Preview {
    SearchView()
}
