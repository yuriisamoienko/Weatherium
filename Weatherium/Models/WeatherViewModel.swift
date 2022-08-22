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
    
    private var citiesViewModel = CitiesViewModel() // warning fixed in swift 5.7
    private var subscriptions = Set<AnyCancellable>()
    private let networkRequestService: NetworkRequestServicePl = NetworkRequestService() //TODO @Injected
    
    
    // MARK: Public Functions
    
    init() {
        
        subscriptions = [
            citiesViewModel.$cities.sink(receiveValue: { (cities: [CityData]) in
                self.updateCitiesWeather(for: cities)
//                Task {
//                    guard let city = cities.first else {
//                        return
//                    }
//                    let test = try? await self.getForecastOf(city: city)
//                    print(test)
//                }
            }),
        ]
       
    }
    
    func getForecastOf(city: CityData) async throws -> ForecastData {
        guard let coordinate = await citiesViewModel.getCoordinateOf(city: city) else {
            throw CError(message: "coordinates not found for city: \(city.name)")
        }
        
        let forecastResponse: ForecastRequestResponse
        forecastResponse = try await self.networkRequestService.getDataFrom(
            endpoint: .forecast(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
        )
        let result = ForecastData(list: forecastResponse.list.map { weather in
            WeatherData(
               weatherDescription: weather.getDescription() ?? "",
               temperature: WeatherTemperature(
                   high: Int(weather.getMaxTemperature()),
                   low: Int(weather.getMinTemperature())
               ),
               icon: weather.getIconKey() ?? ""
           )
        })
        return result
    }
    
    // MARK: Private Functions
    
    private func updateCitiesWeather(for cities: [CityData]) {
        for city in cities {
            Task {
                let weatherInCity: WeatherData
                do {
                    weatherInCity = try await self.getWeatherIn(city: city)
                } catch {
                    print("failed decode WeatherResponse with error:", error.localizedDescription)
                    return
                }
                //print("weatherResponse: \n", weatherInCity) // uncomment for debugging
                self.citiesWeather[city] = weatherInCity
            }
        }
    }
    
    private func getWeatherIn(city: CityData) async throws -> WeatherData {
        guard let coordinate = await citiesViewModel.getCoordinateOf(city: city) else {
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
}
