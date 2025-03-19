//
//  WeatherForecastView.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import SwiftUI

struct WeatherForecastView: View {
    @ObservedObject var viewModel: WeatherForecastViewModel
    @State var showPermissionAlert = true

    var body: some View {
        VStack {
            switch viewModel.downloadStatePublisher {
            case .notStarted:
                Text("Weather data request not started.")
            case .inProgress:
                Text("Fetching weather data.")
            case .error(let message):
                Text("Failed to fetch data : \(message)")
            case .permissionError:
                Text(LocalisedString.permissionRequiredMessage)
                    .alert(isPresented: .constant(true), content: {
                        Alert(
                            title: Text(LocalisedString.permissionRequired),
                            message: Text(LocalisedString.permissionRequiredMessage),
                            primaryButton: .default(Text("OK")) {
                                viewModel.reset()
                                PermissionHelper.openSettings()
                            },
                            secondaryButton: .cancel()
                        )
                    })
            case .finished:
                getDisplayView()

                Spacer()
            }
        }
        .onAppear {
            viewModel.getWeatherData()
        }
    }
    
    @ViewBuilder
    func getDisplayView() -> some View {
        if let forecasts = viewModel.forecastPublisher?.forecasts {
            List(forecasts, id: \.self) { item in
                VStack(alignment: .leading) {
                    Text(item.dateText)
                    .multilineTextAlignment(.leading)
                    
                    Text("Temperature: \(item.temperature.tempCelsius())")
                    .multilineTextAlignment(.leading)
                }
            }
        } else {
            Text("No weather forecast data available")
        }
    }
}

#Preview {
    WeatherForecastView(viewModel: WeatherForecastViewModel(repo: NoOpWeatherDataRepo()))
}
