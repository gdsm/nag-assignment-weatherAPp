//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct WeatherReponse: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
