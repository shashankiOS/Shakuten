//
//  SearchCatogeryViewList.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//

import SwiftUI
 struct SearchCatogeryViewList: View {
     var catogeries : [String]
     var title : String
     var onSelect: (String) -> Void

    var body: some View {
        VStack{
            HStack {
                Text("\(title)")
                    .font(Font.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
                
            }
            .padding(.trailing, 16)
            let shouldShowSecondRow = catogeries.count > 5

            let mid = (catogeries.count + 1) / (shouldShowSecondRow ? 2 : 1)

            let firstRow = Array(catogeries.prefix(mid))
            let secondRow = shouldShowSecondRow ? Array(catogeries.dropFirst(mid)) : []
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack(spacing: 8) {
                        ForEach(firstRow, id: \.self) { category in
                            TitleSearchBoxView(title: category){
                                onSelect(category)
                            }
                        }
                    }
                    
                    if !secondRow.isEmpty {
                        HStack(spacing: 8) {
                            ForEach(secondRow, id: \.self) { category in
                                TitleSearchBoxView(title: category){
                                    onSelect(category)
                                }
                            }
                        }
                    }
                }
            }
            
        }
       
    }
    
}
#Preview {
    SearchView()
}
