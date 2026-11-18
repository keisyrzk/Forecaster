//
//  OpenMeteoCityRepositoryTests.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import Foundation
import Testing
@testable import Forecaster

@MainActor
struct OpenMeteoCityRepositoryTests {
    
    @Test("Map response fields to domain models")
    func mapCities() async throws {
        let response = CitySearchResponseDTO(results: [
            CityDTO(
                id: 1,
                name: "Łódź",
                country: "Poland",
                admin1: "Łódzkie",
                latitude: 51.75,
                longitude: 19.45
            ),
            CityDTO(
                id: 2,
                name: "Oslo",
                country: "Norway",
                admin1: nil,
                latitude: 59.91,
                longitude: 10.75
            )
        ])
        
        let client = APIClientMock(result: .success(response))
        let repository = OpenMeteoCityRepository(apiClient: client)

        let cities = try await repository.searchCities(matching: "city")

        #expect(cities == [
            City(
                id: 1,
                name: "Łódź",
                country: "Poland",
                region: "Łódzkie",
                latitude: 51.75,
                longitude: 19.45
            ),
            City(
                id: 2,
                name: "Oslo",
                country: "Norway",
                region: nil,
                latitude: 59.91,
                longitude: 10.75
            )
        ])
    }

    @Test("Return an empty array when results are missing")
    func returnEmptyArrayForMissingResults() async throws {
        let client = APIClientMock(
            result: .success(CitySearchResponseDTO(results: nil))
        )
        let repository = OpenMeteoCityRepository(apiClient: client)

        let cities = try await repository.searchCities(matching: "city")

        #expect(cities.isEmpty)
    }
    
    @Test("Propagates the API client error")
    func throwError() async {
        let client = APIClientMock(result: .failure(.noConnection))
        let repository = OpenMeteoCityRepository(apiClient: client)

        await #expect(throws: APIError.noConnection) {
            try await repository.searchCities(matching: "city")
        }
    }

    @Test(
        "Send a GET request with the search query",
        arguments: ["Łódź", "New York"]
    )
    func sendExpectedRequest(query: String) async throws {
        let client = APIClientMock(
            result: .success(CitySearchResponseDTO(results: []))
        )
        let repository = OpenMeteoCityRepository(apiClient: client)

        _ = try await repository.searchCities(matching: query)

        let requests = client.requests
        #expect(requests.count == 1)

        let request = try #require(requests.first)
        let url = try #require(request.url)
        let components = try #require(
            URLComponents(url: url, resolvingAgainstBaseURL: false)
        )

        #expect(request.httpMethod == "GET")
        #expect(components.scheme == "https")
        #expect(components.host == "geocoding-api.open-meteo.com")
        #expect(components.path == "/v1/search")
        #expect(
            components.queryItems?.first(where: { $0.name == "name" })?.value == query
        )
    }
}

@MainActor
private final class APIClientMock: APIClient {
    private let result: Result<CitySearchResponseDTO, APIError>
    private(set) var requests: [URLRequest] = []

    init(result: Result<CitySearchResponseDTO, APIError>) {
        self.result = result
    }

    func send<T: Decodable & Sendable>(_ request: URLRequest) async throws -> T {
        requests.append(request)

        let response = try result.get()

        return try #require(response as? T)
    }
}

