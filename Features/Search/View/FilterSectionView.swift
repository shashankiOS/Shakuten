//
//  FilterSectionView.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//

import SwiftUI
struct FilterSectionView : View{
    var viewModel : SearchViewModel
    @Binding var catogery: String

    init(viewModel: SearchViewModel, catogery: Binding<String>) {
        self.viewModel = viewModel
        self._catogery = catogery
    }
    var body : some View{
        HStack {
            Text("\(self.catogery)")
                .font(.headline)
                .foregroundColor(.white)
            
            
            Button {
                catogery = ""
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .font(.title3)
            }
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
}
#Preview {
    SearchView()
}
