//
//  WeatherDataRepoFactory.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation
import NetworkServices

/// Struct provides factory for repos. Repo can have a complext init and some of the values are not required to exposed everywhere. So a common factory class to generate repo.
struct WeatherDataRepoFactory {
    
    /// Factory method to get WeatherDataRepo
    /// - Returns: Repo instance
    static func getWeatherDataRepo() -> WeatherDataRepo {
        return WeatherDataRepo(urlBuilder: URLEnvironment.prod, networkInterface: NetworkFactory.getService())
    }
    
    static func getPlaceSearchRepo() -> PlaceSearchRepo {
        return PlaceSearchRepo(urlBuilder: URLEnvironment.prod, networkInterface: NetworkFactory.getService())
    }
}
