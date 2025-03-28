//
//  TemperatureModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct TemperatureResponse: Codable, Hashable {
    let temp: Double
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
}
