//
//  CitiesListViewModel.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 29.08.2022.
//

import Foundation
import SwiftUI
import Combine

/*
    CitiesListViewModel represents data of CitiesListViev
 */

protocol CitiesListViewModelPl: ObservableObject {
    
    var searchText: String { get set }
    var cities: [CityData] { get }
    var weathers: CitiesWeathers { get }
    
}

class CitiesListViewModel: CitiesListViewModelPl {
    
    // MARK: Public Properties
    
    @Published var searchText = ""
    @Published var cities: [CityData] = []
    @Published var weathers: CitiesWeathers = [:]
    
    // MARK: Private Properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    @ObservedObject private var citiesViewModel: CitiesViewModel = DependenciesInjector.shared.resolve()
    @ObservedObject private var weatherViewModel: WeatherViewModel = DependenciesInjector.shared.resolve()
    
    // MARK: Public Functions
    
    init() {
        subscribe()
    }
    
    // MARK: Private Functions
    
    private func subscribe() {
        subscriptions = [
            Publishers.CombineLatest(citiesViewModel.$cities, $searchText).sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                let cities: [CityData] = value.0
                let searchText = value.1
                self.cities = cities.filter {
                    searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
                }
            }),
        ]
        weatherViewModel.$citiesWeather.assign(to: &$weathers) // bind $weathers to weatherViewModel.citiesWeather
    }
    
}
