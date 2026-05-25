//
//  CastHorizontalScrollView.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct CastHorizontalScrollView : View{
    let castList: [Cast] = [
        Cast(name: "John", imageName: "person.circle.fill"),
        Cast(name: "Emma", imageName: "person.circle.fill"),
        Cast(name: "Chris", imageName: "person.circle.fill"),
        Cast(name: "Sophia", imageName: "person.circle.fill"),
        Cast(name: "Daniel", imageName: "person.circle.fill")
    ]
    var body : some View{

        VStack(alignment : .leading , spacing: 8){
            
            HStack{
                Image(systemName: "play.fill")
                    .foregroundColor(.blue)
                
                Text("Cast")
                    .font(.headline)
                    .foregroundColor(.white)
                
                
            }
            .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    
                    ForEach(castList.shuffled().prefix(5)) { cast in
                        
                        VStack(spacing: 8) {
                            
                            Image(systemName: cast.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())   
                                .foregroundColor(.gray)
                            
                            Text(cast.name)
                                .font(.caption)
                                .foregroundColor(.white)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }

    }
    
}
