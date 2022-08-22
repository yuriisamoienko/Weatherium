//
//  TimeZoneExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation

extension TimeZone {
    
    var hoursFromGtm: Int {
        let secondsFromGMT: Int = self.secondsFromGMT()
        let result = Int(Double(secondsFromGMT)/Double(3600))
        return result
    }
    
}
