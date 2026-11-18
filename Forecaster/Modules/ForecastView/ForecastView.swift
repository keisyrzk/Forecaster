//
//  ForecastView.swift
//  Forecaster
//
//  Created by Esteban on 16/11/2026.
//

import SwiftUI

struct ForecastDestination: Hashable {
    let cityName: String
    let forecast: WeatherForecast
}

struct ForecastView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var palette: AppPalette {
        AppPalette(colorScheme: colorScheme)
    }

    @State private var viewModel: ForecastViewModel

    init(weatherForecast: WeatherForecast, cityName: String = "") {
        _viewModel = State(initialValue: ForecastViewModel(weatherForecast: weatherForecast, cityName: cityName))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForecastHeader(
                    cityName: viewModel.cityName,
                    temperature: viewModel.weatherForecast.temperature,
                    condition: viewModel.weatherForecast.condition
                )
                
                HourlyForecastCard(hourlyForecast: viewModel.hourlyForecast)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
            .frame(maxWidth: 700)
            .frame(maxWidth: .infinity)
        }
        .background {
            BackgroundView(type: .forecast(viewModel.weatherForecast.condition))
                .ignoresSafeArea()
        }
        .foregroundStyle(palette.textPrimary)
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}
