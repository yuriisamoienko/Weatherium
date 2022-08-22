//
//  Router.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation
import Combine
import SwiftUI

enum NavigationScreen {
    
    case weatherInCity(CityData, WeatherViewModel) // TODO @Inject WeatherViewModel
    //case ...
    
    var destination: some View {
        switch self {
        case .weatherInCity(let city, let weatherViewModel):
            return CityWeatherView(city: city, weatherViewModel: weatherViewModel)
        }
        //case ...
    }
}

//TODO protocol
struct NavigationRouter {

    /*
     NavigationLink doens't work if not located on the visible screen area
     I recommend put in ZStack behind view's content
     */
    func navigationLink(to screen: NavigationScreen, isActive: Binding<Bool>) -> some View { // can't return 'some View' from protocol
        return NavigationLink(destination: screen.destination, isActive: isActive, label: {
            EmptyView()
        })
        .hidden()
        .frame(width: 0, height: 0)
    }
    
}
