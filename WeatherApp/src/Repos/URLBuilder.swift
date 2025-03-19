//
//  URLBuilder.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

protocol URLBuilder {
    func getWeatherApiBaseUrl() -> String
    func getWeatherApiAppId() -> String
    
    func getPlaceSearchBaseUrl() -> String
    func getPlaceSearchApiAppId() -> String
}

enum URLEnvironment {
    case prod
    case qa
    case dev
}

extension URLEnvironment: URLBuilder {
    func getWeatherApiBaseUrl() -> String {
        switch self {
        case .prod, .qa, .dev:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }
    
    func getWeatherApiAppId() -> String {
        switch self {
        case .prod:
            // TODO: Perform encrytption.
            return "appid=4f7a815f62f6d72f5d313000a748b8d2"
        case .qa, .dev:
            return "appid=4f7a815f62f6d72f5d313000a748b8d2"
        }
    }
    
    func getPlaceSearchBaseUrl() -> String {
        switch self {
        case .prod, .qa, .dev:
            return "https://maps.googleapis.com/maps/api/place/autocomplete/json"
        }
    }
    
    func getPlaceSearchApiAppId() -> String {
        switch self {
        case .prod:
            // TODO: Perform encrytption.
            return "AIzaSyBcPPNLXCqenhqhQR3kdGhEKUH6znfVXno"
        case .qa, .dev:
            return "AIzaSyBcPPNLXCqenhqhQR3kdGhEKUH6znfVXno"
        }
    }
}
