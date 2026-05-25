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
    // MARK: - Player Properties
    // Swapped to a rock-solid, production HLS streaming manifest asset (.m3u8)
    @State private var player = AVPlayer(url: URL(string: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")!)
    @State private var isPlaying = false
    @State private var showControls = true
    @State private var isBuffering = false
    
    @State private var currentTime: Double = 0
    @State private var duration: Double = 0
    @State private var selectedQuality = "Auto"
    @State private var selectedSubtitle = "Off"
    
    // MARK: - Memory-Safe Observers & Tasks
    @State private var timeObserver: Any?
    @State private var bufferObserver: NSKeyValueObservation?
    @State private var autoHideTask: Task<Void, Never>? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Core Video Player Rendering Component
            PlayerLayerView(player: player)
                .ignoresSafeArea()
                .onTapGesture {
                    toggleControls()
                }
            
            // Active Network Drop Spinner Overlay
            if isBuffering {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(1.5)
            }
            
            // Custom Playback Overlays Layout Module
            if showControls {
                ZStack {
                    Color.black.opacity(0.4)
                    
                    // MARK: - Top Actions Control Row
                    VStack {
                        HStack {
                            Button {
                                cleanUpAndDismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title2.weight(.medium))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
                                    .padding(.top, 24)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 16) {
                                // Subtitle Options Selector Menu
                                Menu {
                                    Button("Off") { selectedSubtitle = "Off" }
                                    Button("English") { selectedSubtitle = "English" }
                                    Button("Spanish") { selectedSubtitle = "Spanish" }
                                } label: {
                                    HStack(spacing: 4) {
                                        Image(systemName: "captions.bubble.fill")
                                        Text("CC: \(selectedSubtitle)")
                                            .font(.caption.weight(.semibold))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(6)
                                }
                                
                                // Quality Selector Menu
                                Menu {
                                    Button("Auto (1080p)") { changeStreamingQuality(to: "Auto") }
                                    Button("720p") { changeStreamingQuality(to: "720p") }
                                    Button("320p") { changeStreamingQuality(to: "320p") }
                                } label: {
                                    HStack(spacing: 4) {
                                        Image(systemName: "gearshape.fill")
                                        Text(selectedQuality)
                                            .font(.caption.weight(.semibold))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(6)
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 24)
                        }
                        Spacer()
                    }
                    
                    // MARK: - Center Media Transport Row
                    HStack(spacing: 80) {
                        Button { seek(by: -10) } label: {
                            Image(systemName: "gobackward.10")
                                .font(.system(size: 36, weight: .regular))
                                .foregroundColor(.white)
                        }
                        
                        Button { togglePlay() } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 54, weight: .regular))
                                .foregroundColor(.white)
                        }
                        
                        Button { seek(by: 10) } label: {
                            Image(systemName: "goforward.10")
                                .font(.system(size: 36, weight: .regular))
                                .foregroundColor(.white)
                        }
                    }
                    
                    // MARK: - Bottom Scrubber Timeline Row
                    VStack {
                        Spacer()
                        VStack(spacing: 8) {
                            HStack(spacing: 12) {
                                Text(formatTime(currentTime))
                                    .font(.caption.monospacedDigit())
                                    .foregroundColor(.white)
                                
                                Slider(value: $currentTime, in: 0...max(0, duration), onEditingChanged: { editing in
                                    if !editing {
                                        seekTo(time: currentTime)
                                    }
                                })
                                .accentColor(.red)
                                
                                Text(formatTime(duration))
                                    .font(.caption.monospacedDigit())
                                    .foregroundColor(.white)
                            }
                            
                            HStack {
                                Spacer()
                                Button {
                                    print("Display Connected Episodes Rail Context")
                                } label: {
                                    Text("Episodes")
                                        .font(.subheadline.weight(.medium))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    }
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            attemptRotation(to: .landscapeRight)
            setupPlayerAndObservers()
            player.play()
            isPlaying = true
            startAutoHide()
        }
        .onDisappear {
            attemptRotation(to: .portrait)
            invalidatePlayer()
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
    }
}

// MARK: - Core Playback Operations Extension
extension VideoPlayView {
    
    private func setupPlayerAndObservers() {
        player.currentItem?.preferredForwardBufferDuration = 30.0
        
        let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.currentTime = time.seconds
            if let total = player.currentItem?.duration.seconds, !total.isNaN {
                self.duration = total
            }
        }
        
        bufferObserver = player.currentItem?.observe(\.isPlaybackBufferEmpty, options: [.new]) { item, _ in
            DispatchQueue.main.async {
                self.isBuffering = item.isPlaybackBufferEmpty
            }
        }
    }
    
    private func togglePlay() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
        startAutoHide()
    }
    
    private func seek(by seconds: Double) {
        let target = player.currentTime().seconds + seconds
        seekTo(time: target)
    }
    
    private func seekTo(time: Double) {
        let cmTime = CMTime(seconds: max(0, min(time, duration)), preferredTimescale: 600)
        player.seek(to: cmTime, toleranceBefore: .zero, toleranceAfter: .zero)
        startAutoHide()
    }
    
    private func changeStreamingQuality(to quality: String) {
        selectedQuality = quality
        let bitRateMapping: [String: Double] = ["Auto": 0.0, "720p": 2500000.0, "480p": 1000000.0]
        player.currentItem?.preferredPeakBitRate = bitRateMapping[quality] ?? 0.0
    }
    
    private func cleanUpAndDismiss() {
        invalidatePlayer()
        dismiss()
    }
    
    private func invalidatePlayer() {
        autoHideTask?.cancel()
        player.pause()
        
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
            timeObserver = nil
        }
        bufferObserver?.invalidate()
        bufferObserver = nil
        player.replaceCurrentItem(with: nil)
    }
}

// MARK: - Layout Utilities Extension
extension VideoPlayView {
    
    private func toggleControls() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showControls.toggle()
        }
        if showControls {
            startAutoHide()
        }
    }
    
    private func startAutoHide() {
        autoHideTask?.cancel()
        guard isPlaying else { return }
        
        autoHideTask = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            if !Task.isCancelled {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showControls = false
                }
            }
        }
    }
    
    private func formatTime(_ seconds: Double) -> String {
        guard !seconds.isNaN, seconds.isFinite else { return "00:00" }
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }
    
    private func attemptRotation(to orientation: UIInterfaceOrientationMask) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientation))
        }
    }
}

// MARK: - Layout Bounds-Safe Subview Container
fileprivate final class UIPlayerVideoContainerView: UIView {
    private let playerLayer = AVPlayerLayer()
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        backgroundColor = .black
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspect
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

fileprivate struct PlayerLayerView: UIViewRepresentable {
    let player: AVPlayer
    
    func makeUIView(context: Context) -> UIPlayerVideoContainerView {
        UIPlayerVideoContainerView(player: player)
    }
    
    func updateUIView(_ uiView: UIPlayerVideoContainerView, context: Context) {}
}

#Preview {
    VideoPlayView()
}
