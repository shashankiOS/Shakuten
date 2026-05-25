//
//  ShowPreviewView.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI
import SwiftUI

struct ShowPreviewView: View {
    
    let show: Show
    @Binding var wacthNowClicked :Bool 
    var body: some View {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    // MARK: - Hero Image Section
                    ZStack(alignment: .bottomLeading) {
                        
                        Image(show.imageName) // use assets
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 220)
                            .clipped()
                            .cornerRadius(12)
                        
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.9)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 220)
                        
                  
                        
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Text(show.title)
                                .font(.title)
                                .bold()
                            
                            HStack(spacing: 8) {
                                Text("\(Int(show.year))")
                                Text("•")
                                
                                Label(String(format: "%.1f", show.rating), systemImage: "star.fill")                                   .foregroundColor(.yellow)

                            }
                            .font(.caption)
                            
                        }
                        .foregroundColor(.white)
                        .padding()
                        
                    }.overlay(alignment: .topLeading) {
                        BackButton()
                    }
                   
                    
                    // MARK: - Info Row
                    HStack(spacing: 12) {
                        Text("\(show.year)")
                        Text("12 Episodes")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    
                    // MARK: - Category / Genre / Rating
                    HStack(spacing: 12) {
                        Text(show.genre)
                        Text("\(show.rating, specifier: "%.1f")")                    }
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    
                    // MARK: - Description + Button
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("A thrilling story full of drama, emotions, and unexpected twists. Watch now to explore an unforgettable journey.")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        
                        Button("Watch Now") {
                            wacthNowClicked = true
                        }
                        .font(Font.headline.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Actions Row
                    HStack {
                        Spacer()
                        
                        actionButton(icon: "plus", title: "Watchlist")
                        
                        Spacer()
                        
                        actionButton(icon: "star", title: "Rate")
                        
                        Spacer()
                        
                        actionButton(icon: "square.and.arrow.up", title: "Share")
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.top, 8)
                }
                .padding(.bottom, 20)
            }

        
    }
    
    // MARK: - Reusable Button
    func actionButton(icon: String, title: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
            Text(title)
                .font(.caption)
        }
    }
}

#Preview {
    ShowPreviewView(
        show: Show(
            id: "love-in-han-river",
            title: "Love in Han River",
            genre: "Romance",
            categoryID: ShowCategory.romance.id,
            year: 2025,
            rating: 9.1,
            imageName: "love-in-han-river",
            accentColorHex: "#E54B6B",
            isFeatured: true,
            isNewEpisode: true
        ),
        wacthNowClicked: .constant(false)
    )
}
