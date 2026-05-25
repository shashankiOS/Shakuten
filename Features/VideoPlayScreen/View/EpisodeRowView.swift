//
//  EpisodeRowView.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//
import SwiftUI

struct EpisodeRowView: View {
    
    let episode: Episode
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack(alignment: .top, spacing: 12) {
                
                // Thumbnail
                Image(systemName: episode.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 70)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .clipped()
                
                // Info
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(episode.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(episode.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                    
                    Text(episode.duration)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            // Divider
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.horizontal)
        }
        .padding(.vertical, 8)
    }
}
