//
//  WeatherViewModel.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation
import CoreLocation
import Combine

struct WeatherData {
    let weatherDescription: String
    let temperature: WeatherTemperature
    let icon: String
    
    static let invalid = WeatherData(weatherDescription: "", temperature: .invalid, icon: "")
}

@MainActor class WeatherViewModel: ObservableObject {

    private var citiesViewModel = CitiesViewModel()
    private var subscriptions = Set<AnyCancellable>()
//    private var citiesLocations: [CityLocationData] = []
    
    
    @Published var citiesWeather: [CityData: WeatherData] = [:]
    
    init() {
        
        subscriptions = [
            citiesViewModel.$cities.sink(receiveValue: { (cities: [CityData]) in
                Task {
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
                        guard let coordinate = coordinate
                        else {
                            return
                        }
                        let requestUrlString = "https://api.openweathermap.org/data/2.5/weather?appid=0cd74bf29e43ef1ad6afd6861cc99eb2&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
                        guard let request = URLRequest(url: URL(string: requestUrlString))
                        else {
                            print("failed create request from url: ", requestUrlString)
                            return
                        }
                        let data: Data
                        do {
                            (data, _) = try await URLSession.shared.data(for: request)
                        } catch {
                            print("url request: ", requestUrlString, "\nfailed with error:\n", requestUrlString)
                            return
                        }
                        
                        let weatherResponse: WeatherResponse
                        do {
                            weatherResponse = try WeatherResponse.decode(from: data)
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
//                        print("weatherResponse: \n", weatherInCity)
                        self.citiesWeather[city] = weatherInCity
                    }
                    
                }
            }),
        ]

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
