//
//  Request.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

extension Endpoint {
    func makeRequest() throws -> URLRequest {
        guard
            let baseURL = URL(string: baseUri),
            var components = URLComponents(url: baseURL.appending(path: path), resolvingAgainstBaseURL: false)
        else {
            throw APIError.invalidResponse
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw APIError.invalidResponse
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}
