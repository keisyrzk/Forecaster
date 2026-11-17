//
//  FailureStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct FailureStateView: View {
    
    let errorMessage: String
    
    var body: some View {
        ContentUnavailableView(
            "Search unavailable",
            systemImage: "wifi.exclamationmark",
            description: Text(errorMessage)
        )
    }
}
