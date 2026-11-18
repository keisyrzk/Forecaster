//
//  StartStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct StartStateView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    var body: some View {
        ContentUnavailableView(
            "Search for a city",
            systemImage: "magnifyingglass",
            description: Text("Enter at least 3 characters")
        )
        .foregroundStyle(palette.textPrimary, palette.textSecondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
