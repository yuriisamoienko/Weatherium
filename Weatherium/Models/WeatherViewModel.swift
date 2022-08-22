//
//  WeatherViewModel.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation
import CoreLocation
import Combine

@MainActor class WeatherViewModel: ObservableObject {
    
    @Published var citiesWeather: [CityData: WeatherData] = [:]
    @Published var citiesForecast: [CityData: ForecastData] = [:]

    // MARK: Private Properties
    
    private var citiesViewModel = CitiesViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private let networkRequestService: NetworkRequestServicePl = NetworkRequestService() //TODO @Injected
    
    private var citiesCoordinate: [CityData: CLLocationCoordinate2D] = [:]
    
    // MARK: Public Functions
    
    init() {
        
        subscriptions = [
            citiesViewModel.$cities.sink(receiveValue: { (cities: [CityData]) in
                Task {
                    await self.updateCitiesWeather(for: cities)
                }
            }),
        ]

    }
    
    // MARK: Private Functions
    
    private func updateCitiesWeather(for cities: [CityData]) async {
//        let myDict = [1,2,3].reduce(into: [Int: String]()) {
//            $0[$1.position] = $1.name
//        }
        
//        let weathers: [CityData: WeatherData] = await cities.reduce(into: [:]) { city, _ in
//
//        }
        for city in cities {
//            var coordinate: CLLocationCoordinate2D? = citiesCoordinate[city]
//            if coordinate == nil {
//                var address = city.name
//                if let country = city.country {
//                    address += ", \(country)"
//                }
//                address += " \(city.id)"
//                do {
//                    let placemarks: [CLPlacemark] = try await CLGeocoder().geocodeAddressString(address)
//                    coordinate = placemarks.first(where: { $0.location != nil })?.location?.coordinate
//                } catch {
//                    print("failed geocode address '\(address)' with error: \(error.localizedDescription)")
//                }
//            }
//            guard let coordinate = await self.getCoordinateOf(city: city) else {
//                continue
//            }
//
//            let weatherResponse: WeatherRequestResponse
//            do {
//                weatherResponse = try await self.networkRequestService.getDataFrom(
//                    endpoint: .weather(
//                        latitude: coordinate.latitude,
//                        longitude: coordinate.longitude
//                    )
//                )
//            } catch {
//                print("failed decode WeatherResponse with error:", error.localizedDescription)
//                return
//            }
//            let weatherInCity = WeatherData(
//                weatherDescription: weatherResponse.getDescription() ?? "",
//                temperature: WeatherTemperature(
//                    high: Int(weatherResponse.getMaxTemperature()),
//                    low: Int(weatherResponse.getMinTemperature())
//                ),
//                icon: weatherResponse.getIconKey() ?? ""
//            )
            let weatherInCity: WeatherData
            do {
                weatherInCity = try await self.getWeatherIn(city: city)
            } catch {
                print("failed decode WeatherResponse with error:", error.localizedDescription)
                continue
            }
            //print("weatherResponse: \n", weatherInCity) // uncomment for debugging
            self.citiesWeather[city] = weatherInCity
        }
    }
    
    private func getWeatherIn(city: CityData) async throws -> WeatherData {
        guard let coordinate = await self.getCoordinateOf(city: city) else {
            throw CError(message: "coordinates not found for city: \(city.name)")
        }
        
        let weatherResponse: WeatherRequestResponse
        weatherResponse = try await self.networkRequestService.getDataFrom(
            endpoint: .weather(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
        )
        let result = WeatherData(
            weatherDescription: weatherResponse.getDescription() ?? "",
            temperature: WeatherTemperature(
                high: Int(weatherResponse.getMaxTemperature()),
                low: Int(weatherResponse.getMinTemperature())
            ),
            icon: weatherResponse.getIconKey() ?? ""
        )
        return result
    }
    
    private func getCoordinateOf(city: CityData) async -> CLLocationCoordinate2D? {
        var coordinate: CLLocationCoordinate2D? = citiesCoordinate[city]
        if coordinate == nil {
            var address = city.name
            if let country = city.country {
                address += ", \(country)"
            }
            address += " \(city.id)"
            
            do {
                let placemarks: [CLPlacemark] = try await CLGeocoder().geocodeAddressString(address)
                coordinate = placemarks.first(where: { $0.location != nil })?.location?.coordinate
            } catch {
                print("failed geocode address '\(address)' with error: \(error.localizedDescription)")
            }
        }
        return coordinate
    }
}
