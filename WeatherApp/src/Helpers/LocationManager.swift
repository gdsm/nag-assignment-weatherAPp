//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation
import Combine
import CoreLocation
import Logging
import UIKit

enum LocationError: Error {
    case generic
    case locationUnavilable
    case permissionRequired
    case failedToGeocode
}

protocol LocationProtocol: Sendable {
    var locationSubject: PassthroughSubject<LocationModel, Never> {get}
    func startLocationUpdates() async throws
}

///  Object to get device location related queries.
final class LocationManager: NSObject, LocationProtocol, @unchecked Sendable {
    
    let locationSubject = PassthroughSubject<LocationModel, Never>()
    private let locationManager = CLLocationManager()
    private let testLocation = LocationModel(lat: 28.65, lon: 77.10)
    
    
    private var locationStream: AsyncStream<LocationModel>?
    private var locationStreamContinuation: AsyncStream<LocationModel>.Continuation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationStream = AsyncStream { [weak self] continuation in
            self?.locationStreamContinuation = continuation
        }
    }
    
    func startLocationUpdates() async throws {
        if await UIDevice.isSimulator {
            let address = try await self.addressFromCoordinates(coordinates: self.testLocation)
            testLocation.update(address: address)
            locationSubject.send(testLocation)
        } else {
            if self.checkAuthorisationStatus() {
                self.locationManager.startUpdatingLocation()
            } else {
                Log.error("Unauthorised to access location.")
            }
        }
    }
    
    private func addressFromCoordinates(coordinates: LocationModel) async throws -> Address {
        let location = CLLocation(latitude: coordinates.lat, longitude: coordinates.lon)
        let geocoder = CLGeocoder()
        
        let geocode = try await geocoder.reverseGeocodeLocation(location)
        guard let placemark = geocode.first else {
            Log.warn("Failed to find placemark")
            throw LocationError.failedToGeocode
        }
        return Address(state: placemark.locality, country: placemark.country)
    }
    
    private func checkAuthorisationStatus() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse, .restricted:
            return true
        case .denied:
            return false
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            return true
        @unknown default:
            Log.warn("Unknown location status.")
            self.locationManager.requestWhenInUseAuthorization()
            return true
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { [weak self] in
            if let coord = locations.last?.coordinate {
                let model = LocationModel(lat: coord.latitude.magnitude, lon: coord.longitude.magnitude)
                if let address = try? await self?.addressFromCoordinates(coordinates: model) {
                    model.update(address: address)
                    self?.locationSubject.send(model)
                } else {
                    Log.error("Error in pasring address from location.")
                }
            }
        }
    }
}
