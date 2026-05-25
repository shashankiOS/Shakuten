//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct HomeHeroBannerView: View {
    let banner: FeaturedBanner

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("citySleeps")
                   .resizable()
                   .scaledToFill()
                   .frame(maxWidth: .infinity, maxHeight: 300)
                   .clipped()

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Shaukten Picks For You")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.18), in: Capsule())

                    Spacer()

                    Image(systemName: banner.imageName)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.white)
                }

                Spacer()

                Text(banner.title)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(banner.subtitle)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.82))

                Text(banner.description)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.78))
                    .lineLimit(3)

                HStack(spacing: 12) {
                    Label("Watch Now", systemImage: "play.fill")
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.white, in: Capsule())
                        .foregroundStyle(.black)

                    Label("My List", systemImage: "plus")
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.white.opacity(0.16), in: Capsule())
                        .foregroundStyle(.white)
                }
            }
            .padding(22)
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}
