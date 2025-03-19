//
//  WeatherDataHelper.swift
//  WeatherApp
//
//  Created by Gagandeep
//

@preconcurrency import Combine
import NetworkServices
import Logging

/// Observable ViewModel weather forecast.
final class CurrentWeatherViewModel: ObservableObject, @unchecked Sendable {
    
    private let downloadStateSubject: CurrentValueSubject<WeatherDataDownloadState, Never> = .init(.notStarted)
    private let currentWeatherSubject = PassthroughSubject<CurrentWeatherModel?, Never>()

    private let locationManager: LocationProtocol
    private let repo: CurrentWeatherProtocol
    private var cancellables: Set<AnyCancellable> = []
    private let searchQuery: String?

    @Published var currentWeatherPublisher: CurrentWeatherModel?
    @Published var downloadStatePublisher: WeatherDataDownloadState = .notStarted

    init(
        searchQuery: String? = nil,
        repo: CurrentWeatherProtocol,
        locationManager: LocationProtocol = LocationManager()
    ) {
        self.searchQuery = searchQuery
        self.repo = repo
        self.locationManager = locationManager
        
        self.downloadStateSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.downloadStatePublisher = state
            }
            .store(in: &cancellables)
        
        self.currentWeatherSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] model in
                self?.currentWeatherPublisher = model
            })
            .store(in: &cancellables)
    }
    
    /// Method fetched current weather data. If there is some old data then same is returned.
    func getWeatherData() {
        self.downloadStateSubject.send(.inProgress)
        Task { [weak self] in
            guard let self else {
                Log.error("Instance deallocated")
                return
            }
            do {
                if let query = searchQuery {
                    let result = try await repo.weatherForecast(query: query)
                    self.currentWeatherSubject.send(result)
                    self.downloadStateSubject.send(.finished)
                } else {
                    self.locationManager.locationSubject
                        .sink { location in
                            self.fetchCurrentWeather(coordinate: location)
                        }
                        .store(in: &cancellables)
                    try await self.locationManager.startLocationUpdates()
                }
            } catch {
                Log.error("Error in fetching location: \(error)")
                self.downloadStateSubject.send(.error(message: "Error in fetching location."))
            }
        }
    }
    
    func reset() {
        // cancel previous request.
        cancellables.forEach {
            $0.cancel()
        }
        self.downloadStateSubject.send(.notStarted)
        currentWeatherSubject.send(nil)
    }

    private func fetchCurrentWeather(coordinate: LocationModel) {
        Task { @MainActor [weak self] in
            guard let self else {
                Log.error("Instance deallocated")
                return
            }
            do {
                let result = try await self.repo.currentWeather(coord: coordinate)
                self.downloadStateSubject.send(.finished)
                self.currentWeatherSubject.send(result)
            } catch {
                Log.error("Error in Fetching current Weather \(error)")
                self.downloadStateSubject.send(.error(message: "Error in fetching current weather."))
            }
        }
    }
}
