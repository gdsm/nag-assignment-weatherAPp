//
//  URLBuilderTest.swift
//  WeatherApp
//
//  Created by gagandeep on 18/03/25.
//

import Testing
@testable import NetworkServices
@testable import WeatherApp

@Suite(.serialized)
struct URLBuilderTest {
    
    private let config: URLSessionConfiguration
    
    init() {
        config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 1
        config.timeoutIntervalForResource = 1
        config.protocolClasses = [MockURLProtocol.self]
    }

    @Test func testUrlBuilder() {
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        let locationModel = LocationModel(lat: 33.0, lon: 34.0)
        
        locationModel.update(address: Address(state: nil, country: nil))
        let url = repo.buildUrl(lat: 33.0, lon: 34.0, path: "weather")
        #expect(url!.absoluteString == "https://api.openweathermap.org/data/2.5/weather?lat=33.0&lon=34.0&appid=4f7a815f62f6d72f5d313000a748b8d2")
    }
}
