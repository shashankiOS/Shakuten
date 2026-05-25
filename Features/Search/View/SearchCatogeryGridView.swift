//
//  SearchCatogeryGridView.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//
import SwiftUI

struct SearchCatogeryGridView : View{
    var viewModel : SearchViewModel
    @State var catogery: String
    @Environment(\.dismiss) var dismiss

    init(viewModel: SearchViewModel , catogery :String) {
        self.viewModel = viewModel
        self.catogery = catogery
    }
    var body : some View{
        let columns = [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ]
        ZStack{
            backgroundGradient
                       .ignoresSafeArea()
            VStack(alignment : .leading){
                FilterSectionView(
                    viewModel: viewModel,
                    catogery: $catogery   
                )
                    .padding(.leading, 16)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(  self.viewModel.shows, id: \.self) { show in
                            
                            VStack{
                                Image("\(show.imageName)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 90)
                                    .cornerRadius(12)
                                Text("\(show.title)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                HStack(spacing: 4) {
                                    Text(show.genre)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Label(String(format: "%.1f", show.rating), systemImage: "star.fill")
                                        .font(.subheadline)
                                        .foregroundColor(.yellow)
                                    
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    .padding()
                    
                    
                }
            }
        }        .toolbar(.hidden, for: .navigationBar)
            .onChange(of: catogery) { newValue in
                if newValue.isEmpty {
                    dismiss()
                }
            }


    }

}
#Preview {
    SearchCatogeryGridView(viewModel: SearchViewModel(filterModel: FilterModel(id: 1, Region: "Korea", format: "3D", genres: "Romance", title: "han")), catogery: "India")
                           
}
