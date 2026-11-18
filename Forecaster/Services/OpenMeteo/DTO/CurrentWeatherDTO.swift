//
//  CurrentWeatherDTO.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

nonisolated struct CurrentWeatherDTO: Decodable, Sendable {
    let temperature: Double
    let cloudCover: Double
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case cloudCover = "cloud_cover"
        case weatherCode = "weather_code"
    }
}
