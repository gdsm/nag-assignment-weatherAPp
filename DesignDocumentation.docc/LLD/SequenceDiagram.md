### Current weather sequence diagram

<div hidden>

@startuml
title 'Sequence Diagram'
skin rose
skinparam sequenceMessageAlign right

autonumber

box "View Layer" #LightBlue
participant AppView
participant CurrentWeatherView
endbox

box "ViewModel Layer" #Lavender
participant CurrentWeatherViewModel
endbox

box "Repos" #AliceBlue
participant WeatherDataRepo
endbox

box "Helpers" #Ivory
participant LocationManager
participant NetworkServices
endbox

box "iOS APIs" #DarkGray
participant CLLocationManager
participant Geocoder
endbox


AppView -> CurrentWeatherView : Get Current Weather
CurrentWeatherView -> CurrentWeatherViewModel : getWeatherData
CurrentWeatherViewModel -> LocationManager: getCurrentLocation
LocationManager -> CLLocationManager: check Location Permission and get Current Location.
CLLocationManager -> LocationManager: onResponse(CLLocation)
LocationManager -> Geocoder : getAddress(CLLocationCoordinates)
Geocoder -> LocationManager : onResponse(CLLocation)
LocationManager -> CurrentWeatherViewModel : Future<LocationModel, LocationError>
CurrentWeatherViewModel -> WeatherDataRepo: getCurrentWeather(LocationModel)
WeatherDataRepo -> NetworkServices : response<T:Codable>(urlRequest)
NetworkServices -> WeatherDataRepo : Result<CurrentWeatherModel, ServiceError>
WeatherDataRepo -> CurrentWeatherViewModel : Result<CurrentWeatherModel, ServiceError>
CurrentWeatherViewModel -> CurrentWeatherView : Publish on currentWeather
@enduml


</div>

