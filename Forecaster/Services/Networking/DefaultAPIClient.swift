//
//  DefaultAPIClient.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

struct DefaultAPIClient: APIClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send<T: Decodable & Sendable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(
            for: request
        )

        guard let response = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(response.statusCode) else {
            throw APIError.httpError(
                statusCode: response.statusCode,
                reason: nil
            )
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
