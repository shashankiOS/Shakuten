//
//  DwonloadView.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//
import SwiftUI

struct DownloadView: View {
    
    @State private var episodes: [Episode] = [
        Episode(title: "Episode 1", description: "The story begins...", duration: "45m", imageName: "film"),
        Episode(title: "Episode 2", description: "Things get intense...", duration: "42m", imageName: "film")
    ]
    
    var body: some View {
        VStack(alignment : .leading){
            Text("Downloads will be automatically cleared from the device after 30 days of downaloding.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.leading , 16)
            List {
                ForEach(episodes) { episode in
                    EpisodeRowView(episode: episode)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))

                    
                    
                }
                .onDelete(perform: deleteEpisode)
                
            }
            
            .listStyle(.plain)
            
        }
        .background(backgroundGradient)

    }
    func deleteEpisode(at offsets: IndexSet) {
        episodes.remove(atOffsets: offsets)
    }
}
