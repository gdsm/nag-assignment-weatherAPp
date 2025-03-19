//
//  WeatherDataRepo.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation
@preconcurrency import NetworkServices

/// Repo class to get weather data.
class WeatherDataRepo: BaseRepo, CurrentWeatherProtocol, WeatherForecastProtocol {
    let urlBuilder: URLBuilder
    let networkInterface: NetworkProtocol
    
    // MARK: Init methods
    init(urlBuilder: URLBuilder, networkInterface: NetworkProtocol) {
        self.urlBuilder = urlBuilder
        self.networkInterface = networkInterface
    }
    
    func buildUrl(lat: Double, lon: Double, path: String) -> URL? {
        let urlString =  "\(urlBuilder.getWeatherApiBaseUrl())\(path)?lat=\(lat)&lon=\(lon)&\(urlBuilder.getWeatherApiAppId())"
        return URL(string: urlString)
    }

    func buildUrl(query: String, path: String) -> URL? {
        let urlString =  "\(urlBuilder.getWeatherApiBaseUrl())\(path)?q=\(query)&\(urlBuilder.getWeatherApiAppId())"
        return URL(string: urlString)
    }

    // MARK: CurrentWeatherProtocol
    func currentWeather(coord: LocationModel) async throws -> CurrentWeatherModel {
        guard let url = buildUrl(lat: coord.lat, lon: coord.lon, path: "weather") else {
            throw ServiceError.unknown
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        let result: CurrentWeatherResponse = try await networkInterface.request(urlRequest: request)
        return CurrentWeatherModel(response: result)
    }
    
    func weatherForecast(query: String) async throws -> CurrentWeatherModel {
        guard let url = buildUrl(query: query, path: "weather") else {
            throw ServiceError.unknown
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        let result: WeatherQueryResponse = try await networkInterface.request(urlRequest: request)
        return CurrentWeatherModel(response: result)
    }
    
    // MARK: WeatherForecastProtocol
    func weatherForecast(coord: LocationModel) async throws -> WeatherForecastModel {
        guard let url = buildUrl(lat: coord.lat, lon: coord.lon, path: "forecast") else {
            throw ServiceError.unknown
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        let result: WeatherForecastResponse = try await networkInterface.request(urlRequest: request)
        return WeatherForecastModel(response: result)
    }
}
