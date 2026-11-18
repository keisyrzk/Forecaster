//
//  EmptyStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct EmptyStateView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    
    let text: String
    
    var body: some View {
        ContentUnavailableView.search(
            text: text
        )
        .foregroundStyle(palette.textPrimary, palette.textSecondary)
    }
}
