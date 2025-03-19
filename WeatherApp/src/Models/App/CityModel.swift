//
//  File.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct CityModel {
    let id: Int
    let name: String?
    let coordinates: LocationModel?
    let country: String
    let population: Int?
    let timezone: Int?
    let sunrise: Int
    let sunset: Int
    
    init(response: CityResponse) {
        self.id = response.id
        self.name = response.name
        if let coord = response.coord {
            self.coordinates = LocationModel(lat: coord.lat, lon: coord.lon)
        } else {
            self.coordinates = nil
        }
        self.country = response.country
        self.population = response.population
        self.timezone = response.timezone
        self.sunrise = response.sunrise
        self.sunset = response.sunset
    }
}
