//
//  APIClient.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

protocol APIClient: Sendable {
    func send<T: Decodable & Sendable>(_ request: URLRequest) async throws -> T
}
