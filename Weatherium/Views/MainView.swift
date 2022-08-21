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
    
    init() {}
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< viewModel.cities.count, id: \.self) { index in
                    let city = viewModel.cities[index]
                    
                    CityListCellView(
                        name: city.name,
                        weatherDescription: "weather Description",
                        temperature: WeatherTemperature(high: 24, low: 11)
                    )
                        .frame(height: 50)
                }
            }
            .navigationTitle("Weather Application")
        }
        .navigationViewStyle(.stack) // fixes error "Unable to simultaneously satisfy constraints..."
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
