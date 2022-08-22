//
//  WeatherResponse.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

struct WeatherRequestResponse: EasyCodable {
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
