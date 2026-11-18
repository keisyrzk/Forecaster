//
//  SearchView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    @State private var viewModel: SearchViewModel
    @State private var searchBarState: SearchBarState = .empty
    
    @FocusState private var isSearchFocused: Bool
    @State private var navigationPath: [ForecastDestination] = []
    @State private var overlay: AppOverlayType?
    
    init(viewModel: SearchViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(alignment: .leading, spacing: 20) {
                header
                
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                searchBar
                    .disabled(!viewModel.canSearch)
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                BackgroundView(type: .default)
                    .ignoresSafeArea()
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: ForecastDestination.self) { destination in
                ForecastView(weatherForecast: destination.forecast, cityName: destination.cityName)
            }
            .task(id: viewModel.trigger) {
                await viewModel.search()
            }
            .task {
                await viewModel.loadCities()
            }
        }
        .tint(palette.textPrimary)
        .appOverlay($overlay)
    }
    
    private var header: some View {
        Text("Weather")
            .font(.system(size: 36, weight: .bold))
            .foregroundStyle(palette.textPrimary)
            .padding(.top, 16)
    }
    
    private var retryLoadingCities: some View {
        Button {
            Task {
                await viewModel.loadCities()
            }
        } label: {
            Text("Retry loading cities")
        }
        .tint(palette.textPrimary)
        .frame(width: 100, height: 40)
        .clipShape(Capsule())
    }
    
    private var savedCities: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(viewModel.storedCities) { city in
                    Button {
                        openForecast(for: city)
                    } label: {
                        CityTileView(city: city)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .overlay {
            if viewModel.storedCities.isEmpty {
                ContentUnavailableView(
                    "No saved cities",
                    systemImage: "cloud.sun",
                    description: Text(
                        "Search and select a city to add it here."
                    )
                )
                .foregroundStyle(palette.textPrimary, palette.textSecondary)
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loadingCancelled:
            retryLoadingCities
            
        case .start:
            savedCities
            
        case .initial, .loadingStore, .loadingSearch, .savingStore:
            LoadingStateView()
            
        case let .results(cities):
            CitiesResultsStateView(cities: cities) { city in
                selectCity(city)
            }
            
        case .empty:
            EmptyStateView(text: viewModel.trigger.query)
            
        case let .failure(error):
            switch error {
            case .persistentStoreLoad:
                retryLoadingCities
            default:
                FailureStateView(errorMessage: error.message)
            }
        }
    }
    
    private var searchBar: some View {
        SearchBarView(
            state: $searchBarState,
            onSearch: {
                viewModel.submitSearch()
            },
            onCancel: {
                cancelSearch()
            }
        )
        .onChange(of: searchBarState) { _, state in
            switch state {
            case .valid(let text):
                viewModel.updateQuery(text)
            case .empty, .invalid:
                viewModel.updateQuery("")
            }
        }
    }
    
    private func cancelSearch() {
        searchBarState = .empty
        viewModel.updateQuery("")
        isSearchFocused = false
    }
    
    private func selectCity(_ city: City) {
        Task {
            await viewModel.selectCity(city) {
                cancelSearch()
            }
        }
    }
    
    private func openForecast(for city: City) {
        Task { @MainActor in
            do {
                overlay = .loader
                let forecast = try await viewModel.getWeatherForecast(for: city)
                try Task.checkCancellation()
                overlay = nil
                navigationPath.append(ForecastDestination(cityName: city.name, forecast: forecast))
            } catch is CancellationError {
                overlay = nil
            } catch {
                if let apiError = error as? APIError,
                   apiError == .noConnection {
                    overlay = .alert(message: "No internet connection. Check your connection and try again.")
                } else {
                    overlay = .alert(message: "Failed fetching weather forecast. Please try again.")
                }
            }
        }
    }
}
