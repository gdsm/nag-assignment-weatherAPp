//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct WeatherModel: Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init(model: WeatherReponse) {
        self.id = model.id
        self.main = model.main
        self.description = model.description
        self.icon = model.icon
    }
}
