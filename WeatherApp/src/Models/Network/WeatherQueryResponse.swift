//
//  ForecastQueryResponse.swift
//  WeatherApp
//
//  Created by gagandeep
//

import Foundation

struct WeatherQueryResponse: Codable {
    let coord: CoordinateResponse
    let weather: [WeatherReponse]
    let base: String
    let temperature: TemperatureResponse
    let visibility: Int
    let wind: WindResponse
    let clouds: CloudResponse
    let dt: Int
    let city: CityResponse
    let id: Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case temperature = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case city = "sys"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}
