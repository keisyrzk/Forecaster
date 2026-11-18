//
//  SearchState.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

enum SearchState: Equatable {
    case initial
    case start
    case loadingStore
    case savingStore
    case loadingSearch
    case results([City])
    case empty
    case failure(SearchFailure)
    case loadingCancelled
}
