//
//  CoordinateModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct Address: Sendable {
    let state: String?
    let country: String?
}

final class LocationModel: Codable, @unchecked Sendable {
    
    let lat: Double
    let lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    private(set) var state: String?
    private(set) var country: String?
    
    func update(address: Address) {
        self.state = address.state
        self.country = address.country
    }
}
