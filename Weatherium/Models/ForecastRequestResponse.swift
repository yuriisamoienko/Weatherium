//
//  WeatherForecastRequestResponse.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

struct ForecastRequestResponse: EasyCodable {
    let list: [WeatherResponse]
    
    init() {
        self.list = []
    }
}
