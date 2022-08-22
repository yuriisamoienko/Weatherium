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
    case citiesWeather
    case weatherDetails
}

//TODO protocol
struct NavigationRouter {

    func navigationLink(to screen: NavigationScreen, isActive: Binding<Bool>) -> some View { // can't return 'some View' from protocol
        return NavigationLink(destination: CityWeatherView(), isActive: isActive, label: {
                EmptyView()
            })
        .hidden()
        .frame(width: 0, height: 0)
    }
    
}
