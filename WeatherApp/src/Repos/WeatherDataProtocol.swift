//
//  WeatherDataProtocol.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation
import NetworkServices

protocol CurrentWeatherProtocol {
    /// Method fetched current weather forecast from service. External server is third party server and have restrictions on it.
    /// Network request will transform Network Model to AppModels. This is to avoid any tempering of Models connected with API.
    /// - Parameter coord: Current coordinates
    /// - Returns: Return Current weather data or error
    func currentWeather(coord: LocationModel) async throws -> CurrentWeatherModel
    
    /// Get Lat lon for query
    /// - Parameter query: Could be city, state, place, country name.
    /// - Returns: Lan, Lon
    func weatherForecast(query: String) async throws -> CurrentWeatherModel
}

protocol WeatherForecastProtocol {
    /// Method fetched current weather forecast from service. External server is third party server and have restrictions on it.
    /// Network request will transform Network Model to AppModels. This is to avoid any tempering of Models connected with API.
    /// - Parameter coord: Current coordinates
    /// - Returns: Return Current weather data or error
    func weatherForecast(coord: LocationModel) async throws -> WeatherForecastModel
}
