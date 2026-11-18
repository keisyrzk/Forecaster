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
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError {
            switch error.code {
            case .cancelled:
                throw CancellationError()

            case .notConnectedToInternet, .networkConnectionLost:
                throw APIError.noConnection

            default:
                throw APIError.transportError
            }
        }

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
