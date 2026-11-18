//
//  PersistentStoreKey.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

nonisolated enum PersistentStoreKey: Sendable {
    case city
    
    var keyName: String {
        switch self {
        case .city:
            return "city"
        }
    }
}
