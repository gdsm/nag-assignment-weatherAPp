### Class Diagram

<div hidden>
@startuml
title 'Class Diagram'
skin rose
skinparam sequenceMessageAlign right



class CurrentWeatherView {
 + @ObservedObject viewModel: CurrentWeatherViewModel
}

enum WeatherDataDownloadState {
    notStarted
    inProgress
    finished
    permissionError
    error(message: String)
}

class CurrentWeatherViewModel {
    + init(CurrentWeatherProtocol,LocationProtocol)
===
    + @Published currentWeather: CurrentWeatherModel?
    + @Published downloadState: WeatherDataDownloadState = .notStarted
===
    - currentLocationCancellable: Cancellable?
    - locationManager: LocationProtocol
    - repo: CurrentWeatherProtocol
===
    + getWeatherData()
===
    - fetchCurrentWeather(coordinate: LocationModel)
}




interface BaseRepo {
    + urlBuilder: URLBuilder { get }
    + networkInterface: NetworkProtocol { get }
}

interface CurrentWeatherProtocol {
    + getCurrentWeather(coord: LocationModel) async throws -> Result<CurrentWeatherModel, ServiceError>
}

interface WeatherForecastProtocol {
    + getWeatherForecast(coord: LocationModel) async throws -> Result<WeatherForecastModel, ServiceError>
}


class WeatherDataRepo {
    # buildUrl(coord: LocationModel, secondaryUrl: String) -> URL?
}

class WeatherDataRepoFactory {
    + {static} getWeatherDataRepo() -> WeatherDataRepo
}

WeatherForecastProtocol <|.. WeatherDataRepo
CurrentWeatherProtocol <|.. WeatherDataRepo
BaseRepo <|.. WeatherDataRepo




interface LocationProtocol {
    getCurrentLocation() -> Future<LocationModel, LocationError>
}

class LocationManager {
    - locationManager: CLLocationManager
    - locationCallback: ((LocationModel?) -> Void)?
===
    - fetchAddressFromCoordinates(LocationModel, @escaping ((LocationModel) -> Void))
    - checkAuthorisationStatus() -> Bool
}

LocationProtocol <|.. LocationManager




interface URLBuilder {
    + getBaseUrl() -> String
-- encrypted --
    + getAppId() -> String
}

enum URLEnvironment {
    prod
    qa
    dev
}

URLBuilder <|-- URLEnvironment


@enduml
</div>

