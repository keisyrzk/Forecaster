//
//  CityDTO.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

nonisolated struct CityDTO: Decodable, Sendable {
    let id: Int
    let name: String
    let country: String
    let admin1: String?
    let latitude: Double
    let longitude: Double
}

extension CityDTO {
    func toDomain() -> City {
        City(
            id: id,
            name: name,
            country: country,
            region: admin1,
            latitude: latitude,
            longitude: longitude
        )
    }
}
