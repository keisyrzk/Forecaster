//
//  SearchBarView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    let onSearch: () -> Void
    let onCancel: () -> Void

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white.opacity(0.6))

                TextField(
                    "",
                    text: $text,
                    prompt: Text("Search city")
                        .foregroundStyle(.white.opacity(0.5))
                )
                .foregroundStyle(.white)
                .tint(.white)
                .focused($isFocused)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()
                .submitLabel(.search)
                .onSubmit {
                    onSearch()
                }
                .accessibilityIdentifier("citySearchField")

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .accessibilityLabel("Clear search text")
                }
            }
            .padding(14)
            .background(
                Color.white.opacity(0.2),
                in: RoundedRectangle(cornerRadius: 16)
            )

            if !text.isEmpty {
                Button("Cancel") {
                    isFocused = false
                    onCancel()
                }
                .foregroundStyle(.white)
                .transition(.opacity)
            }
        }
        .animation(
            .easeInOut(duration: 0.2),
            value: !text.isEmpty
        )
    }
}
