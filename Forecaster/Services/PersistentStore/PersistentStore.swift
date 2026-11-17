//
//  PersistentStore.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

import Foundation

protocol PersistentStore: Sendable {
    func data(forKey key: PersistentStoreKey) async -> Data?
    func set(_ data: Data, forKey key: PersistentStoreKey) async
}
