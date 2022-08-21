//
//  ContentView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel: CitiesViewModel = CitiesViewModel() // warning fixed in swift 5.7
    @ObservedObject private var weatherViewModel: WeatherViewModel = WeatherViewModel() // warning fixed in swift 5.7
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< viewModel.cities.count, id: \.self) { index in
                    let city = viewModel.cities[index]
                    let weather = weatherViewModel.citiesWeather[city] ?? .invalid
                    let weatherIcon = URL(string: "https://openweathermap.org/img/wn/\(weather.icon)@2x.png")
                    
                    CityListCellView(
                        name: city.name,
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
            .navigationTitle("Weather Application")
            .navigationBarColor(background: .accentColor)
        }
        .navigationViewStyle(.stack) // fixes error "Unable to simultaneously satisfy constraints..."
//        .background(Color.accentColor)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
