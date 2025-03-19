//
//  TemperatureModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct TemperatureModel: Hashable {
    let temp: Double
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
    
    func tempCelsius() -> String {
        let celTemp = UnitsHelper.convertTemperature(temp: temp, from: .kelvin, to: .celsius)
        let value = String(format: "%.2f", celTemp)
        return "\(value) Cel"
    }
    
    init(response: TemperatureResponse) {
        self.temp = response.temp
        self.feels_like = response.feels_like
        self.temp_min = response.temp_min
        self.temp_max = response.temp_max
        self.pressure = response.pressure
        self.humidity = response.humidity
        self.sea_level = response.sea_level
        self.grnd_level = response.grnd_level
    }
}
