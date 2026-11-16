//
//  CityRepository.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

protocol CityRepository: Sendable {
    func searchCities(matching query: String) async throws -> [City]
}
