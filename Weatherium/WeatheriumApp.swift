//
//  WeatheriumApp.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

@main
struct WeatheriumApp: App {
    var body: some Scene {
        WindowGroup {
            let cityViewModel = CitiesViewModel()  //TODO @Inject
            MainView(
                viewModel: cityViewModel, //TODO @Inject
                weatherViewModel: WeatherViewModel(citiesViewModel: cityViewModel) //TODO @Inject
            )
//            CityWeatherView(
//                city: CityData(id: 6173331, name: "Vancouver", country: nil)
//                )
        }
    }
}
