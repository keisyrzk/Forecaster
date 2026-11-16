//
//  HourlyForecast.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

nonisolated struct HourlyForecast: Identifiable, Sendable {
    var id: Date { date }

    let date: Date
    let temperature: Double
    let precipitationProbability: Int?
    let condition: WeatherCondition?
}
