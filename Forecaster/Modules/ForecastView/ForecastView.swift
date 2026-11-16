//
//  ForecastView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct ForecastView: View {
    
    @State private var viewModel: ForecastViewModel

    init(viewModel: ForecastViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        Text("ForecastView")
    }
}
