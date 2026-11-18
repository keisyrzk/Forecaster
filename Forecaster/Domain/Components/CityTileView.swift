//
//  CityTileView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct CityTileView: View {
    let city: City

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(city.name)
                    .font(.title2.bold())

                Text(city.country)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.white.opacity(0.6))
        }
        .foregroundStyle(.white)
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 105)
        .background {
            BackgroundView(type: .tile)
                .cornerRadius(20)
        }
    }
}
