//
//  WeatherForecastEndpoint.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

struct WeatherForecastEndpoint: Endpoint {
    var baseUri = "https://api.open-meteo.com"
    var path = "/v1/forecast"
    var method: HTTPMethod = .get
    let queryItems: [URLQueryItem]
    
    init(latitude: Double, longitude: Double, hoursCount: Int) {
        queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(
                name: "current",
                value: "temperature_2m,cloud_cover,weather_code"
            ),
            URLQueryItem(
                name: "hourly",
                value: "temperature_2m,precipitation_probability,weather_code"
            ),
            URLQueryItem(name: "forecast_hours", value: "\(hoursCount)"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "timeformat", value: "unixtime")
        ]
    }
}
