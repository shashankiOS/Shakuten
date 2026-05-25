//
//  VideoPlay.swift
//  Shakuten
//
//  Created by Shashank on 13/04/26.
//

import SwiftUI
import AVKit
import Combine
struct VideoPlayView: View {
    
    @State private var player = AVPlayer(url: URL(string: "https://www.w3schools.com/html/mov_bbb.mp4")!)
    
    @State private var isPlaying = false
    @State private var showControls = true
    
    @State private var currentTime: Double = 0
    @State private var duration: Double = 10
    
    @State private var timeObserver: Any?
    
    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()
            // Video Player
            VideoPlayer(player: player)
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
                .onTapGesture {
                    toggleControls()
                }
            
            //  Controls Overlay
            if showControls {
                VStack {
                    
                    Spacer()
                    
                    // MARK: - Center Controls
                    HStack(spacing: 50) {
                        
                        Button {
                            seek(by: -20)
                        } label: {
                            Image(systemName: "gobackward.20")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            togglePlay()
                        } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            seek(by: 10)
                        } label: {
                            Image(systemName: "goforward.10")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: - Bottom Controls
                    VStack {
                        
                        Slider(value: $currentTime, in: 0...duration, onEditingChanged: { editing in
                            if !editing {
                                seekTo(time: currentTime)
                            }
                        })
                        .accentColor(.red)
                        
                        HStack {
                            Text(formatTime(currentTime))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(formatTime(duration))
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            
                            Button {
                                print("Subtitles tapped")
                            } label: {
                                Image(systemName: "captions.bubble")
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Button {
                                print("Episodes tapped")
                            } label: {
                                Text("Episodes")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.black.opacity(0.4))
                .transition(.opacity)
            }
        }
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            
            setupPlayer()
            player.play()
            isPlaying = true
            
            startAutoHide()
        }
        .onDisappear {
            // Rotate back
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            
            player.pause()
            player.replaceCurrentItem(with: nil)
            
            if let observer = timeObserver {
                player.removeTimeObserver(observer)
                timeObserver = nil
            }
        }
    }
}

// MARK: - Player Logic
extension VideoPlayView {
    
    func setupPlayer() {
        let interval = CMTime(seconds: 1, preferredTimescale: 6000)
        
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            currentTime = CMTimeGetSeconds(time)
            
            if let total = player.currentItem?.duration {
                duration = CMTimeGetSeconds(total)
            }
        }
    }
    
    func togglePlay() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
        startAutoHide()
    }
    
    func seek(by seconds: Double) {
        let current = CMTimeGetSeconds(player.currentTime())
        let newTime = current + seconds
        seekTo(time: newTime)
    }
    
    func seekTo(time: Double) {
        let cmTime = CMTime(seconds: time, preferredTimescale: 600)
        player.seek(to: cmTime)
    }
}

// MARK: - UI Helpers
extension VideoPlayView {
    
    func toggleControls() {
        withAnimation {
            showControls.toggle()
        }
        startAutoHide()
    }
    
    func startAutoHide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if isPlaying {
                withAnimation {
                    showControls = false
                }
            }
        }
    }
    
    func formatTime(_ seconds: Double) -> String {
        guard !seconds.isNaN else { return "00:00" }
        
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        
        return String(format: "%02d:%02d", mins, secs)
    }
}

#Preview {
    VideoPlayView()
}
