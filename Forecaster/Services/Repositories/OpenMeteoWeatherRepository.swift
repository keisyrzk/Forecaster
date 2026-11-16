//
//  OpenMeteoWeatherRepository.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

struct OpenMeteoWeatherRepository: WeatherRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient = DefaultAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchForecast(for city: City) async throws -> WeatherForecast {
        let endpoint = WeatherForecastEndpoint(
            latitude: city.latitude,
            longitude: city.longitude
        )

        let response: WeatherResponseDTO = try await apiClient.send(
            endpoint.makeRequest()
        )

        return try response.toDomain()
    }
}
