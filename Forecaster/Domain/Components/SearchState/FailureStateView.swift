//
//  FailureStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct FailureStateView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    
    let errorMessage: String
    
    var body: some View {
        ContentUnavailableView(
            "Search unavailable",
            systemImage: "wifi.exclamationmark",
            description: Text(errorMessage)
        )
        .foregroundStyle(palette.textPrimary, palette.textSecondary)
    }
}
