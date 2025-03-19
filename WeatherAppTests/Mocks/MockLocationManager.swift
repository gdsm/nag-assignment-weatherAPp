//
//  MockLocationManager.swift
//  WeatherAppTests
//
//  Created by Gagandeep
//

@preconcurrency import Combine
import Foundation
@testable import WeatherApp

struct MockLocationManager: LocationProtocol {
    let coordinate: LocationModel
    let locationSubject = PassthroughSubject<LocationModel, Never>()

    func startLocationUpdates() async throws {
        Task {
            try await Task.sleep(nanoseconds: 1_000_000)
            locationSubject.send(coordinate)
        }
    }

    func getCurrentLocation() -> Future<LocationModel, LocationError> {
        return Future() { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                promise(Result.success(coordinate))
            }
        }
    }
}
