//
//  WeatherData.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

struct WeatherData {
    
    // MARK: Public Properties
    
    let weatherDescription: String
    let temperature: WeatherTemperature
    let icon: String
    let timestamp: Double
    
    static let invalid = WeatherData(weatherDescription: "", temperature: .invalid, icon: "", timestamp: -1)
}

struct WeatherTemperature: Equatable {
    
    // MARK: Public Properties
    
    let high: Int
    let low: Int
    
    static let invalid = WeatherTemperature(high: Int.max, low: Int.min )
    
    // MARK: Public Functions
    
    func isInvalid() -> Bool {
        let result = self == Self.invalid
        return result
    }
}
