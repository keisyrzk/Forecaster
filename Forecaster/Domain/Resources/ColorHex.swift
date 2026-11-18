//
//  ColorHex.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

import SwiftUI

extension Color {
    init(hex: UInt32, lightenedBy factor: Double = 0) {
        let factor = min(max(factor, 0), 1)
        
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255

        self.init(
            .sRGB,
            red: red + (1 - red) * factor,
            green: green + (1 - green) * factor,
            blue: blue + (1 - blue) * factor,
            opacity: 1
        )
    }
}
