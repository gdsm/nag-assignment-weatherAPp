//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let coordinates: CoordinateResponse
    let weather: [WeatherReponse]
    let base: String
    let temperature: TemperatureResponse
    let visibility: Int
    let wind: WindResponse
    let clouds: CloudResponse
    
    let timezone: Int
    let id:Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather = "weather"
        case base = "base"
        case temperature = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"

        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}
