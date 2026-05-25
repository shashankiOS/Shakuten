//
//  EditProfileView.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//
import SwiftUI

struct EditProfileView: View {
    
    @Binding var name: String
    @Binding var age: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            backgroundGradient.ignoresSafeArea()
            NavigationStack {
                VStack(spacing: 20) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Age", text: $age)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
                    Button("Save") {
                        dismiss()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}
