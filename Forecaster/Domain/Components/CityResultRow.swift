//
//  CityResultRow.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct CityResultRow: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    let city: City

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(city.name)
                    .font(.headline)
                    .foregroundStyle(palette.textPrimary)

                Text(
                    [city.region, city.country]
                        .compactMap { $0 }
                        .joined(separator: ", ")
                )
                .font(.subheadline)
                .foregroundStyle(palette.textSecondary)
            }

            Spacer()
        }
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }
}
