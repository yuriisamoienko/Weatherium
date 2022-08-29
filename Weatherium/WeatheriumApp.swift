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
            CitiesListView()
            .environmentObject(AppSettings())
        }
    }
    
    // MARK: Private Properties
    
    private let dependencyInjector = DependenciesInjector.shared
    
    // MARK: Public Functions
    
    init() {
        dependencyInjector.inject()
    }
    
}
