//
//  SearchCitiesEndpoint.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

struct SearchCitiesEndpoint: Endpoint {
    var baseUri = "https://geocoding-api.open-meteo.com"
    var path = "/v1/search"
    var method: HTTPMethod = .get
    let queryItems: [URLQueryItem]
    
    init(query: String, count: Int = 20, languageCode: String = "pl") {
        queryItems = [
            URLQueryItem(name: "name", value: query),
            URLQueryItem(name: "count", value: "\(count)"),
            URLQueryItem(name: "language", value: languageCode)
        ]
    }
}
