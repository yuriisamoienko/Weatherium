//
//  ContentView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

struct CitiesListView<ViewModel>: View where ViewModel: CitiesListViewModelPl { // <ViewModel> so we can use property wrappers on ObservableObject protocols
    
    // MARK: Public Properties
    
    @ObservedObject var viewModel: ViewModel
    
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
                    let filteredCities = viewModel.cities
                    ForEach(0 ..< viewModel.cities.count, id: \.self) { index in
                        let city = filteredCities[index]
                        let weather: WeatherData = viewModel.weathers[city] ?? .invalid
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
            .searchable(text: $viewModel.searchText)
            .toolbar {
                TemperatureSwitcherButton()
            }
            
        }
        .navigationViewStyle(.stack) // fixes error "Unable to simultaneously satisfy constraints..."
    }
    
    // MARK: Private Properties
    
    /* Navigation begin */
    @State private var showCityWeather = false
    @State private var selectedCity: CityData? = CityData(id: -1, name: "", country: nil) // fixes "no animation on first tap to weather details"
    
    @Inject
    private var router: NavigationRouter
    /* Navigation end */
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesListView(viewModel: CitiesListViewModel())
        .environmentObject(AppSettings())
    }
}
