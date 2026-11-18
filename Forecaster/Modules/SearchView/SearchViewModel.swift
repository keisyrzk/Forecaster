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
    private(set) var state: SearchState = .initial
    private(set) var storedCities: [City] = []
    
    private let cityRepository: CityRepository
    private let storeRepository: PersistentStoreRepository
    private let weatherRepository: WeatherRepository

    init(repository: CityRepository, storeRepository: PersistentStoreRepository, weatherRepository: WeatherRepository) {
        self.cityRepository = repository
        self.storeRepository = storeRepository
        self.weatherRepository = weatherRepository
    }
    
    
    // MARK: Persistent store
    
    func selectCity(_ city: City, onSuccess: () -> Void) async {
        guard case .results = state else { return }

        let previousState = state
        state = .savingStore

        var cities = storedCities
        cities.removeAll { $0.id == city.id }
        cities.insert(city, at: 0)

        await save(cities: cities, previousState: previousState, onSuccess: onSuccess)
    }
    
    private func save(cities: [City], previousState: SearchState, onSuccess: () -> Void) async {
        do {
            try Task.checkCancellation()
            try await storeRepository.saveCities(cities)
            storedCities = cities
            state = .start
            onSuccess()
        } catch is CancellationError {
            state = previousState
        } catch {
            state = .failure(.persistentStoreSave)
        }
    }
    
    func loadCities() async {
        switch state {
        case .initial, .loadingCancelled, .failure(.persistentStoreLoad):
            break
        default:
            return
        }

        state = .loadingStore
        do {
            try Task.checkCancellation()

            let cities = try await storeRepository.loadCities()

            try Task.checkCancellation()

            storedCities = cities
            state = .start
        } catch is CancellationError {
            state = .loadingCancelled
        } catch {
            state = Task.isCancelled
                ? .loadingCancelled
                : .failure(.persistentStoreLoad)
        }
    }
    
    
    // MARK: Query text change
    
    func updateQuery(_ text: String) {
        guard canSearch, trigger.query != text else { return }

        trigger.query = text
        trigger.submissionID = nil

        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)

        state = query.count >= 3 ? .loadingSearch : .start
    }

    
    // MARK: Manual search action
    
    func submitSearch() {
        guard canSearch else { return }

        state = .loadingSearch
        trigger.submissionID = UUID()
    }
    
    func search() async {
        
        // Preserve the initial load and retry screens until the user starts a search.
        switch state {
        case .initial, .loadingStore, .savingStore, .loadingCancelled, .failure(.persistentStoreLoad):
            return
        default:
            break
        }
        
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
            guard canSearch, self.trigger == trigger else { return }

            state = .loadingSearch

            let cities = try await cityRepository.searchCities(
                matching: query
            )

            try Task.checkCancellation()
            guard canSearch, self.trigger == trigger else { return }

            state = cities.isEmpty ? .empty : .results(cities)

        } catch is CancellationError {
            return
        } catch {
            guard !Task.isCancelled, canSearch, self.trigger == trigger else {
                return
            }

            state = .failure(error.asSearchFailure())
        }
    }
    
    var canSearch: Bool {
        switch state {
        case .initial, .loadingStore, .savingStore:
            false
        default:
            true
        }
    }
    
    
    // MARK: Weather forecast details
    
    func getWeatherForecast(for city: City) async throws -> WeatherForecast {
        try await weatherRepository.fetchForecast(for: city)
    }
}
