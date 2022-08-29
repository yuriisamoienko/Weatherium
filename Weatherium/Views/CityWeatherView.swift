//
//  CityWeatherView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import SwiftUI

struct CityWeatherView<ViewModel>: View where ViewModel: CityWeatherViewModelPl { // <ViewModel> so we can use property wrappers on protocol
    
    // MARK: Private Properties
    
    @ObservedObject private var viewModel: ViewModel
    
    // MARK: Public Properties
    
    var body: some View {
        let city = viewModel.city
        
        List {
            VStack {
                let weather = viewModel.weather
                let weatherIcon = weather.icon
                
                CityListCellView(
                    name: weather.weatherDescription,
                    weatherDescription: "",
                    temperature: WeatherTemperature(
                        high: weather.temperature.high,
                        low: weather.temperature.low
                    ),
                    iconId: weatherIcon
                )
                .frame(height: 50)
                
                Spacer(minLength: 30)
                
                let next5daysForecast = viewModel.forecastDays5
                
                ForEach(0 ..< next5daysForecast.count, id: \.self) { dayIndex in
                    let dayForecast: DayForecast = next5daysForecast[dayIndex]
                    
                    Text(dayForecast.day.capitalizingFirstLetter())
                        .font(.title3)
                    
                    // weather-time conditions of day above
                    ForEach(0 ..< dayForecast.list.count, id: \.self) { index in
                        let weather: WeatherData = dayForecast.list[index]
                        let weatherIcon = weather.icon
                        let timestamp = weather.timestamp
                        
                        CityListCellView(
                            name: Date(timeIntervalSince1970: Double(timestamp)).toString(format: "HH:mm"),
                            weatherDescription: weather.weatherDescription,
                            temperature: WeatherTemperature(
                                high: weather.temperature.high,
                                low: weather.temperature.low
                            ),
                            iconId: weatherIcon
                        )
                        .frame(height: 50)
                    }
                }
            }
            .padding(10)
        }
        .navigationBarTitle(city.name, displayMode: .large)
        .onAppear {
            viewModel.updateForecast()
        }
        .toolbar {
            TemperatureSwitcherButton()
        }
    }
    
    // MARK: Public Functions
    
    init(city: CityData, viewModel: ViewModel ) {
        // keep city data for future injection
        self.viewModel = viewModel
    }
    
    // MARK: Private Functions
    
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let city = CityData(id: 6173331, name: "Vancouver", country: "Canada")
        CityWeatherView(
            city: city,
            viewModel: CityWeatherViewModel(city: city)
        )
        .environmentObject(AppSettings())
    }
}
