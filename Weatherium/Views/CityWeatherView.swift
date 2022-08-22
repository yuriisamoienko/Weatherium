//
//  CityWeatherView.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import SwiftUI

struct CityWeatherView: View {
    
    let city: CityData
    
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    private var weather: WeatherData = WeatherData(weatherDescription: "", temperature: .invalid, icon: "")
    private var forecast: ForecastData = .init(list: [WeatherData]())
    
//    @ObservedObject private var weatherViewModel: WeatherViewModel = WeatherViewModel() // warning fixed in swift 5.7
    
    init(city: CityData, weatherViewModel: WeatherViewModel ) {
        self.city = city
        self.weatherViewModel = weatherViewModel
//        Task {
//            guard let weather = await self.weatherViewModel.citiesWeather[city] else {
//                return
//            }
//            self.weather = weather
//        }
    }
    
    var body: some View {
            VStack {
                let weather =  weatherViewModel.citiesWeather[city] ?? WeatherData(weatherDescription: "", temperature: .invalid, icon: "")
                let forecast: ForecastData = weatherViewModel.citiesForecast[city] ?? .init(list: [WeatherData]())
                let weatherIcon = try? NetworkEnpoint.weatherIcon(id: weather.icon).createEndpointUrl()
                
//                Text(city.name)
//                .font(.title)
//                    .frame(
//                        maxWidth: .infinity,
//                        alignment: .center
//                    )
                HStack {
                    GeometryReader { bodyGeometry in
                        AsyncImage(
                            url: weatherIcon,
                            content: { $0
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .background(Color.accentColor)
                            },
                            placeholder: {
                                ProgressView()
                                    .tint(.accentColor)
                                    .scaleEffect(1.3)
                            }
                        )
                        .cornerRadius(bodyGeometry.size.height/2)
                    }
                    .frame(
                        width: 50,
                        height: 50
                    )
                    
                    Spacer(minLength: 10)
                    
                    Text(weather.weatherDescription)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer(minLength: 10)
                    
                    // allign ':' and numbers to right and vertically
                    Group {
                        VStack(alignment: .trailing) {
                            HStack {
                                Text("H: ")
                            }
                            HStack {
                                Text("L: ")
                            }
                        }
                        VStack(alignment: .trailing) {
                            HStack {
                                Text("\(weather.temperature.high)")
                            }
                            HStack {
                                Text("\(weather.temperature.low)")
                            }
                        }
                    }
                    .font(.subheadline)
                    .if(weather.temperature.isInvalid(), content: { group in
                        group.hidden()
                })
                }
//                VStack(alignment: .center) {
//                }
                
                Spacer(minLength: 0)
    
            }
            .padding(10)
            .navigationBarTitle(city.name, displayMode: .large)
            
    }
    
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(
            city: CityData(id: 6173331, name: "Vancouver", country: nil),
            weatherViewModel: WeatherViewModel(citiesViewModel: CitiesViewModel()) //TODO @Inject
        )
    }
}
