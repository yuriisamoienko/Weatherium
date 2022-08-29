//
//  CityWeatherViewModel.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 29.08.2022.
//

import Foundation
import SwiftUI
import Combine

/*
Represents data of CityWeatherView
*/

@MainActor class CityWeatherViewModel: ObservableObject {
    
    // MARK: Public Properties
    
    let city: CityData
    
    @Published var weather: WeatherData = CityWeatherViewModel.emptyWeather()
    @Published var forecastDays5: [DayForecast] = []
    
    // MARK: Private Properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    @ObservedObject private var weatherViewModel: WeatherViewModel = DependenciesInjector.shared.resolve()
    
    // MARK: Public Functions
    
    init(city: CityData) {
        self.city = city
        subscribe()
    }
    
    func updateForecast() {
        weatherViewModel.updateForecastOf(city: city)
    }
    
    // MARK: Private Functions
    
    private func subscribe() {
        subscriptions = [
            weatherViewModel.$citiesWeather.sink(receiveValue: {  [weak self] (citiesWeather: CitiesWeathers) in
                guard let self = self else { return }
                let city = self.city
                let weatherViewModel = self.weatherViewModel
                
                self.weather = weatherViewModel.citiesWeather[city] ?? Self.emptyWeather()
                let forecast = weatherViewModel.citiesForecast[city] ?? Self.emptyForecast()
                self.forecastDays5 = self.get5DaysForecast(from: forecast)
            }),
        ]
    }
    
    private func get5DaysForecast(from forecast: ForecastData) -> [DayForecast] {
        var result: [DayForecast] = []
        let forecastList = forecast.list
        
        if forecastList.isEmpty == false {
            let today = Date()
            
            let sixthDayLocalMidnightTimestamp = today.byAdding(days: 6).withLocalTimeZone().timeIntervalSince1970
            let dictLocaldayWeathers = forecastList.reduce(into: [String: [WeatherData]]()) { partialResult, weather in
                let weatherTimestamp = weather.timestamp
                if sixthDayLocalMidnightTimestamp <= weatherTimestamp {
                    return // we don't need 6th day and further
                }
                let localDay = Date(timeIntervalSince1970: weatherTimestamp).toString(format: "EEEE")
                var weathersOfLocalDay = partialResult[localDay] ?? [WeatherData]()
                weathersOfLocalDay.append(weather)
                partialResult[localDay] = weathersOfLocalDay
            }
            
            let dayNamesOrderedList = Array(0..<5).map { today.byAdding(days: $0).toString(format: "EEEE") }
            
            for dayName in dayNamesOrderedList {
                guard let weathersOfLocalDay = dictLocaldayWeathers[dayName] else {
                    continue
                }
                result.append(DayForecast(day: dayName, list: weathersOfLocalDay))
            }
            
        }
        return result
    }
    
    private static func emptyWeather() -> WeatherData {
        WeatherData(weatherDescription: "", temperature: .invalid, icon: "", timestamp: -1)
    }
    
    private static func emptyForecast() -> ForecastData {
        .init(list: [WeatherData]())
    }
    
    // MARK: Types
    
    struct DayForecast {
        let day: String
        let list: [WeatherData]
    }
    
}
