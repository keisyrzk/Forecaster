//
//  SearchView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel: SearchViewModel
    @State private var searchBarState: SearchBarState = .empty

    @FocusState private var isSearchFocused: Bool
    @State private var selectedCities: [City] = []
    @State private var navigationPath: [City] = []

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
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: City.self) { city in
                Text("Forecast for \(city.name)")
            }
            .task(id: viewModel.trigger) {
                await viewModel.search()
            }
        }
    }

    private var header: some View {
        Text("Weather")
            .font(.system(size: 36, weight: .bold))
            .foregroundStyle(.white)
            .padding(.top, 16)
    }

    private var savedCities: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(selectedCities) { city in
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
            if selectedCities.isEmpty {
                ContentUnavailableView(
                    "No saved cities",
                    systemImage: "cloud.sun",
                    description: Text(
                        "Search and select a city to add it here."
                    )
                )
                .foregroundStyle(.white)
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .start:
            savedCities

        case .loading:
            LoadingStateView()

        case let .results(cities):
            CitiesResultsStateView(cities: cities) { city in
                selectCity(city)
            }

        case .empty:
            EmptyStateView(text: viewModel.trigger.query)

        case let .failure(error):
            FailureStateView(errorMessage: error.message)
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
        selectedCities.removeAll { $0.id == city.id }
        selectedCities.insert(city, at: 0)

        cancelSearch()
    }

    private func openForecast(for city: City) {
        navigationPath.append(city)
    }
}
