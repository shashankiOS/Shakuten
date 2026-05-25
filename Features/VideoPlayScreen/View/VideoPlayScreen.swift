//
//  VideoPlayScreen.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct VidePlayScreen: View {
    @State private var show: Show
    @State private var selectedTab = "About"
    @State private var scrollOffset: CGFloat = 0
    @State var wacthNowClicked : Bool = false
    private let stickyThreshold: CGFloat = -250

    var isSticky: Bool {
        scrollOffset < stickyThreshold
    }
    init(show: Show) {
        _show = State(initialValue: show)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ShowPreviewView(show:show, wacthNowClicked: $wacthNowClicked)
                    MoreOptions(selectedTab: $selectedTab)

                    //TO :DO Make it fix
                    if selectedTab == "About" {
                        CastHorizontalScrollView()
                        Spacer()

                        
                    } else if selectedTab == "Episodes" {
                        EpisodeVerticalScrollView()

                        
                    } else if selectedTab == "Reviews" {
                        Text("Upcoming Feature Reviews Section")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }.toolbar(.hidden, for: .navigationBar)
            .navigationTitle(show.title)
            .background(backgroundGradient)

            .navigationDestination(isPresented: $wacthNowClicked) {
                        VideoPlayView()
                    }
        
    }

}
#Preview {
    VidePlayScreen(show:                  Show(
        id: "love-in-han-river",
        title: "Love in Han River",
        genre: "Romance",
        categoryID: ShowCategory.romance.id,
        year: 2025,
        rating: 9.1,
        imageName: "love-in-han-river", // replace with asset for real app
        accentColorHex: "#E54B6B",
        isFeatured: true,
        isNewEpisode: true
    ))
}

