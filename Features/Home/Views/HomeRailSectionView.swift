//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct HomeRailSectionView: View {
    let title: String
    let shows: [Show]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(shows) { show in
                        NavigationLink(value: show) {
                            ShowCardView(show: show)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
    
        }
    }
}
