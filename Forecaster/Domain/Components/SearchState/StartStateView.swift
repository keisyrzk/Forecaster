//
//  StartStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct StartStateView: View {
    var body: some View {
        ContentUnavailableView(
            "Search for a city",
            systemImage: "magnifyingglass",
            description: Text("Enter at least 3 characters")
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
