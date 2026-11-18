//
//  APIError.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

enum APIError: Error, Equatable, Sendable {
    case invalidResponse
    case noConnection
    case httpError(statusCode: Int, reason: String?)
    case decodingFailed
    case transportError
}
