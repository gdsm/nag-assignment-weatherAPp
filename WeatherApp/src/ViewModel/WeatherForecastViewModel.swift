//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Combine
import NetworkServices
import Logging

/// Observable ViewModel weather forecast.
final class WeatherForecastViewModel: ObservableObject, @unchecked Sendable {
    
    private let downloadStateSubject: CurrentValueSubject<WeatherDataDownloadState, Never> = .init(.notStarted)
    private let forecastSubject = PassthroughSubject<WeatherForecastModel?, Never>()

    @Published var forecastPublisher: WeatherForecastModel?
    @Published var downloadStatePublisher: WeatherDataDownloadState = .notStarted
    private var cancellables: Set<AnyCancellable> = []

    private let locationManager: LocationProtocol
    private let repo: WeatherForecastProtocol

    init(
        locationManager: LocationProtocol = LocationManager(),
        repo: WeatherForecastProtocol
    ) {
        self.locationManager = locationManager
        self.repo = repo
        
        self.downloadStateSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.downloadStatePublisher = state
            }
            .store(in: &cancellables)
        
        self.forecastSubject
            .receive(on: DispatchQueue.main)
            .sink { model in
                self.forecastPublisher = model
            }
            .store(in: &cancellables)
    }
    
    /// Method fetched weather forecast data. Forecast is for 3 hours frequency for 5 days.
    func getWeatherData() {
        self.downloadStateSubject.send(.inProgress)
        Task { [weak self] in
            guard let self else {
                Log.error("Instance deallocated")
                return
            }
            do {
                self.locationManager.locationSubject.sink { location in
                    self.fetchWeatherForecast(coordinate: location)
                }
                .store(in: &cancellables)
                try await self.locationManager.startLocationUpdates()
            } catch {
                Log.error("Error in fetching data: \(error)")
                self.downloadStateSubject.send(.finished)
            }
        }
    }
    
    func reset() {
        // cancel previous request.
        cancellables.forEach {
            $0.cancel()
        }
        self.downloadStateSubject.send(.notStarted)
        forecastSubject.send(nil)
    }
    
    private func fetchWeatherForecast(coordinate: LocationModel) {
        Task { [weak self] in
            guard let self else {
                Log.error("Instance deallocated")
                return
            }
            do {
                let result = try await repo.weatherForecast(coord: coordinate)
                self.downloadStateSubject.send(.finished)
                self.forecastSubject.send(result)
            } catch {
                Log.error("Error in Fetching Weather \(error)")
                self.downloadStateSubject.send(.error(message: "Error in fetching weather."))
            }
        }
    }
}
