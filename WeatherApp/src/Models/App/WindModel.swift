//
//  WindModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct WindModel: Hashable {
    let speed: Double
    let deg: Int
    let gust: Double?
    
    func speedText() -> String {
        return "\(speed) meter/sec"
    }
    
    init(model: WindResponse) {
        self.speed = model.speed
        self.deg = model.deg
        self.gust = model.gust
    }
}
