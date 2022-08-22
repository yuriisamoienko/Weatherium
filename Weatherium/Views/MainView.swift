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
    
    @State private var showCityWeather = false
    @State private var selectedCity: CityData? = CityData(id: -1, name: "", country: nil) // fixes "no animation on first tap to weather details"
    
    private let router = NavigationRouter() //TODO protocol and @Injected
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if let selectedCity = self.selectedCity {
                    router.navigationLink(to: .weatherInCity(selectedCity), isActive: $showCityWeather) // navigationLink doens't work if not located on the visible screen area
                }
                
                List {
                    ForEach(0 ..< viewModel.cities.count, id: \.self) { index in
                        let city = viewModel.cities[index]
                        let weather: WeatherData = weatherViewModel.citiesWeather[city] ?? .invalid
                        let weatherIcon = try? NetworkEnpoint.weatherIcon(id: weather.icon).createEndpointUrl()
                        
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
                        .onTapGesture {
                            selectedCity = city
                            showCityWeather = true
                        }
                    }
                }
                .navigationBarTitle("Weather Application", displayMode: .large)
                .navigationBarColor(background: .accentColor)
                .navigationBarColor(tint: .white)
                .navigationBarColor(text: .white)
            }
            .navigationViewStyle(.stack) // fixes error "Unable to simultaneously satisfy constraints..."
        }
//        .accentColor(.accentColor) //  Color(uiColor: .lightText))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
