//
//  BaseRepo.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation
import NetworkServices


/// Base repo enforces all inherited class to handle urlBuilder and network interface.
protocol BaseRepo {
    var urlBuilder: URLBuilder { get }
    var networkInterface: NetworkProtocol { get }
}
