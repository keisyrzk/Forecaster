//
//  WeatherResponseDTO.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

nonisolated struct WeatherResponseDTO: Decodable, Sendable {
    let current: CurrentWeatherDTO
    let hourly: HourlyWeatherDTO
}

extension WeatherResponseDTO {
    func toDomain(now: Date = .now) throws -> WeatherForecast {
        let count = hourly.time.count

        guard hourly.temperature.count == count,
                  hourly.precipitationProbability.count == count,
                  hourly.weatherCode.count == count else {
                throw APIError.decodingFailed
            }

        let hourlyForecast = (0..<count).map { index in
            HourlyForecast(
                date: Date(timeIntervalSince1970:
                            TimeInterval(hourly.time[index])
                          ),
                temperature: hourly.temperature[index],
                precipitationProbability: hourly.precipitationProbability[index],
                condition: WeatherCondition( rawValue: hourly.weatherCode[index])
            )
        }

        return WeatherForecast(
            temperature: current.temperature,
            cloudCover: current.cloudCover,
            hourly: Array(hourlyForecast),
            condition: WeatherCondition(rawValue: current.weatherCode)
        )
    }
}
