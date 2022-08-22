//
//  CityWeatherView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import SwiftUI

struct CityWeatherView: View {
    
    // MARK: Private Properties
    
    @ObservedObject private var weatherViewModel: WeatherViewModel
    
    private let city: CityData
    private var weather: WeatherData = WeatherData(weatherDescription: "", temperature: .invalid, icon: "", timestamp: -1)
    private var forecast: ForecastData = .init(list: [WeatherData]())
    
    // MARK: Public Functions
    
    init(city: CityData, weatherViewModel: WeatherViewModel ) {
        self.city = city
        self.weatherViewModel = weatherViewModel
    }
    
    var body: some View {
        List {
            VStack {
                let weather =  weatherViewModel.citiesWeather[city] ?? WeatherData(weatherDescription: "", temperature: .invalid, icon: "", timestamp: -1)
                let forecast: ForecastData = weatherViewModel.citiesForecast[city] ?? .init(list: [WeatherData]())
                let weatherIcon = try? NetworkEnpoint.weatherIcon(id: weather.icon).createEndpointUrl()
                
                CityListCellView(
                    name: weather.weatherDescription,
                    weatherDescription: "",
                    temperature: WeatherTemperature(
                        high: weather.temperature.high,
                        low: weather.temperature.low
                    ),
                    iconUrl: weatherIcon
                )
                .frame(height: 50)
                
                Spacer(minLength: 30)
                
                
                
                let next5daysForecast = get5DaysForecast(from: forecast)
                
                
                ForEach(0 ..< next5daysForecast.count, id: \.self) { dayIndex in
                    let dayForecast: DayForecast = next5daysForecast[dayIndex]
                    
                    Text(dayForecast.day.capitalizingFirstLetter())
                        .font(.title3)
                    
                    // weather-time conditions of day above
                    ForEach(0 ..< dayForecast.list.count, id: \.self) { index in
                        let weather: WeatherData = dayForecast.list[index]
                        let weatherIcon = try? NetworkEnpoint.weatherIcon(id: weather.icon).createEndpointUrl()
                        let timestamp = weather.timestamp
                        
                        CityListCellView(
                            name: Date(timeIntervalSince1970: Double(timestamp)).toString(format: "HH:mm"),
                            weatherDescription: weather.weatherDescription,
                            temperature: WeatherTemperature(
                                high: weather.temperature.high,
                                low: weather.temperature.low
                            ),
                            iconUrl: weatherIcon
                        )
                        .frame(height: 50)
                    }
                }
            }
            .padding(10)
        }
        .navigationBarTitle(city.name, displayMode: .large)
        .onAppear {
            weatherViewModel.updateForecastOf(city: city)
        }
        
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
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(
            city: CityData(id: 6173331, name: "Vancouver", country: nil),
            weatherViewModel: WeatherViewModel(citiesViewModel: CitiesViewModel()) //TODO @Inject
        )
    }
}

fileprivate struct DayForecast {
    let day: String
    let list: [WeatherData]
}
