//
//  Colors.swift
//  Shakuten
//
//  Created by Shashank on 10/04/26.
//

import SwiftUI
class ColorsApp{
    var backgroundGradient: some View {
       LinearGradient(
           colors: [
               Color(hex: "#0B1020"),
               Color(hex: "#11192E"),
               Color(hex: "#1B1F3B")
           ],
           startPoint: .top,
           endPoint: .bottom
       )
       .ignoresSafeArea()
   }
}
