//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct ForecastModel: Hashable {
    let date: Int
    let dateText: String
    let temperature: TemperatureModel
    let weather: [WeatherModel]
    let clouds: CloudModel
    let wind: WindModel
    let visibility: Int
    
    init(response: ForecastResponse) {
        self.date = response.date
        self.dateText = response.dateText
        self.temperature = TemperatureModel(response: response.temperature)
        self.weather = response.weather.map { WeatherModel(model: $0) }
        self.clouds = CloudModel(model: response.clouds)
        self.wind = WindModel(model: response.wind)
        self.visibility = response.visibility
    }
}
