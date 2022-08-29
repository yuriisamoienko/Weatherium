//
//  DependenciesInjector.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 29.08.2022.
//

import Foundation

open class DependenciesInjector: NSObject, DependenciesInjectorProtocol {
    
    // MARK: Public Properties
    
    static let shared: DependenciesInjectorProtocol = DependenciesInjector()
    
    // MARK: Private Functions
    
    override private init() { // prevent creating of another DependenciesInjector instance
        super.init()
        //if needed
    }
    
    // MARK: DependenciesInjectorProtocol

    @MainActor
    open func inject() {
        let citiesViewModel = CitiesViewModel()
        addDependency({ citiesViewModel as CitiesViewModel })
        
        let weatherViewModel = WeatherViewModel()
        addDependency({ weatherViewModel as WeatherViewModel })
        
        let networkRequestService: NetworkRequestServicePl = NetworkRequestService()
        addDependency({ networkRequestService as NetworkRequestServicePl })
        
        let router = NavigationRouter()
        addDependency({ router as NavigationRouter })
    }
    
}
