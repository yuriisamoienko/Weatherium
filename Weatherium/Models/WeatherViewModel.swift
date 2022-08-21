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
}

//struct CityLocationData {
//    let city: CityData
//    let coordinate: CLLocationCoordinate2D?
//}

@MainActor class WeatherViewModel: ObservableObject {

//    @ObservedObject
    private var citiesViewModel = CitiesViewModel()
    private var subscriptions = Set<AnyCancellable>()
//    private var citiesLocations: [CityLocationData] = []
    
    var citiesWeather: [CityData: WeatherData] = [:]
    
//    @Published var citiesWeather
    
    init() {
//        citiesViewModel.cities.sy
        
        subscriptions = [
            citiesViewModel.$cities.sink(receiveValue: { (cities: [CityData]) in
                Task {
//                    self.citiesLocations = await cities.asyncMap { city in
//                    for await city in cities {
                    await cities.asyncForEach { city in
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
//                        guard let url = URL(string: requestUrlString)
//                        else {
//                            print("failed create url from: ", requestUrlString)
//                            return
//                        }
                        let data: Data
                        let response: URLResponse
                        do {
                            (data, response) = try await URLSession.shared.data(for: request)
                        } catch {
                            print("url request: ", requestUrlString, "\nfailed with error:\n", requestUrlString)
                            return
                        }
                        
//                        guard
//                            let test = [String: Any](fromJsonData: data),
//                              let weatherResponse = try? WeatherResponse(from: test)
                        let weatherResponse: WeatherResponse
                        do {
                            weatherResponse = try WeatherResponse.decode(from: data)
                        } catch {
                            print("failed decode WeatherResponse with error:", error.localizedDescription)
                            return
                        }
                        print("weatherResponse: \n", weatherResponse)
//                        if let coord = coordinate {
//                            print(city.name)
//                            print("\(coord.latitude),\(coord.longitude)")
//                        }
//                        let cityLocation = CityLocationData(city: city, coordinate: coordinate)
//                        return cityLocation
                    }
                    
                }
            }),
        ]
        
        
//        Task {
//            do {
//                _ = try await loadWeather()
//            } catch {
//                print("init cities failed with error \(error)")
//            }
//        }
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
    /*
    let description: String
    let icon: String
    let temp_min: Double
    let temp_max: Double
    
//    init(from data: Data) throws {
//        self = try JSONDecoder().decode(WeatherResponse.self, from: data)
//    }
    init(from dict: AnyDictionary) throws {
        /*
         It seems to better make type which easycodeable to the api response.
         But - manual json parsing of request responses is protected from the future api response additional value updates.
         */
        guard let main = dict["main"] as? [String: Any],
              let weather = dict["weather"] as? [String: Any],
              let description = weather["description"] as? String,
              let icon = weather["icon"] as? String,
              let temp_min = main["temp_min"] as? Double,
              let temp_max = main["temp_max"] as? Double
        else {
            throw CError(message: "invalid json: \(dict)")
        }
        self.description = description
        self.icon = icon
        self.temp_min = temp_min
        self.temp_max = temp_max
    }
     */
}

/*
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
