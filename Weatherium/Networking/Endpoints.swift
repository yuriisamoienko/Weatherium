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
    case weatherIcon(id: String)
                  
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
        case .weatherIcon(let icon):
            result = .init(
                path: "\(icon)@2x.png"
            )
        }
        
        return result
    }
    
    var requestType: NetworkRequestType {
        let result: NetworkRequestType
        switch self {
        default:
            result = .GET
        }
        return result
    }
    
    var apiUrl: String {
        let result: String
        switch self {
        case .weatherIcon(_):
            result = "https://openweathermap.org/img/wn/"
            
        default:
            result = "https://api.openweathermap.org/data/2.5"
        }
        return result
    }
    
    func createEndpointUrl() throws -> URL {
        let apiUrlStr = self.apiUrl
        guard let apiUrl = URL(string: apiUrlStr) else {
            throw CError(message: "failed create url from api: \(apiUrlStr)")
        }
                
        let urlData = self.urlData
        let url = apiUrl.appendingPathComponent(urlData.path)
        return url
    }
}
