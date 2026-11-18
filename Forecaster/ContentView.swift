//
//  ContentView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SearchView(viewModel: SearchViewModel(repository: OpenMeteoCityRepository(), storeRepository: DefaultPersistentStoreRepository(store: DefaultPersistantStore()), weatherRepository: OpenMeteoWeatherRepository()))
    }
}

#Preview {
    ContentView()
}
