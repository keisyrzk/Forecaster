//
//  SearchViewModel.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

@MainActor
@Observable
class SearchViewModel {
    
    private(set) var trigger = SearchTrigger()
    private(set) var state: SearchState = .start
    
    private let repository: CityRepository

    init(repository: CityRepository) {
        self.repository = repository
    }
    
    /// Handle query text change
    func updateQuery(_ text: String) {
        guard trigger.query != text else { return }

        trigger.query = text
        trigger.submissionID = nil

        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)

        state = query.count >= 3 ? .loading : .start
    }

    /// Handle manual search action
    func submitSearch() {
        state = .loading
        trigger.submissionID = UUID()
    }
    
    func search() async {
        let trigger = self.trigger
        let query = trigger.query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !Task.isCancelled,
            self.trigger == trigger else {
            return
        }
        
        guard query.count >= 3 else {
            state = .start
            return
        }

        do {
            /// Debounce only on query text change
            if trigger.submissionID == nil {
                try await Task.sleep(for: .milliseconds(350))
            }

            try Task.checkCancellation()
            guard self.trigger == trigger else { return }

            state = .loading

            let cities = try await repository.searchCities(
                matching: query
            )

            try Task.checkCancellation()
            guard self.trigger == trigger else { return }

            state = cities.isEmpty ? .empty : .results(cities)

        } catch is CancellationError {
            return
        } catch {
            guard !Task.isCancelled, self.trigger == trigger else {
                return
            }

            state = .failure(error.asSearchFailure())
        }
    }
}
