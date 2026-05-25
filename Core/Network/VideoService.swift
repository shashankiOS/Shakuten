//
//  VideoService.swift
//  Shakuten
//
//  Created by Shashank on 13/04/26.
//


import AVKit

class VideoService {
    
    static let shared = VideoService()
    
    private init() {}
    
    private let cache = NSCache<NSString, AVPlayerItem>()
    
    func player(for url: String, quality: VideoQuality) -> AVPlayer {
        
        let finalURL = urlForQuality(base: url, quality: quality)
        
        // Check cache
        if let cachedItem = cache.object(forKey: finalURL as NSString) {
            return AVPlayer(playerItem: cachedItem)
        }
        
        // Create new item
        let asset = AVURLAsset(url: URL(string: finalURL)!)
        let item = AVPlayerItem(asset: asset)
        
        // Cache it
        cache.setObject(item, forKey: finalURL as NSString)
        
        return AVPlayer(playerItem: item)
    }
    
    private func urlForQuality(base: String, quality: VideoQuality) -> String {
        // Example logic (you can modify based on backend)
        return base + "?quality=\(quality.rawValue)"
    }
}