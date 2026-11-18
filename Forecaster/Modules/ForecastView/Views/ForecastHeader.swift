//
//  ForecastHeader.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import SwiftUI

struct ForecastHeader: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    let cityName: String
    let temperature: Double
    let condition: WeatherCondition?

    var body: some View {
        VStack(spacing: 8) {
            if !cityName.isEmpty {
                Text(cityName)
                    .font(.largeTitle.weight(.medium))
            }
            
            Image(systemName: condition?.textIcon ?? "cloud")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 44))
            
            Text("\(temperature.formatted(.number.precision(.fractionLength(0))))°")
                .font(.system(size: 90, weight: .ultraLight))
                .contentTransition(.numericText())
            
            Text(condition?.forecastTitle ?? "Conditions unavailable")
                .font(.title3.weight(.medium))
                .foregroundStyle(palette.textSecondary)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
        .padding(.bottom, 24)
    }
}
