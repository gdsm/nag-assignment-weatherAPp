//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct CurrentWeatherModel: Sendable {
    let coordinates: LocationModel
    let weather: [WeatherModel]
    let base: String
    let temperature: TemperatureModel
    let visibility: Int
    let wind: WindModel
    let clouds: CloudModel
    
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    init(response: CurrentWeatherResponse) {
        self.coordinates = LocationModel(lat: response.coordinates.lat, lon: response.coordinates.lon)
        self.weather = response.weather.map { WeatherModel(model: $0) }
        self.base = response.base
        self.temperature = TemperatureModel(response: response.temperature)
        self.visibility = response.visibility
        self.wind = WindModel(model: response.wind)
        self.clouds = CloudModel(model: response.clouds)
        
        self.timezone = response.timezone
        self.id = response.id
        self.name = response.name
        self.cod = response.cod
    }
    
    init(response: WeatherQueryResponse) {
        self.coordinates = LocationModel(lat: response.coord.lat, lon: response.coord.lon)

        self.weather = response.weather.map { WeatherModel(model: $0) }
        self.base = response.base
        self.temperature = TemperatureModel(response: response.temperature)
        self.visibility = response.visibility
        self.wind = WindModel(model: response.wind)
        self.clouds = CloudModel(model: response.clouds)

        self.timezone = response.dt
        self.id = response.id
        self.name = response.name
        self.cod = response.cod
    }
}
