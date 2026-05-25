//
//  ButtonViews.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
        }
    }
}
