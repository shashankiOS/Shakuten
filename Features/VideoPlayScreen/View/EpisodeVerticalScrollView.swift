//
//  EpisodeVerticalScrollView.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI
struct EpisodeVerticalScrollView : View{
  
    let episodes: [Episode] = [
        Episode(title: "Episode 1", description: "The story begins with unexpected twists.", duration: "45m", imageName: "film"),
        Episode(title: "Episode 2", description: "Things get more intense.", duration: "42m", imageName: "film"),
        Episode(title: "Episode 3", description: "A shocking revelation.", duration: "48m", imageName: "film"),
        Episode(title: "Episode 4", description: "Drama unfolds deeply.", duration: "50m", imageName: "film"),
        Episode(title: "Episode 5", description: "Final showdown begins.", duration: "47m", imageName: "film"),
        
        Episode(title: "Episode 6", description: "New alliances are formed.", duration: "44m", imageName: "film"),
        Episode(title: "Episode 7", description: "A hidden truth is revealed.", duration: "46m", imageName: "film"),
        Episode(title: "Episode 8", description: "The mission takes a dangerous turn.", duration: "49m", imageName: "film"),
        Episode(title: "Episode 9", description: "Emotions start to break limits.", duration: "43m", imageName: "film"),
        Episode(title: "Episode 10", description: "A major betrayal changes everything.", duration: "51m", imageName: "film"),
        
        Episode(title: "Episode 11", description: "The past comes back to haunt them.", duration: "45m", imageName: "film"),
        Episode(title: "Episode 12", description: "Plans are made for revenge.", duration: "47m", imageName: "film"),
        Episode(title: "Episode 13", description: "The enemy gets stronger.", duration: "50m", imageName: "film"),
        Episode(title: "Episode 14", description: "Hope seems nearly lost.", duration: "48m", imageName: "film"),
        Episode(title: "Episode 15", description: "A surprising comeback begins.", duration: "46m", imageName: "film"),
        
        Episode(title: "Episode 16", description: "Everything starts connecting.", duration: "49m", imageName: "film"),
        Episode(title: "Episode 17", description: "The final plan is executed.", duration: "52m", imageName: "film"),
        Episode(title: "Episode 18", description: "An unforgettable ending unfolds.", duration: "55m", imageName: "film")
    ]
    var body : some View{
        ScrollView{

            VStack(alignment : .leading , spacing: 8){
                
                HStack{
                    Image(systemName: "play.fill")
                        .foregroundColor(.blue)
                    
                    Text("18 Episodes")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    
                }
                .padding()
                HStack{
                    Text("Sort by : Earliest First")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.blue)
                        .font(.caption)
                    
                }
                .padding()

                    ForEach(episodes) { episode in EpisodeRowView(episode: episode)
                    }
                
                

            }
        }        
    }
    
    
}
