//
//  WeatherDataDownloadState.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

enum WeatherDataDownloadState: Equatable, Sendable {
    case notStarted
    case inProgress
    case finished
    case permissionError
    case error(message: String)
}
