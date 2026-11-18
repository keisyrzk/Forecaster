//
//  AppAlert.swift
//  Forecaster
//
//  Created by Esteban on 17/11/2026.
//

import SwiftUI

struct AppAlert: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    let message: String
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            palette.defaultBackground
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text(verbatim: message)
                    .multilineTextAlignment(.center)

                Button("OK", action: onDismiss)
                    .buttonStyle(.borderedProminent)
            }
            .padding(24)
            .frame(maxWidth: 360)
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 20)
            )
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityAddTraits(.isModal)
    }
}
