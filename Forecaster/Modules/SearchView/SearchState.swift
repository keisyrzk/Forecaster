//
//  SearchSTate.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

enum SearchState {
    case start
    case loading
    case results([City])
    case empty
    case failure(SearchFailure)
}
