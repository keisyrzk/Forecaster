//
//  WeatherForecast.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

nonisolated struct WeatherForecast: Sendable {
    let temperature: Double
    let cloudCover: Double
    let hourly: [HourlyForecast]
    let condition: WeatherCondition?
}
