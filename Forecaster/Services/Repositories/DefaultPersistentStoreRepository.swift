//
//  DefaultPersistentStoreRepository.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

import Foundation

nonisolated struct DefaultPersistentStoreRepository: PersistentStoreRepository {
    private let store: PersistentStore

    init(store: PersistentStore) {
        self.store = store
    }

    func loadCities() async throws -> [City] {
        guard let data = await store.data(forKey: .city) else {
            return []
        }

        return try JSONDecoder().decode([City].self, from: data)
    }

    func saveCities(_ cities: [City]) async throws {
        let data = try JSONEncoder().encode(cities)
        await store.set(data, forKey: .city)
    }
}
