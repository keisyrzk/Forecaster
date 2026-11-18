//
//  CitiesResultsStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct CitiesResultsStateView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    
    let cities: [City]
    let selectCity: (City) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(cities) { city in
                    Button {
                        selectCity(city)
                    } label: {
                        CityResultRow(city: city)
                    }
                    .buttonStyle(.plain)

                    Divider()
                        .overlay(palette.resultsOverlay)
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }
}
