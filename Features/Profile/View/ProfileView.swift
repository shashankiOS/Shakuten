//
//  ProfileView.swift
//  Shakuten
//
//  Created by Shashank on 11/04/26.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var name: String = "Shashank"
    @State private var age: String = "25"
    @State private var isLoggedIn: Bool = true
    @State private var showEditSheet: Bool = false
    
    var body: some View {
            ZStack {
            backgroundGradient.ignoresSafeArea()

            NavigationStack {
                
                ScrollView{

                    VStack(spacing: 20) {
                        
                        // MARK: - Profile Card
                        VStack(alignment: .leading, spacing: 0) {

                            Image("shakuten")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                                .padding(.leading, 0)

                            Text("+91 9340044657")
                                .font(.title2)
                                .tracking(3)
                                .foregroundColor(.white)

                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Shakuten Account Holder")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    
                                    Text(name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }

                                Spacer()

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Next Recharge Date")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                    
                                    Text("20 Apr 2027") 
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding() // overall card padding
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color.purple,
                                    Color.blue.opacity(0.7),
                                    Color.blue
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 8)
                        .padding(.horizontal)
                        
                        // MARK: - Options
                        
                        VStack(spacing: 12) {
                            
                            // Edit Profile
                            Button {
                                showEditSheet.toggle()
                            } label: {
                                profileRow(title: "Edit Profile", icon: "pencil")
                            }
                            
                            // Recharge
                            Button {
                                print("Recharge tapped")
                            } label: {
                                profileRow(title: "Recharge", icon: "creditcard")
                            }
                            
                            // Login / Logout
                            Button {
                                isLoggedIn.toggle()
                            } label: {
                                profileRow(
                                    title: isLoggedIn ? "Logout" : "Login",
                                    icon: "arrow.right.square"
                                )
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                }
                .sheet(isPresented: $showEditSheet) {
                    EditProfileView(name: $name, age: $age)
                }
            }
        }
    }
    
    // MARK: - Reusable Row
    func profileRow(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
