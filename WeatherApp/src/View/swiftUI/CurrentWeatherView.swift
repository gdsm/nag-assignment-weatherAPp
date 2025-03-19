//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @ObservedObject var viewModel: CurrentWeatherViewModel
        
    var body: some View {
        VStack {
            switch viewModel.downloadStatePublisher {
            case .error(let message):
                Text("Failed to fetch data : \(message)")
            case .inProgress:
                Text("Fetching weather data.")
            case .permissionError:
                Text(LocalisedString.permissionRequiredMessage)
                    .alert(isPresented: .constant(true), content: {
                        Alert(
                            title: Text(LocalisedString.permissionRequired),
                            message: Text(LocalisedString.permissionRequiredMessage),
                            primaryButton: .default(Text("OK")) {
                                PermissionHelper.openSettings()
                            },
                            secondaryButton: .cancel()
                        )
                    })
            case .notStarted:
                Text("Weather data request not started.")
            case .finished:
                getDisplayView()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                Spacer()
            }
        }
        .onAppear() {
            viewModel.getWeatherData()
        }
    }
    
    func getDisplayView() -> some View {
        return VStack {
            HStack {
                Text("Temperature : ")
                if let temperature = viewModel.currentWeatherPublisher?.temperature.tempCelsius() {
                    Text("\(temperature)")
                }
            }
            HStack {
                Text("wind speed: ")
                if let windSpeed = viewModel.currentWeatherPublisher?.wind.speedText() {
                    Text("\(windSpeed)")
                }
            }
        }
    }
}

#Preview {
    CurrentWeatherView(
        viewModel: CurrentWeatherViewModel(repo: NoOpWeatherDataRepo())
    )
}
