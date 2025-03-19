//
//  WeatherForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct WeatherForecastModel {
    let cod: String
    let message: Int?
    let numberOfTimeStamps: Int?
    let city: CityModel?
    let forecasts: [ForecastModel]?
    
    init(response: WeatherForecastResponse) {
        self.cod = response.cod
        self.message = response.message
        self.numberOfTimeStamps = response.numberOfTimeStamps
        self.city = CityModel(response: response.city)
        self.forecasts = response.forecasts.compactMap { ForecastModel(response: $0) }
    }
}
