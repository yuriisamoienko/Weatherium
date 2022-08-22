//
//  Endpoints.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

struct EndpointUrlData {
    var path: String
    var params: [String: String] = [:]
}

enum NetworkRequestType {
    case GET
    case POST
}

enum NetworkEnpoint {
    
    case weather(latitude: Double, longitude: Double)
    case forecast(latitude: Double, longitude: Double)
                  
    var urlData: EndpointUrlData {
        
        let result: EndpointUrlData
        switch self {
        case .weather(let latitude, let longitude):
            result = .init(
                path: "weather", params: [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
            ])
            
        case .forecast(let latitude, let longitude):
            result = .init(
                path: "forecast",
                params: [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
            ])
        }
        return result
    }
    
    var requestType: NetworkRequestType {
        let result: NetworkRequestType
        switch self {
        case .weather( _, _):
            result = .GET
            
        case .forecast(_, _):
            result = .GET
        }
        return result
    }
}
