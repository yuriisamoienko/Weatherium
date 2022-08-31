//
//  CitiesViewModel.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

protocol CitiesViewModelPl {
    
    var cities: AnyPublished<[CityData]> { get }
    
    func getCoordinateOf(city: CityData) async -> CLLocationCoordinate2D?
    
}

class CitiesViewModel: CitiesViewModelPl {
    
    // MARK: Public Properties

    var cities: AnyPublished<[CityData]> = .init([])
    
    // MARK: Private Properties
    
    private var citiesCoordinate: [CityData: CLLocationCoordinate2D] = [:]
    
    // MARK: Public Functions
    
    init() {
        Task {
            do {
                cities.val = try await loadCities()
            } catch {
                print("init cities failed with error \(error)")
            }
        }
    }
    
    
    func getCoordinateOf(city: CityData) async -> CLLocationCoordinate2D? {
        var coordinate: CLLocationCoordinate2D? = citiesCoordinate[city]
        if coordinate == nil {
            var address = city.name
            if let country = city.country {
                address += " \(country)"
            }
//            address += " \(city.id)" //doens't help to geocode
            
            do {
                let placemarks: [CLPlacemark] = try await CLGeocoder().geocodeAddressString(address)
                coordinate = placemarks.first(where: { $0.location != nil })?.location?.coordinate
                citiesCoordinate[city] = coordinate
            } catch {
                print("failed geocode address '\(address)' with error: \(error.localizedDescription)")
            }
        }
        return coordinate
    }
    
    // MARK: Private Functions
    
    private func loadCities() async throws -> [CityData] {
        try await withCheckedThrowingContinuation { continuation in
            let onError: (String) -> Void = { message in
                continuation.resume(throwing: CError(message: message))
            }
            guard let path = Bundle.main.url(forResource: "CitiesList", withExtension: "plist") else {
                onError("failed to get path of CitiesList.plist ")
                return
            }
            guard let listData = NSArray(contentsOf: path),
                  let cityArray = listData as? [AnyDictionary]
            else {
                onError("failed to load CitiesList")
                return
            }
            
            guard let result = try? [CityData].decode(from: cityArray) else {
                onError("failed to decode CitiesList")
                return
            }
            continuation.resume(returning: result)
        }
    }
    
}
