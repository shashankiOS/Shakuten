//
//  MoreOptions.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI
import SwiftUI

struct MoreOptions: View {
    @Binding var selectedTab: String
    var body: some View {
        VStack(spacing :2){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 2)
                .foregroundColor(.gray.opacity(0.5))

            HStack(spacing: 0) {
                
                optionButton(title: "About")
                optionButton(title: "Episodes")
                optionButton(title: "Reviews")
            }
            .frame(height: 50)
            
        }
    }
    
    // MARK: - Reusable Button
    func optionButton(title: String) -> some View {
        Button {
            selectedTab = title
        } label: {
            VStack(spacing: 6) {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Rectangle()
                    .fill(selectedTab == title ? Color.blue : Color.clear)
                    .frame(height: 3)
                    .frame(width: 70)
                    .animation(.easeInOut, value: selectedTab)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
    }
}
