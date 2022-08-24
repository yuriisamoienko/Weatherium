//
//  WeatheriumApp.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import SwiftUI

@main
struct WeatheriumApp: App {
    
    // MARK: Public Properties
    
    var body: some Scene {
        WindowGroup {
            let cityViewModel = CitiesViewModel()  //TODO @Inject
            MainView(
                viewModel: cityViewModel, //TODO @Inject
                weatherViewModel: WeatherViewModel(citiesViewModel: cityViewModel) //TODO @Inject
            )
            .environmentObject(AppSettings())
        }
    }
    
}
