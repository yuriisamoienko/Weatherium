//
//  WeatherData.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

struct WeatherData {
    let weatherDescription: String
    let temperature: WeatherTemperature
    let icon: String
    
    static let invalid = WeatherData(weatherDescription: "", temperature: .invalid, icon: "")
}

struct WeatherTemperature: Equatable {
    let high: Int
    let low: Int
    
    static let invalid = WeatherTemperature(high: Int.max, low: Int.min )
    
    func isInvalid() -> Bool {
        let result = self == Self.invalid
        return result
    }
}
