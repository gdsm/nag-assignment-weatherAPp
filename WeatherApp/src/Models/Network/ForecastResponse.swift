//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct ForecastResponse: Codable, Hashable {
    
    let date: Int
    let dateText: String
    let temperature: TemperatureResponse
    let weather: [WeatherReponse]
    let clouds: CloudResponse
    let wind: WindResponse
    let visibility: Int

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case dateText = "dt_txt"
        case temperature = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
    }
}
