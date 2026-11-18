//
//  DefaultPersistentStore.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

import Foundation

actor DefaultPersistantStore: PersistentStore {
    
    private let store = UserDefaults.standard

    func data(forKey key: PersistentStoreKey) async -> Data? {
        store.data(forKey: key.keyName)
    }

    func set(_ data: Data, forKey key: PersistentStoreKey) async {
        store.set(data, forKey: key.keyName)
    }
}
