//
//  UnitTemperature.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation

extension UnitTemperature {
    
    // MARK: Public Properties
    
    static var local: UnitTemperature {
        let measureFormatter = MeasurementFormatter()
        let measurement = Measurement(value: 0, unit: UnitTemperature.celsius)
        let output = measureFormatter.string(from: measurement)
        return output == "0°C" ? .celsius : .fahrenheit
    }
    
    var englishName: String {
        let result: String
        switch self {
        case .celsius:
            result = "celsius"
            
        case .fahrenheit:
            result = "fahrenheit"
            
        case .kelvin:
            result = "kelvin"
            
        default:
            result = "unknown"
        }
        return result
    }
    
}
