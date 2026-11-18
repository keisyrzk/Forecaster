//
//  ColorPalette.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import SwiftUI

struct AppPalette {
    let colorScheme: ColorScheme

    private var isDark: Bool {
        colorScheme == .dark
    }

    var textPrimary: Color {
        isDark ? .white : .black
    }

    var textSecondary: Color {
        textPrimary.opacity(0.75)
    }

    var searchFieldBackground: Color {
        .white.opacity(isDark ? 0.2 : 0.45)
    }

    var forecastCardBackground: Color {
        .black.opacity(isDark ? 0.2 : 0.05)
    }

    var resultsOverlay: Color {
        isDark ? .white.opacity(0.1) : .black.opacity(0.05)
    }
    
    var validationShadow: Color {
        .red
    }

    var forecastAccent: Color {
        isDark ? .cyan : Color(hex: 0x003566)
    }

    var defaultBackground: Color {
        .black.opacity(0.5)
    }

    var modalLoaderForeground: Color {
        .white
    }
    
    func gradient(for type: BackgroundType) -> [Color] {
        switch type {
        case .default:
            [
                Color(hex: 0x003566, lightenedBy: isDark ? 0 : 0.5),
                Color(hex: 0x001d3d, lightenedBy: isDark ? 0 : 0.5)
            ]
            
        case .tile:
            [
                Color(hex: 0x184e77, lightenedBy: isDark ? 0 : 0.5),
                Color(hex: 0x1e6091, lightenedBy: isDark ? 0 : 0.5)
            ]
            
        case let .forecast(condition):
            switch condition {
            case .clearSky, .mainlyClear, .partlyCloudy:
                [
                    Color(hex: 0x468faf, lightenedBy: isDark ? 0 : 0.5),
                    Color(hex: 0x2c7da0, lightenedBy: isDark ? 0 : 0.5)
                ]
                
            case .overcast, .fog, .depositingRimeFog:
                [
                    Color(hex: 0x2a6f97, lightenedBy: isDark ? 0 : 0.5),
                    Color(hex: 0x014f86, lightenedBy: isDark ? 0 : 0.5)
                ]
                
            default:
                [
                    Color(hex: 0x014f86, lightenedBy: isDark ? 0 : 0.5),
                    Color(hex: 0x01497c, lightenedBy: isDark ? 0 : 0.5)
                ]
            }
        }
    }
}
