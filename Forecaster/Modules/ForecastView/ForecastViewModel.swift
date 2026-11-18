//
//  ForecastViewModel.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

@MainActor
@Observable
class ForecastViewModel {
    
    let weatherForecast: WeatherForecast
    let hourlyForecast: [HourlyForecast]
    let cityName: String
    
    init(weatherForecast: WeatherForecast, cityName: String) {
        self.weatherForecast = weatherForecast
        hourlyForecast = weatherForecast.hourly.sorted { $0.date < $1.date }
        self.cityName = cityName
    }
}
