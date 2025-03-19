//
//  AppView.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import SwiftUI

struct AppView: View {
    
    private let placeSearchViewModel = PlaceSearchViewModel(repo: WeatherDataRepoFactory.getPlaceSearchRepo())

    @State private var showCurrentWeather = false
    @State private var showWeatherForecast = false
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Text("Weather Forecast")
                    .font(.largeTitle)
                    .bold()
                
                Button(LocalisedString.showCurrentweather) {
                    navigationPath.append(AppNavigation.currentForecast)
                }
                .modifier(ButtonViewModifier())

                Button(LocalisedString.showWeatherForecast) {
                    navigationPath.append(AppNavigation.forecast)
                }
                .modifier(ButtonViewModifier())

                Button(LocalisedString.placeSearch) {
                    navigationPath.append(AppNavigation.placeSearch)
                }
                .modifier(ButtonViewModifier())
            }
            .padding()
            .navigationDestination(for: AppNavigation.self) { path in
                switch path {
                case .currentForecast:
                    getCurrentWeatherView(query: nil)
                case .forecast:
                    getWeatherForecastView()
                case .forecastPlace:
                    getCurrentWeatherView(query: placeSearchViewModel.searchText)
                case .placeSearch:
                    getPlaceSearchView()
                }
            }
        }
    }
    
    func getCurrentWeatherView(query: String?) -> some View {
        let model = CurrentWeatherViewModel(searchQuery: query, repo: WeatherDataRepoFactory.getWeatherDataRepo())
        return CurrentWeatherView(viewModel: model)
    }
    
    func getWeatherForecastView() -> some View {
        let model = WeatherForecastViewModel(repo: WeatherDataRepoFactory.getWeatherDataRepo())
        return WeatherForecastView(viewModel: model)
    }

    func getPlaceSearchView() -> some View {
        return PlaceSearchView(viewModel: placeSearchViewModel, navigationPath: $navigationPath)
    }

}

//#Preview {
//    AppView()
//}
