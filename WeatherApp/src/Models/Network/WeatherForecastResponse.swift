//
//  WeatherForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct WeatherForecastResponse: Codable {
    let cod: String
    let message: Int
    let numberOfTimeStamps: Int
    let city: CityResponse
    let forecasts: [ForecastResponse]
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case numberOfTimeStamps = "cnt"
        case city = "city"
        case forecasts = "list"
    }
}
