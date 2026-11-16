//
//  EmptyStateView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct EmptyStateView: View {
    
    let text: String
    
    var body: some View {
        ContentUnavailableView.search(
            text: text
        )
    }
}
