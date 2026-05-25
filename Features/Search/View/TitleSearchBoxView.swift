//
//  TitleSearchBoxView.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//

import SwiftUI

struct TitleSearchBoxView: View {
    var title: String
    var action: () -> Void
    let regions: [String] = [
        "India",
        "South Korea",
        "Japan",
        "China",
        "Thailand",
        "United States",
        "United Kingdom",
        "Spain",
        "France",
        "Germany"
    ]
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .frame(height: 50)
                .background(
                    regions.contains(title)
                    ? AnyView(
                        Color.blue.opacity(0.8)

                    )
                    : AnyView(
                        Color.gray.opacity(0.8)
                    )
                )
                .cornerRadius(12)
        }
        .buttonStyle(.plain) 
    }
}
