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
    
    // MARK: Public Properties
    
    @Published var citiesWeather: CitiesWeathers = [:]
    @Published var citiesForecast: CitiesForecasts = [:]
    
    // MARK: Private Properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Inject private var citiesViewModel: CitiesViewModel
    @Inject private var networkRequestService: NetworkRequestServicePl
    
    // MARK: Public Functions
    
    init() {
        subscriptions = [
            citiesViewModel.$cities.sink(receiveValue: { (cities: [CityData]) in
                self.updateCitiesWeather(for: cities)
            }),
        ]
       
    }
    
    func updateForecastOf(city: CityData) {
        Task {
            self.citiesForecast[city] = try? await getForecastOf(city: city)
        }
    }
    
    // MARK: Private Functions
    
    private func getForecastOf(city: CityData) async throws -> ForecastData {
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
        let result = ForecastData(
            list: forecastResponse.list.map { weather in
                WeatherData(
                    weatherDescription: weather.getDescription() ?? "",
                    temperature: WeatherTemperature(
                        high: Int(weather.getMaxTemperature()),
                        low: Int(weather.getMinTemperature())
                    ),
                    icon: weather.getIconKey() ?? "",
                    timestamp: weather.getTimestamp()
                )
            }
        )
        return result
    }
    
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
            icon: weatherResponse.getIconKey() ?? "",
            timestamp: weatherResponse.getTimestamp()
        )
        return result
    }
    
}
