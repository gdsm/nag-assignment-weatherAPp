//
//  LocalisedString.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

/// Container encapsulates all strings and one place. This is helpfull to localisation. L10n library can later be integrated to provide localisation.
struct LocalisedString {
    static let showCurrentweather = "Show current weather"
    static let showWeatherForecast = "Show weather forecast"
    static let placeSearch = "Search places"

    static let permissionRequired = "Permission required"
    static let permissionRequiredMessage = "Weather app needs location permission in order to fetch current location."
}
