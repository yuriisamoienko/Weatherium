//
//  WeatherForecastRequestResponse.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

struct ForecastRequestResponse: EasyCodable {
    let list: [WeatherRequestResponse]
    
    init() {
        self.list = []
    }
}

/*
 https://api.openweathermap.org/data/2.5/forecast?appid=0cd74bf29e43ef1ad6afd6861cc99eb2&lat=49.237952&lon=28.411444
 response sample:
 {
     "cod": "200",
     "message": 0,
     "cnt": 40,
     "list": [
         {
             "dt": 1661094000,
             "main": {
                 "temp": 299.34,
                 "feels_like": 299.34,
                 "temp_min": 299.34,
                 "temp_max": 299.34,
                 "pressure": 1009,
                 "sea_level": 1009,
                 "grnd_level": 976,
                 "humidity": 46,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 94
             },
             "wind": {
                 "speed": 2.1,
                 "deg": 71,
                 "gust": 3.38
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-21 15:00:00"
         },
         {
             "dt": 1661104800,
             "main": {
                 "temp": 297.89,
                 "feels_like": 297.75,
                 "temp_min": 294.98,
                 "temp_max": 297.89,
                 "pressure": 1009,
                 "sea_level": 1009,
                 "grnd_level": 976,
                 "humidity": 51,
                 "temp_kf": 2.91
             },
             "weather": [
                 {
                     "id": 803,
                     "main": "Clouds",
                     "description": "broken clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 80
             },
             "wind": {
                 "speed": 3.71,
                 "deg": 58,
                 "gust": 7.25
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-21 18:00:00"
         },
         {
             "dt": 1661115600,
             "main": {
                 "temp": 294.67,
                 "feels_like": 294.6,
                 "temp_min": 292.34,
                 "temp_max": 294.67,
                 "pressure": 1010,
                 "sea_level": 1010,
                 "grnd_level": 976,
                 "humidity": 66,
                 "temp_kf": 2.33
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03n"
                 }
             ],
             "clouds": {
                 "all": 32
             },
             "wind": {
                 "speed": 3.13,
                 "deg": 93,
                 "gust": 7.43
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-21 21:00:00"
         },
         {
             "dt": 1661126400,
             "main": {
                 "temp": 292.7,
                 "feels_like": 292.49,
                 "temp_min": 292.7,
                 "temp_max": 292.7,
                 "pressure": 1009,
                 "sea_level": 1009,
                 "grnd_level": 976,
                 "humidity": 68,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03n"
                 }
             ],
             "clouds": {
                 "all": 26
             },
             "wind": {
                 "speed": 2.71,
                 "deg": 121,
                 "gust": 5.26
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-22 00:00:00"
         },
         {
             "dt": 1661137200,
             "main": {
                 "temp": 292.26,
                 "feels_like": 292.11,
                 "temp_min": 292.26,
                 "temp_max": 292.26,
                 "pressure": 1010,
                 "sea_level": 1010,
                 "grnd_level": 976,
                 "humidity": 72,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 803,
                     "main": "Clouds",
                     "description": "broken clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 56
             },
             "wind": {
                 "speed": 1.93,
                 "deg": 115,
                 "gust": 2.81
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-22 03:00:00"
         },
         {
             "dt": 1661148000,
             "main": {
                 "temp": 297.12,
                 "feels_like": 297.06,
                 "temp_min": 297.12,
                 "temp_max": 297.12,
                 "pressure": 1010,
                 "sea_level": 1010,
                 "grnd_level": 977,
                 "humidity": 57,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03d"
                 }
             ],
             "clouds": {
                 "all": 41
             },
             "wind": {
                 "speed": 2.59,
                 "deg": 89,
                 "gust": 3.71
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-22 06:00:00"
         },
         {
             "dt": 1661158800,
             "main": {
                 "temp": 302.5,
                 "feels_like": 302.02,
                 "temp_min": 302.5,
                 "temp_max": 302.5,
                 "pressure": 1010,
                 "sea_level": 1010,
                 "grnd_level": 978,
                 "humidity": 39,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 800,
                     "main": "Clear",
                     "description": "clear sky",
                     "icon": "01d"
                 }
             ],
             "clouds": {
                 "all": 5
             },
             "wind": {
                 "speed": 3.84,
                 "deg": 88,
                 "gust": 4.59
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-22 09:00:00"
         },
         {
             "dt": 1661169600,
             "main": {
                 "temp": 302.65,
                 "feels_like": 302.18,
                 "temp_min": 302.65,
                 "temp_max": 302.65,
                 "pressure": 1010,
                 "sea_level": 1010,
                 "grnd_level": 977,
                 "humidity": 39,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 801,
                     "main": "Clouds",
                     "description": "few clouds",
                     "icon": "02d"
                 }
             ],
             "clouds": {
                 "all": 22
             },
             "wind": {
                 "speed": 3.5,
                 "deg": 94,
                 "gust": 4.68
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-22 12:00:00"
         },
         {
             "dt": 1661180400,
             "main": {
                 "temp": 303.31,
                 "feels_like": 302.21,
                 "temp_min": 303.31,
                 "temp_max": 303.31,
                 "pressure": 1010,
                 "sea_level": 1010,
                 "grnd_level": 977,
                 "humidity": 32,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 96
             },
             "wind": {
                 "speed": 3.93,
                 "deg": 92,
                 "gust": 5.53
             },
             "visibility": 10000,
             "pop": 0.08,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-22 15:00:00"
         },
         {
             "dt": 1661191200,
             "main": {
                 "temp": 298.17,
                 "feels_like": 297.69,
                 "temp_min": 298.17,
                 "temp_max": 298.17,
                 "pressure": 1011,
                 "sea_level": 1011,
                 "grnd_level": 978,
                 "humidity": 37,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 803,
                     "main": "Clouds",
                     "description": "broken clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 54
             },
             "wind": {
                 "speed": 5.16,
                 "deg": 78,
                 "gust": 12.61
             },
             "visibility": 10000,
             "pop": 0.05,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-22 18:00:00"
         },
         {
             "dt": 1661202000,
             "main": {
                 "temp": 294.73,
                 "feels_like": 294.09,
                 "temp_min": 294.73,
                 "temp_max": 294.73,
                 "pressure": 1011,
                 "sea_level": 1011,
                 "grnd_level": 978,
                 "humidity": 44,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03n"
                 }
             ],
             "clouds": {
                 "all": 50
             },
             "wind": {
                 "speed": 3.35,
                 "deg": 92,
                 "gust": 8.34
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-22 21:00:00"
         },
         {
             "dt": 1661212800,
             "main": {
                 "temp": 293.34,
                 "feels_like": 292.69,
                 "temp_min": 293.34,
                 "temp_max": 293.34,
                 "pressure": 1012,
                 "sea_level": 1012,
                 "grnd_level": 978,
                 "humidity": 49,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 803,
                     "main": "Clouds",
                     "description": "broken clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 61
             },
             "wind": {
                 "speed": 2.94,
                 "deg": 74,
                 "gust": 6.19
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-23 00:00:00"
         },
         {
             "dt": 1661223600,
             "main": {
                 "temp": 291.79,
                 "feels_like": 291.15,
                 "temp_min": 291.79,
                 "temp_max": 291.79,
                 "pressure": 1012,
                 "sea_level": 1012,
                 "grnd_level": 978,
                 "humidity": 55,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03n"
                 }
             ],
             "clouds": {
                 "all": 41
             },
             "wind": {
                 "speed": 2.9,
                 "deg": 86,
                 "gust": 5.69
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-23 03:00:00"
         },
         {
             "dt": 1661234400,
             "main": {
                 "temp": 297.16,
                 "feels_like": 296.71,
                 "temp_min": 297.16,
                 "temp_max": 297.16,
                 "pressure": 1013,
                 "sea_level": 1013,
                 "grnd_level": 980,
                 "humidity": 42,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03d"
                 }
             ],
             "clouds": {
                 "all": 39
             },
             "wind": {
                 "speed": 4.11,
                 "deg": 98,
                 "gust": 6.56
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-23 06:00:00"
         },
         {
             "dt": 1661245200,
             "main": {
                 "temp": 302.82,
                 "feels_like": 301.54,
                 "temp_min": 302.82,
                 "temp_max": 302.82,
                 "pressure": 1013,
                 "sea_level": 1013,
                 "grnd_level": 980,
                 "humidity": 29,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03d"
                 }
             ],
             "clouds": {
                 "all": 25
             },
             "wind": {
                 "speed": 5.63,
                 "deg": 110,
                 "gust": 7.93
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-23 09:00:00"
         },
         {
             "dt": 1661256000,
             "main": {
                 "temp": 305.42,
                 "feels_like": 303.66,
                 "temp_min": 305.42,
                 "temp_max": 305.42,
                 "pressure": 1013,
                 "sea_level": 1013,
                 "grnd_level": 980,
                 "humidity": 24,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03d"
                 }
             ],
             "clouds": {
                 "all": 27
             },
             "wind": {
                 "speed": 6.18,
                 "deg": 107,
                 "gust": 7.83
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-23 12:00:00"
         },
         {
             "dt": 1661266800,
             "main": {
                 "temp": 304.55,
                 "feels_like": 302.95,
                 "temp_min": 304.55,
                 "temp_max": 304.55,
                 "pressure": 1013,
                 "sea_level": 1013,
                 "grnd_level": 980,
                 "humidity": 26,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03d"
                 }
             ],
             "clouds": {
                 "all": 30
             },
             "wind": {
                 "speed": 5.82,
                 "deg": 104,
                 "gust": 7.17
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-23 15:00:00"
         },
         {
             "dt": 1661277600,
             "main": {
                 "temp": 298.75,
                 "feels_like": 298.15,
                 "temp_min": 298.75,
                 "temp_max": 298.75,
                 "pressure": 1015,
                 "sea_level": 1015,
                 "grnd_level": 981,
                 "humidity": 30,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 801,
                     "main": "Clouds",
                     "description": "few clouds",
                     "icon": "02n"
                 }
             ],
             "clouds": {
                 "all": 20
             },
             "wind": {
                 "speed": 4.65,
                 "deg": 98,
                 "gust": 12.36
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-23 18:00:00"
         },
         {
             "dt": 1661288400,
             "main": {
                 "temp": 295.19,
                 "feels_like": 294.31,
                 "temp_min": 295.19,
                 "temp_max": 295.19,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 982,
                 "humidity": 33,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 801,
                     "main": "Clouds",
                     "description": "few clouds",
                     "icon": "02n"
                 }
             ],
             "clouds": {
                 "all": 20
             },
             "wind": {
                 "speed": 3.03,
                 "deg": 93,
                 "gust": 5.23
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-23 21:00:00"
         },
         {
             "dt": 1661299200,
             "main": {
                 "temp": 293.31,
                 "feels_like": 292.3,
                 "temp_min": 293.31,
                 "temp_max": 293.31,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 982,
                 "humidity": 35,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03n"
                 }
             ],
             "clouds": {
                 "all": 45
             },
             "wind": {
                 "speed": 2.52,
                 "deg": 92,
                 "gust": 4.14
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-24 00:00:00"
         },
         {
             "dt": 1661310000,
             "main": {
                 "temp": 291.76,
                 "feels_like": 290.67,
                 "temp_min": 291.76,
                 "temp_max": 291.76,
                 "pressure": 1017,
                 "sea_level": 1017,
                 "grnd_level": 983,
                 "humidity": 38,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 802,
                     "main": "Clouds",
                     "description": "scattered clouds",
                     "icon": "03n"
                 }
             ],
             "clouds": {
                 "all": 27
             },
             "wind": {
                 "speed": 2.4,
                 "deg": 84,
                 "gust": 3.59
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-24 03:00:00"
         },
         {
             "dt": 1661320800,
             "main": {
                 "temp": 297.89,
                 "feels_like": 297.28,
                 "temp_min": 297.89,
                 "temp_max": 297.89,
                 "pressure": 1017,
                 "sea_level": 1017,
                 "grnd_level": 983,
                 "humidity": 33,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 801,
                     "main": "Clouds",
                     "description": "few clouds",
                     "icon": "02d"
                 }
             ],
             "clouds": {
                 "all": 20
             },
             "wind": {
                 "speed": 4.7,
                 "deg": 101,
                 "gust": 8.41
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-24 06:00:00"
         },
         {
             "dt": 1661331600,
             "main": {
                 "temp": 304.24,
                 "feels_like": 302.45,
                 "temp_min": 304.24,
                 "temp_max": 304.24,
                 "pressure": 1017,
                 "sea_level": 1017,
                 "grnd_level": 984,
                 "humidity": 23,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 800,
                     "main": "Clear",
                     "description": "clear sky",
                     "icon": "01d"
                 }
             ],
             "clouds": {
                 "all": 10
             },
             "wind": {
                 "speed": 5.77,
                 "deg": 108,
                 "gust": 8.29
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-24 09:00:00"
         },
         {
             "dt": 1661342400,
             "main": {
                 "temp": 306.03,
                 "feels_like": 303.91,
                 "temp_min": 306.03,
                 "temp_max": 306.03,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 984,
                 "humidity": 19,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 801,
                     "main": "Clouds",
                     "description": "few clouds",
                     "icon": "02d"
                 }
             ],
             "clouds": {
                 "all": 19
             },
             "wind": {
                 "speed": 6.15,
                 "deg": 111,
                 "gust": 7.64
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-24 12:00:00"
         },
         {
             "dt": 1661353200,
             "main": {
                 "temp": 304.23,
                 "feels_like": 302.3,
                 "temp_min": 304.23,
                 "temp_max": 304.23,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 984,
                 "humidity": 20,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 4.9,
                 "deg": 108,
                 "gust": 7.35
             },
             "visibility": 10000,
             "pop": 0.01,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-24 15:00:00"
         },
         {
             "dt": 1661364000,
             "main": {
                 "temp": 299.5,
                 "feels_like": 299.5,
                 "temp_min": 299.5,
                 "temp_max": 299.5,
                 "pressure": 1017,
                 "sea_level": 1017,
                 "grnd_level": 984,
                 "humidity": 26,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 4.36,
                 "deg": 79,
                 "gust": 11.41
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-24 18:00:00"
         },
         {
             "dt": 1661374800,
             "main": {
                 "temp": 296.29,
                 "feels_like": 295.39,
                 "temp_min": 296.29,
                 "temp_max": 296.29,
                 "pressure": 1018,
                 "sea_level": 1018,
                 "grnd_level": 985,
                 "humidity": 28,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 98
             },
             "wind": {
                 "speed": 3.24,
                 "deg": 94,
                 "gust": 7.57
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-24 21:00:00"
         },
         {
             "dt": 1661385600,
             "main": {
                 "temp": 294.1,
                 "feels_like": 293.03,
                 "temp_min": 294.1,
                 "temp_max": 294.1,
                 "pressure": 1019,
                 "sea_level": 1019,
                 "grnd_level": 985,
                 "humidity": 30,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 99
             },
             "wind": {
                 "speed": 3.26,
                 "deg": 74,
                 "gust": 6.9
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-25 00:00:00"
         },
         {
             "dt": 1661396400,
             "main": {
                 "temp": 292.96,
                 "feels_like": 291.83,
                 "temp_min": 292.96,
                 "temp_max": 292.96,
                 "pressure": 1018,
                 "sea_level": 1018,
                 "grnd_level": 984,
                 "humidity": 32,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 3.42,
                 "deg": 66,
                 "gust": 8.07
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-25 03:00:00"
         },
         {
             "dt": 1661407200,
             "main": {
                 "temp": 297.16,
                 "feels_like": 296.35,
                 "temp_min": 297.16,
                 "temp_max": 297.16,
                 "pressure": 1019,
                 "sea_level": 1019,
                 "grnd_level": 985,
                 "humidity": 28,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 4.7,
                 "deg": 76,
                 "gust": 9.49
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-25 06:00:00"
         },
         {
             "dt": 1661418000,
             "main": {
                 "temp": 303.82,
                 "feels_like": 301.94,
                 "temp_min": 303.82,
                 "temp_max": 303.82,
                 "pressure": 1018,
                 "sea_level": 1018,
                 "grnd_level": 985,
                 "humidity": 20,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 86
             },
             "wind": {
                 "speed": 4.98,
                 "deg": 81,
                 "gust": 6.06
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-25 09:00:00"
         },
         {
             "dt": 1661428800,
             "main": {
                 "temp": 305.22,
                 "feels_like": 303.19,
                 "temp_min": 305.22,
                 "temp_max": 305.22,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 984,
                 "humidity": 20,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 803,
                     "main": "Clouds",
                     "description": "broken clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 84
             },
             "wind": {
                 "speed": 4.88,
                 "deg": 98,
                 "gust": 5.56
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-25 12:00:00"
         },
         {
             "dt": 1661439600,
             "main": {
                 "temp": 303.69,
                 "feels_like": 301.87,
                 "temp_min": 303.69,
                 "temp_max": 303.69,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 983,
                 "humidity": 21,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 4.63,
                 "deg": 86,
                 "gust": 6.68
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-25 15:00:00"
         },
         {
             "dt": 1661450400,
             "main": {
                 "temp": 297.6,
                 "feels_like": 296.83,
                 "temp_min": 297.6,
                 "temp_max": 297.6,
                 "pressure": 1017,
                 "sea_level": 1017,
                 "grnd_level": 983,
                 "humidity": 28,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 99
             },
             "wind": {
                 "speed": 2.66,
                 "deg": 74,
                 "gust": 3.51
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-25 18:00:00"
         },
         {
             "dt": 1661461200,
             "main": {
                 "temp": 295.33,
                 "feels_like": 294.47,
                 "temp_min": 295.33,
                 "temp_max": 295.33,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 983,
                 "humidity": 33,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 96
             },
             "wind": {
                 "speed": 2.94,
                 "deg": 40,
                 "gust": 4.11
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-25 21:00:00"
         },
         {
             "dt": 1661472000,
             "main": {
                 "temp": 293.66,
                 "feels_like": 292.73,
                 "temp_min": 293.66,
                 "temp_max": 293.66,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 982,
                 "humidity": 37,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 803,
                     "main": "Clouds",
                     "description": "broken clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 75
             },
             "wind": {
                 "speed": 3.75,
                 "deg": 38,
                 "gust": 9.28
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-26 00:00:00"
         },
         {
             "dt": 1661482800,
             "main": {
                 "temp": 292.72,
                 "feels_like": 291.83,
                 "temp_min": 292.72,
                 "temp_max": 292.72,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 982,
                 "humidity": 42,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 3.62,
                 "deg": 49,
                 "gust": 9.47
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2022-08-26 03:00:00"
         },
         {
             "dt": 1661493600,
             "main": {
                 "temp": 297.89,
                 "feels_like": 297.28,
                 "temp_min": 297.89,
                 "temp_max": 297.89,
                 "pressure": 1016,
                 "sea_level": 1016,
                 "grnd_level": 982,
                 "humidity": 33,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 4.89,
                 "deg": 62,
                 "gust": 10.54
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-26 06:00:00"
         },
         {
             "dt": 1661504400,
             "main": {
                 "temp": 303.69,
                 "feels_like": 301.83,
                 "temp_min": 303.69,
                 "temp_max": 303.69,
                 "pressure": 1014,
                 "sea_level": 1014,
                 "grnd_level": 982,
                 "humidity": 20,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 100
             },
             "wind": {
                 "speed": 6.59,
                 "deg": 67,
                 "gust": 8.23
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-26 09:00:00"
         },
         {
             "dt": 1661515200,
             "main": {
                 "temp": 304.82,
                 "feels_like": 302.78,
                 "temp_min": 304.82,
                 "temp_max": 304.82,
                 "pressure": 1014,
                 "sea_level": 1014,
                 "grnd_level": 981,
                 "humidity": 19,
                 "temp_kf": 0
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 98
             },
             "wind": {
                 "speed": 6.12,
                 "deg": 85,
                 "gust": 7.21
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2022-08-26 12:00:00"
         }
     ],
     "city": {
         "id": 689558,
         "name": "Vinnytsia",
         "coord": {
             "lat": 49.238,
             "lon": 28.4114
         },
         "country": "UA",
         "population": 352115,
         "timezone": 10800,
         "sunrise": 1661051188,
         "sunset": 1661101982
     }
 }
 */
