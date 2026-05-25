//
//  ScrollOffSetTracker.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
