//
//  CurrentWeatherViewModelTest.swift
//  WeatherAppTests
//
//  Created by Gagandeep
//

import Combine
import XCTest
@testable import WeatherApp

class CurrentWeatherViewModelTest: XCTestCase {
    
    private var cancellable: AnyCancellable?
    
    func testGetCurrentWeatherSuccess() throws {
        let expectation = XCTestExpectation(description: "Testing current weather")
        let mockCoordinates = LocationModel(lat: 10.0, lon: 11.0)
        let mockData = try XCTUnwrap(MockCurrentWeatherRepo.mockData(coordinate: mockCoordinates, temp: 300))
        
        let viewModel = CurrentWeatherViewModel(
            repo: MockCurrentWeatherRepo(result: .success(mockData)),
            locationManager: MockLocationManager(coordinate: mockCoordinates)
        )
        
        viewModel.getWeatherData()
        cancellable = viewModel.$currentWeatherPublisher.drop(while: { $0 == nil }).sink { value in
            if let val = value {
                XCTAssertEqual(val.coordinates.lat, mockCoordinates.lat)
                XCTAssertEqual(val.coordinates.lon, mockCoordinates.lon)
                XCTAssertEqual(val.temperature.temp, 300)
                XCTAssertEqual(viewModel.downloadStatePublisher, WeatherDataDownloadState.finished)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }

    func testGetCurrentWeatherFailure() throws {
        let expectation = XCTestExpectation(description: "Testing current weather")
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
