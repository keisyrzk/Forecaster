//
//  PersistentStoreRepository.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

protocol PersistentStoreRepository: Sendable {
    func loadCities() async throws -> [City]
    func saveCities(_ cities: [City]) async throws
}
