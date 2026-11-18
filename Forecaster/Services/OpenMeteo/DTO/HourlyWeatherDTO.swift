//
//  HourlyWeatherDTO.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

nonisolated struct HourlyWeatherDTO: Decodable, Sendable {
    let time: [Int]
    let temperature: [Double]
    let weatherCode: [Int]
    let precipitationProbability: [Int?]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case weatherCode = "weather_code"
        case precipitationProbability = "precipitation_probability"
    }
}
