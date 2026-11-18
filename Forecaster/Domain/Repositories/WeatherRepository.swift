//
//  WeatherRepository.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

protocol WeatherRepository: Sendable {
    func fetchForecast(for city: City) async throws -> WeatherForecast
}
