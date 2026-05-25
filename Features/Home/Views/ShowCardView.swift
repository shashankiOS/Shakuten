//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct ShowCardView: View {
    let show: Show

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
           // artwork
            Image("\(show.imageName)")
                   .resizable()
                   .scaledToFill()
                   .frame(width: 180, height: 220)
                   .clipped()
                   .cornerRadius(16)
                   .overlay(alignment: .topTrailing) {
                       if show.isNewEpisode {
                           Text("NEW")
                               .font(.caption2.weight(.bold))
                               .padding(.horizontal, 8)
                               .padding(.vertical, 5)
                               .background(.white, in: Capsule())
                               .foregroundStyle(.black)
                               .padding(8)
                       }
                   }
                        
                   

            Text(show.title)
                .font(.headline)
                .foregroundStyle(.white)
                .lineLimit(1)

            HStack(spacing: 8) {
                Text(show.genre)
                Text(String(show.year))
                Label(String(format: "%.1f", show.rating), systemImage: "star.fill")                                   .foregroundColor(.yellow)

            }
            .font(.caption)
            .foregroundStyle(.white.opacity(0.72))
        }
        .frame(width: 180, alignment: .leading)
    }

    private var artwork: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: show.accentColorHex),
                            Color(hex: show.accentColorHex).opacity(0.45)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 180, height: 220)
                .overlay {
                    Image(systemName: show.imageName)
                        .font(.system(size: 52))
                        .foregroundStyle(.white.opacity(0.92))
                }

            if show.isNewEpisode {
                Text("NEW")
                    .font(.caption2.weight(.bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.white, in: Capsule())
                    .foregroundStyle(.black)
                    .padding(12)
            }
        }
    }
}
