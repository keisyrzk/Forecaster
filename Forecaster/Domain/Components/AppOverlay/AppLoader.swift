//
//  AppLoader.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import SwiftUI

struct AppLoader: View {
    var body: some View {
        ProgressView("Loading...")
            .tint(.white)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
