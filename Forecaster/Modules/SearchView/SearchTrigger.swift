//
//  SearchTrigger.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import Foundation

/// Search action trigger
/// - `query` - start new search task on query text change
/// - `submissionID` - start new search task on manual search or retry action by setting a new submission ID
struct SearchTrigger: Equatable {
    var query: String = ""
    var submissionID: UUID? = nil
}
