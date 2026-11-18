//
//  BackgroundView.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

import SwiftUI

enum BackgroundType {
    case `default`
    case tile
    case forecast(WeatherCondition?)
}

extension BackgroundType {
    var gradientColors: [Color] {
        switch self {
        case .default:
            [
                Color(hex: 0x003566),
                Color(hex: 0x001d3d)
            ]
            
        case .tile:
            [
                Color(hex: 0x184e77),
                Color(hex: 0x1e6091)
            ]
            
        case let .forecast(condition):
            switch condition {
            case .clearSky, .mainlyClear, .partlyCloudy:
                [
                    Color(hex: 0x468faf),
                    Color(hex: 0x2c7da0)
                ]
                
            case .overcast, .fog, .depositingRimeFog:
                [
                    Color(hex: 0x2a6f97),
                    Color(hex: 0x014f86)
                ]
                
            default:
                [
                    Color(hex: 0x014f86),
                    Color(hex: 0x01497c)
                ]
            }
        }
    }
}

struct BackgroundView: View {
    let type: BackgroundType

    var body: some View {
        LinearGradient(colors: type.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
