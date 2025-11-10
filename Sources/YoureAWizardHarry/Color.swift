import AppKit
import SwiftUI

extension Color {
    static func from(red: Int, green: Int, blue: Int) -> Color {
        Color(
            red: Double(red) / Double(255), green: Double(green) / Double(255),
            blue: Double(blue) / Double(255))
    }
}
