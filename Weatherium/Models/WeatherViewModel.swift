//
//  WeatherViewModel.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation
import CoreLocation
import Combine

struct WeatherData {
    let weatherDescription: String
    let temperature: WeatherTemperature
    let icon: String
    
    static let invalid = WeatherData(weatherDescription: "", temperature: .invalid, icon: "")
}

@MainActor class WeatherViewModel: ObservableObject {

    private var citiesViewModel = CitiesViewModel()
    private var subscriptions = Set<AnyCancellable>()
//    private var citiesLocations: [CityLocationData] = []
    
    
    @Published var citiesWeather: [CityData: WeatherData] = [:]
    
    init() {
        
        subscriptions = [
            citiesViewModel.$cities.sink(receiveValue: { (cities: [CityData]) in
                Task {
                    for city in cities {
                        var coordinate: CLLocationCoordinate2D?
                        var address = city.name
                        if let country = city.country {
                            address += ", \(country)"
                        }
                        address += " \(city.id)"
                        do {
                            let placemarks: [CLPlacemark] = try await CLGeocoder().geocodeAddressString(address)
                            coordinate = placemarks.first(where: { $0.location != nil })?.location?.coordinate
                        } catch {
                            print("failed geocode address '\(address)' with error: \(error.localizedDescription)")
                        }
                        guard let coordinate = coordinate
                        else {
                            return
                        }
                        let requestUrlString = "https://api.openweathermap.org/data/2.5/weather?appid=0cd74bf29e43ef1ad6afd6861cc99eb2&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
                        guard let request = URLRequest(url: URL(string: requestUrlString))
                        else {
                            print("failed create request from url: ", requestUrlString)
                            return
                        }
                        let data: Data
                        do {
                            (data, _) = try await URLSession.shared.data(for: request)
                        } catch {
                            print("url request: ", requestUrlString, "\nfailed with error:\n", requestUrlString)
                            return
                        }
                        
                        let weatherResponse: WeatherResponse
                        do {
                            weatherResponse = try WeatherResponse.decode(from: data)
                        } catch {
                            print("failed decode WeatherResponse with error:", error.localizedDescription)
                            return
                        }
                        let weatherInCity = WeatherData(
                            weatherDescription: weatherResponse.getDescription() ?? "",
                            temperature: WeatherTemperature(
                                high: Int(weatherResponse.getMaxTemperature()),
                                low: Int(weatherResponse.getMinTemperature())
                            ),
                            icon: weatherResponse.getIconKey() ?? ""
                        )
//                        print("weatherResponse: \n", weatherInCity)
                        self.citiesWeather[city] = weatherInCity
                    }
                    
                }
            }),
        ]

    }
    
    private func getWeather(for coorditante: CLLocationCoordinate2D) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            let onError: (String) -> Void = { message in
                continuation.resume(throwing: CError(message: message))
            }
            continuation.resume(returning: 0)
        }
    }
    
}


struct WeatherResponse: EasyCodable {
    struct WeatherInfo: EasyCodable {
        let description: String
        let icon: String
        
        init() {
            description = ""
            icon = ""
        }
    }
    struct MainInfo: EasyCodable {
        let temp_min: Double
        let temp_max: Double
        
        init() {
            temp_max = 0
            temp_min = 0
        }
    }
    let weather: [WeatherInfo]
    let main: MainInfo
    
    init() {
        weather = []
        main = MainInfo()
    }

    func getDescription() -> String? {
        let result = weather.first?.description
        return result
    }
    
    func getIconKey() -> String? {
        let result = weather.first?.icon
        return result
    }
    
    func getMinTemperature() -> Double {
        let result = main.temp_min
        return result
    }
    
    func getMaxTemperature() -> Double {
        let result = main.temp_max
        return result
    }
}

/*
 https://api.openweathermap.org/data/2.5/weather?appid=0cd74bf29e43ef1ad6afd6861cc99eb2&lat=49.237952&lon=28.411444
 sample response
 {
     "coord": {
         "lon": 28.4114,
         "lat": 49.238
     },
     "weather": [
         {
             "id": 802,
             "main": "Clouds",
             "description": "scattered clouds",
             "icon": "03d"
         }
     ],
     "base": "stations",
     "main": {
         "temp": 295.69,
         "feels_like": 295.38,
         "temp_min": 295.69,
         "temp_max": 295.69,
         "pressure": 1011,
         "humidity": 53,
         "sea_level": 1011,
         "grnd_level": 978
     },
     "visibility": 10000,
     "wind": {
         "speed": 4.21,
         "deg": 36,
         "gust": 7.42
     },
     "clouds": {
         "all": 29
     },
     "dt": 1661013827,
     "sys": {
         "country": "UA",
         "sunrise": 1660964701,
         "sunset": 1661015697
     },
     "timezone": 10800,
     "id": 689558,
     "name": "Vinnytsia",
     "cod": 200
 }
 */
