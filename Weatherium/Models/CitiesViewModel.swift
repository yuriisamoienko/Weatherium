//
//  CitiesViewModel.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation
import Combine

struct WeatherTemperature {
    let high: Int
    let low: Int
}

struct CityData {
    let id: Int
    let name: String
}
extension CityData: EasyCodable {}

@MainActor class CitiesViewModel: ObservableObject {

    @Published var cities: [CityData] = []
    
    init() {
        Task {
            do {
                cities = try await loadCities()
            } catch {
                print("init cities failed with error \(error)")
            }
        }
    }
    
    private func loadCities() async throws -> [CityData] {
        try await withCheckedThrowingContinuation { continuation in
            let onError: (String) -> Void = { message in
                continuation.resume(throwing: CError(message: message))
            }
            guard let path = Bundle.main.url(forResource: "CitiesList", withExtension: "plist")
            else {
                onError("failed to get path of CitiesList.plist ")
                return
            }
            guard let listData = NSArray(contentsOf: path),
                  let cityArray = listData as? [AnyDictionary]
            else {
                onError("failed to load CitiesList")
                return
            }
            
            guard let result = try? [CityData].decode(from: cityArray)
            else {
                onError("failed to decode CitiesList")
                return
            }
            continuation.resume(returning: result)
        }
    }
    
}
