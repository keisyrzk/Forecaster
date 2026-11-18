//
//  SearchBarView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct SearchBarView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    
    @Binding var state: SearchBarState
    let onSearch: () -> Void
    let onCancel: () -> Void

    @FocusState private var isFocused: Bool

    private var textBinding: Binding<String> {
        Binding(
            get: { state.text },
            set: { text in
                if text.isEmpty {
                    state = .empty
                } else {
                    state = text.isValid(for: [.cityName])
                        ? .valid(text)
                        : .invalid(text)
                }
            }
        )
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                searchField
                
                if !state.text.isEmpty {
                    Button("Cancel") {
                        isFocused = false
                        onCancel()
                    }
                    .foregroundStyle(palette.textPrimary)
                    .transition(.opacity)
                }
            }
            
            if case .invalid = state {
                errorTextView
            }
        }
        .animation(
            .easeInOut(duration: 0.2),value: !state.text.isEmpty
        )
    }
    
    private var searchField: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(palette.textSecondary)
            
            searchTextField
            
            if !state.text.isEmpty {
                clearButton
            }
        }
        .padding(14)
        .background(
            palette.searchFieldBackground,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
    
    private var searchTextField: some View {
        TextField(
            "",
            text: textBinding,
            prompt: Text("Search city")
                .foregroundStyle(palette.textSecondary)
        )
        .foregroundStyle(palette.textPrimary)
        .tint(palette.textPrimary)
        .focused($isFocused)
        .textInputAutocapitalization(.words)
        .autocorrectionDisabled()
        .submitLabel(.search)
        .onSubmit {
            guard case .valid = state else { return }
            onSearch()
        }
    }
    
    private var clearButton: some View {
        Button {
            state = .empty
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(palette.textSecondary)
        }
    }
    
    private var errorTextView: some View {
        Text("Use at least 3 characters: letters, spaces or \"-\"")
            .font(.caption)
            .foregroundStyle(palette.textPrimary)
            .shadow(color: palette.validationShadow, radius: 2)
    }
}
