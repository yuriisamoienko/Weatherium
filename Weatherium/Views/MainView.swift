//
//  ContentView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

struct MainView: View {
    
    // MARK: Public Properties
    
    var body: some View {
        NavigationView {
            ZStack {
                if let selectedCity = self.selectedCity {
                    router.navigationLink(
                        to: .weatherInCity(
                            selectedCity,
                            CityWeatherViewModel(city: selectedCity)
                        ),
                        isActive: $showCityWeather
                    ) // navigationLink doens't work if not located on the visible screen area
                }
                
                List {
                    let filteredCities = viewModel.cities.filter {
                        searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
                    }
                    ForEach(0 ..< filteredCities.count, id: \.self) { index in
                        let city = filteredCities[index]
                        let weather: WeatherData = weatherViewModel.citiesWeather[city] ?? .invalid
                        let weatherIcon = weather.icon
                        
                        CityListCellView(
                            name: city.name,
                            weatherDescription: weather.weatherDescription,
                            temperature: WeatherTemperature(
                                high: weather.temperature.high,
                                low: weather.temperature.low
                            ),
                            iconId: weatherIcon
                        )
                        .frame(height: 50)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedCity = city
                            showCityWeather = true
                        }
                    }
                    
                    Spacer(minLength: 0)
                }
                .navigationBarTitle("Weather Application", displayMode: .large)
                .navigationBarColor(background: .accentColor)
                .navigationBarColor(tint: .white)
                .navigationBarColor(text: .white)
            }
            .searchable(text: $searchText)
            .toolbar {
                TemperatureSwitcherButton()
            }
            
        }
        .navigationViewStyle(.stack) // fixes error "Unable to simultaneously satisfy constraints..."
    }
    
    // MARK: Private Properties
    
    @State private var showCityWeather = false
    @State private var selectedCity: CityData? = CityData(id: -1, name: "", country: nil) // fixes "no animation on first tap to weather details"
    @State private var searchText = ""
    
    @ObservedObject private var viewModel: CitiesViewModel = DependenciesInjector.shared.resolve()
    @ObservedObject private var weatherViewModel: WeatherViewModel = DependenciesInjector.shared.resolve()
    
    @Inject
    private var router: NavigationRouter
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        .environmentObject(AppSettings())
    }
}
