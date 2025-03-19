//
//  AppViewTest.swift
//  WeatherAppUITests
//
//  Created by Gagandeep
//

import XCTest
@testable import WeatherApp

final class AppViewTest: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrentWeatherButtonClick() throws {
        let buttonIdentifier = "showCurrentWeather"
        
        let button = app.buttons[buttonIdentifier]
        XCTAssertTrue(button.exists)
        XCTAssertEqual(button.label, "Show current weather")
        
        measure {
            button.tap()
            app.navigationBars.buttons.element(boundBy: 0).tap()
        }
    }
    
    func testWeatherForecastButtonClick() throws {
        let buttonIdentifier = "showWeatherForecast"
        
        let button = app.buttons[buttonIdentifier]
        XCTAssertTrue(button.exists)
        XCTAssertEqual(button.label, "Show weather forecast")
        button.tap()

        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
}
