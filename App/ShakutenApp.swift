//
//  ShakutenApp.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

@main
struct ShakutenApp: App {
    private let container = AppContainer.live

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
