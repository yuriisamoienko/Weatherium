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

    // MARK: Private Properties
    
    private var citiesViewModel = CitiesViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private let networkRequestService: NetworkRequestServicePl = NetworkRequestService() //TODO @Injected
    
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
        for city in cities {
            var coordinate: CLLocationCoordinate2D?
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
            guard let coordinate = coordinate else {
                return
            }
            
            let weatherResponse: WeatherRequestResponse
            do {
                weatherResponse = try await self.networkRequestService.getDataFrom(
                    endpoint: .weather(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude
                    )
                )
            } catch {
                print("failed decode WeatherResponse with error:", error.localizedDescription)
                return
            }
            let weatherInCity = WeatherData(
                weatherDescription: weatherResponse.getDescription() ?? "",
                temperature: WeatherTemperature(
                    high: Int(weatherResponse.getMaxTemperature()),
                    low: Int(weatherResponse.getMinTemperature())
                ),
                icon: weatherResponse.getIconKey() ?? ""
            )
            //print("weatherResponse: \n", weatherInCity) // uncomment for debugging
            self.citiesWeather[city] = weatherInCity
        }
    }
    
    private func getWeather(for coorditante: CLLocationCoordinate2D) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            let onError: (String) -> Void = { message in
                continuation.resume(throwing: CError(message: message))
            }
            continuation.resume(returning: 0)
        }
    }
    
}
