//
//  CityData.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

struct CityData {
    let id: Int // it's a geoname
    let name: String
    let country: String?
}

extension CityData: EasyCodable {
    init() {
        id = 0
        name = ""
        country = nil
    }
}

extension CityData: Hashable {}
