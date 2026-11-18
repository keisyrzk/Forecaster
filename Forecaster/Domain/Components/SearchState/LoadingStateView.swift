//
//  LoadingStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct LoadingStateView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    var body: some View {
        ProgressView("Searching...")
            .tint(palette.textPrimary)
            .foregroundStyle(palette.textPrimary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
