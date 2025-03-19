//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Gagandeep
//

import Testing
import XCTest
@testable import NetworkServices
@testable import WeatherApp

class WeatherDataRepoTest: XCTestCase {
    
    private var config: URLSessionConfiguration!
    private let mockHandlerTag = "WeatherDataRepoTest"
    private static let coords = LocationModel(lat: 28.70, lon: 77.10)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 1
        config.timeoutIntervalForResource = 1
        config.protocolClasses = [MockURLProtocol.self]
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        MockURLProtocol.unregister(tag: mockHandlerTag)
    }
    
    func testGetCurrentWeatherSuccess() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.ok.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            let data = MockCurrentWeatherRepo.currentWeatherMockData(Self.coords, 300).data(using: .utf8)
            return Result.success((response, data))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.currentWeather(coord: Self.coords)
                XCTAssertEqual(Self.coords.lat, result.coordinates.lat)
                XCTAssertEqual(Self.coords.lon, result.coordinates.lon)
                expectation.fulfill()
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCurrentWeatherFailure() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.forbidden.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            return Result.success((response, nil))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.currentWeather(coord: Self.coords)
                expectation.fulfill()
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherForecastSuccess() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.ok.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            let data = MockWeatherForecastRepo.weatherForecastMockData(Self.coords).data(using: .utf8)
            return Result.success((response, data))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.weatherForecast(coord: Self.coords)
                let coordinates = try XCTUnwrap(result.city?.coordinates)
                XCTAssertEqual(Self.coords.lat, coordinates.lat)
                XCTAssertEqual(Self.coords.lon, coordinates.lon)
                expectation.fulfill()
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherForecastFailure() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.forbidden.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            return Result.success((response, nil))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.weatherForecast(coord: Self.coords)
                expectation.fulfill()
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
