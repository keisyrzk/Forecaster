//
//  ContentView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SearchView(viewModel: SearchViewModel())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
