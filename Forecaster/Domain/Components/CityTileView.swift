//
//  CityTileView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct CityTileView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    let city: City

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(city.name)
                    .font(.title2.bold())

                Text(city.country)
                    .font(.subheadline)
                    .foregroundStyle(palette.textSecondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(palette.textSecondary)
        }
        .foregroundStyle(palette.textPrimary)
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 105)
        .background {
            BackgroundView(type: .tile)
                .cornerRadius(20)
        }
    }
}
