//
//  File.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct CityResponse: Codable {
    let id: Int
    let name: String?
    let coord: CoordinateResponse?
    let country: String
    let population: Int?
    let timezone: Int?
    let sunrise: Int
    let sunset: Int
}
