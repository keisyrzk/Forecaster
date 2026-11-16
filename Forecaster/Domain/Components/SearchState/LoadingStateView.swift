//
//  LoadingStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct LoadingStateView: View {
    var body: some View {
        ProgressView("Searching...")
            .tint(.white)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
