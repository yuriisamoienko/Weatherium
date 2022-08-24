//
//  TemperatureSwitcherButton.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import SwiftUI

enum DisplayedTemperatureUnit: Int {
    
    case celsius
    case fahrenheit
    
    // MARK: Public Properties
    
    var unit: UnitTemperature {
        let result: UnitTemperature
        switch self {
        case .celsius:
            result = .celsius
            
        case .fahrenheit:
            result = .fahrenheit
        }
        return result
    }
    
    var name: String {
        let result = unit.englishName
        return result
    }
    
    // MARK: Public Functions
    
    mutating func next() {
        self = Self(rawValue: rawValue + 1) ?? Self(rawValue: 0)!
    }
    
}

class AppSettings: ObservableObject {
    @Published var displayedTemperatureUnit: DisplayedTemperatureUnit = getSavedDisplayedTemperatureUnit()
}

fileprivate let displayedTemperatureUnitKey = "displayCelsiusOrFahrenheit"
fileprivate func getSavedDisplayedTemperatureUnit() -> DisplayedTemperatureUnit {
    let result = DisplayedTemperatureUnit(rawValue: UserDefaults.standard.integer(forKey: displayedTemperatureUnitKey)) ?? (UnitTemperature.local == .celsius ? .celsius : .fahrenheit)
    return result
}

struct TemperatureSwitcherButton: View {
    
    // MARK: Private Properties
    
    @EnvironmentObject private var appSettings: AppSettings
    
    // MARK: Public Properties
    
    var body: some View {
        Button(appSettings.displayedTemperatureUnit.name.capitalizingFirstLetter()) {
            var displayCelsiusOrFahrenheit = getSavedDisplayedTemperatureUnit()
            displayCelsiusOrFahrenheit.next()
            appSettings.displayedTemperatureUnit = displayCelsiusOrFahrenheit
            UserDefaults.standard.set(displayCelsiusOrFahrenheit.rawValue, forKey: displayedTemperatureUnitKey)
        }
    }
    
}

struct TemperatureSwitcherButton_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureSwitcherButton()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .preferredColorScheme(.light)
    }
}
