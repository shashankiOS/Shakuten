//
//  NetworkMonitor.swift
//  Shakuten
//
//  Created by Shashank on 13/04/26.
//


import Network
import Combine
class NetworkMonitor: ObservableObject {
    
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    
    @Published var isSlowNetwork: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isSlowNetwork = path.isExpensive
            }
        }
        monitor.start(queue: queue)
    }
}
