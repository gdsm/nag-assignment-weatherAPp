//
//  WindModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct WindResponse: Codable, Hashable {
    let speed: Double
    let deg: Int
    let gust: Double?
}
