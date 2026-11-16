//
//  OpenMeteoCityRepository.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

struct OpenMeteoCityRepository: CityRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient = DefaultAPIClient()) {
        self.apiClient = apiClient
    }

    func searchCities(matching query: String) async throws -> [City] {
        let endpoint = SearchCitiesEndpoint(query: query)

        let response: CitySearchResponseDTO = try await apiClient.send(
            endpoint.makeRequest()
        )

        return (response.results ?? []).map { $0.toDomain() }
    }
}
