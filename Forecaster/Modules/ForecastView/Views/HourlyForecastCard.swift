//
//  HourlyForecastCard.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import SwiftUI

struct HourlyForecastCard: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    let hourlyForecast: [HourlyForecast]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("Hourly forecast", systemImage: "clock")
                .font(.caption.weight(.semibold))
                .foregroundStyle(palette.textSecondary)
            
            if hourlyForecast.isEmpty {
                Text("Hourly forecast is unavailable.")
                    .font(.subheadline)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 24) {
                        ForEach(hourlyForecast) { hour in
                            HourlyForecastColumn(hour: hour)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(palette.forecastCardBackground, in: RoundedRectangle(cornerRadius: 24))
    }
}
