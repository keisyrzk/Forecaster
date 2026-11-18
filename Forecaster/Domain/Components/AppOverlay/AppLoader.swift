//
//  AppLoader.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import SwiftUI

struct AppLoader: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    var body: some View {
        ProgressView("Loading...")
            .tint(palette.modalLoaderForeground)
            .foregroundStyle(palette.modalLoaderForeground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
