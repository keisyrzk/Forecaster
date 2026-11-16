//
//  CitySearchResponseDTO.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

nonisolated struct CitySearchResponseDTO: Decodable, Sendable {
    let results: [CityDTO]?
}
