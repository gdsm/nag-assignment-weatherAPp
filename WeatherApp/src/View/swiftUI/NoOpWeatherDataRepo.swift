//
//  MockWeatherDataRepo.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation
import NetworkServices

struct NoOpWeatherDataRepo: CurrentWeatherProtocol, WeatherForecastProtocol {
    func currentWeather(coord: LocationModel) async throws -> CurrentWeatherModel {
        throw ServiceError.unknown
    }
    
    func weatherForecast(coord: LocationModel) async throws -> WeatherForecastModel {
        throw ServiceError.unknown
    }
    
    func weatherForecast(query: String) async throws -> CurrentWeatherModel {
        throw ServiceError.unknown
    }
}
