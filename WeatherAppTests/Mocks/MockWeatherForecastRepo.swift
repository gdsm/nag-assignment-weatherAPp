//
//  MockWeatherDataRepo.swift
//  WeatherAppTests
//
//  Created by Gagandeep
//

import Foundation
@testable import NetworkServices
@testable import WeatherApp

struct MockWeatherForecastRepo: WeatherForecastProtocol {
    let result: Result<WeatherForecastModel, ServiceError>

    func weatherForecast(coord: LocationModel) async throws -> WeatherForecastModel {
        switch result {
        case .success(let success):
            return success
        case .failure(let failure):
            throw failure
        }
    }
    
    static func mockData(coordinate: LocationModel) -> WeatherForecastModel? {
        guard let data = weatherForecastMockData(coordinate).data(using: .utf8) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(WeatherForecastResponse.self, from: data)
            return WeatherForecastModel(response: response)
        } catch {
            return nil
        }
    }
    
    static let weatherForecastMockData = { (coord: LocationModel) -> String in
        """
{"cod":"200","message":0,"cnt":40,"list":[{"dt":1708516800,"main":{"temp":283.06,"feels_like":282.78,"temp_min":283.06,"temp_max":284.84,"pressure":1024,"sea_level":1024,"grnd_level":938,"humidity":68,"temp_kf":-1.78},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":{"all":43},"wind":{"speed":1.42,"deg":31,"gust":1.29},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-02-21 12:00:00"},{"dt":1708527600,"main":{"temp":283.56,"feels_like":282.25,"temp_min":283.56,"temp_max":284.56,"pressure":1023,"sea_level":1023,"grnd_level":935,"humidity":61,"temp_kf":-1},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":52},"wind":{"speed":1.03,"deg":71,"gust":1.55},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-02-21 15:00:00"},{"dt":1708538400,"main":{"temp":280.96,"feels_like":280.17,"temp_min":279.91,"temp_max":280.96,"pressure":1023,"sea_level":1023,"grnd_level":934,"humidity":73,"temp_kf":1.05},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":60},"wind":{"speed":1.62,"deg":188,"gust":2.12},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-02-21 18:00:00"}],"city":{"id":3163858,"name":"Zocca","coord":{"lat":\(coord.lat),"lon":\(coord.lon)},"country":"IT","population":4593,"timezone":3600,"sunrise":1708495678,"sunset":1708534311}}
"""
    }
}
