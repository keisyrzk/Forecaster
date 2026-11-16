//
//  Endpoint.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

protocol Endpoint {
    var baseUri: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}
