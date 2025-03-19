//
//  WeatherForecastViewModelTest.swift
//  WeatherAppTests
//
//  Created by Gagandeep
//

import Combine
import XCTest
@testable import WeatherApp

final class WeatherForecastViewModelTest: XCTestCase {

    private var cancellable: AnyCancellable?
    
    func testGetWeatherDataSuccess() throws {
        let expectation = XCTestExpectation(description: "Testing weather forecast")
        let mockCoordinates = LocationModel(lat: 10.0, lon: 11.0)
        let mockForecast = try XCTUnwrap(MockWeatherForecastRepo.mockData(coordinate: mockCoordinates))
        
        let viewModel = WeatherForecastViewModel(
            locationManager: MockLocationManager(coordinate: mockCoordinates),
            repo: MockWeatherForecastRepo(result: .success(mockForecast))
        )
        
        viewModel.getWeatherData()
        cancellable = viewModel.$forecastPublisher.drop(while: { $0 == nil }).sink { value in
            if let val = value {
                XCTAssertEqual(val.forecasts!.count, 3)
                XCTAssertEqual(val.city?.coordinates!.lat, mockCoordinates.lat)
                XCTAssertEqual(val.city?.coordinates!.lon, mockCoordinates.lon)
                XCTAssertEqual(viewModel.downloadStatePublisher, WeatherDataDownloadState.finished)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2000)
    }

    func testGetWeatherDataFailure() throws {
        let expectation = XCTestExpectation(description: "Testing weather forecast")
        let mockCoordinates = LocationModel(lat: 10.0, lon: 11.0)
        
        let viewModel = WeatherForecastViewModel(
            locationManager: MockLocationManager(coordinate: mockCoordinates),
            repo: MockWeatherForecastRepo(result: .failure(.unknown))
        )
        
        viewModel.getWeatherData()
        // This is error case and we should not receive finish state.
        cancellable = viewModel.$downloadStatePublisher.sink { state in
            XCTAssertNotEqual(state, WeatherDataDownloadState.finished)
            if case .error(_) = state {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
