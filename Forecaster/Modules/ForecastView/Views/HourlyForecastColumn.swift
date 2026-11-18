//
//  HourlyForecastColumn.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import SwiftUI

struct HourlyForecastColumn: View {
    let hour: HourlyForecast

    var body: some View {
        VStack(spacing: 12) {
            Text(hour.date, format: .dateTime.weekday(.abbreviated))
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.7))
            
            Text(hour.date, format: .dateTime.hour())
                .font(.subheadline.weight(.medium))
            
            Image(systemName: hour.condition?.textIcon ?? "questionmark.circle")
                .symbolRenderingMode(.multicolor)
                .font(.title2)
                .frame(height: 30)
            
            Text("\(hour.temperature.formatted(.number.precision(.fractionLength(0))))°")
                .font(.title3.weight(.semibold))
            
            Text(hour.precipitationProbability.map { "\($0)%" } ?? "—")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.cyan)
        }
    }
}
