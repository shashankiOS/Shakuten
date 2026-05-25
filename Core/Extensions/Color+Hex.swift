import SwiftUI

extension Color {
    init(hex: String) {
        let sanitizedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var colorValue: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&colorValue)

        let red = Double((colorValue >> 16) & 0xFF) / 255.0
        let green = Double((colorValue >> 8) & 0xFF) / 255.0
        let blue = Double(colorValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
