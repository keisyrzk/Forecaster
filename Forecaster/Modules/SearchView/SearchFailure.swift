//
//  SearchFailure.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

enum SearchFailure: Equatable {
    case noConnection
    case serverError
    case invalidData
    case unknown

    var message: String {
        switch self {
        case .noConnection:
            "No internet connection. Check your connection and try again."
        case .serverError:
            "Unable to search cities right now. Please try again later."
        case .invalidData:
            "Unable to process the server response."
        case .unknown:
            "Something went wrong. Please try again."
        }
    }
}

extension Error {
    func asSearchFailure() -> SearchFailure {
        guard let apiError = self as? APIError else {
            return .unknown
        }

        switch apiError {
        case .noConnection:
            return .noConnection

        case .httpError:
            return .serverError

        case .decodingFailed:
            return .invalidData

        case .invalidResponse, .transportError:
            return .unknown
        }
    }
}
