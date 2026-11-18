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

struct BackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    let type: BackgroundType

    var body: some View {
        LinearGradient(colors: palette.gradient(for: type), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
