//
//  City.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

nonisolated struct City: Identifiable, Hashable, Sendable, Codable {
    let id: Int
    let name: String
    let country: String
    let region: String?
    let latitude: Double
    let longitude: Double
}
