//
//  DateExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation

extension Date {
    
    // MARK: Public Properties
    
    var midnight: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    static var tomorrow: Date {
        return Date().dayAfter
    }
    
    // MARK: Public Functions
    
    func withLocalTimeZone() -> Date {
        let result = self.byAdding(hours: TimeZone.current.hoursFromGtm ) //local time
        return result
    }
    
    func byAdding(days: Int) -> Date {
        let result = Calendar.current.date(byAdding: .day, value: days, to: self)!
        return result
    }
    
    func byAdding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let result = formatter.string(from: self)
        return result
    }
    
}
