//
//  NetworkRequestService.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation

protocol NetworkRequestServicePl {
    
    func perform(endpoint: NetworkEnpoint) async throws -> (Data, URLResponse)
    func getDataFrom<T: EasyCodable>(endpoint: NetworkEnpoint) async throws -> T
    
}

struct NetworkRequestService: NetworkRequestServicePl {
    
    // MARK: Private Properties
    
    private let apiUrl = URL(string: "https://api.openweathermap.org/data/2.5")!
    private let appId = "0cd74bf29e43ef1ad6afd6861cc99eb2"
    private let session: URLSession = .shared
    
    // MARK: NetworkRequestServicePl
    
    func getDataFrom<T: EasyCodable>(endpoint: NetworkEnpoint) async throws -> T {
        let (data, _) = try await perform(endpoint: endpoint)
        let result = try T.decode(from: data)
        return result
    }
    
    func perform(endpoint: NetworkEnpoint) async throws -> (Data, URLResponse) {
        let urlData = endpoint.urlData
        let url = apiUrl.appendingPathComponent(urlData.path)
        
        guard var urlComps = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw CError(message: "failed create URLComponents from url: \(url.absoluteString)")
        }
        var queryParams = urlData.params
        queryParams["appid"] = appId
        
        let requestType = endpoint.requestType
        switch requestType {
        case .GET:
            let queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            urlComps.queryItems = queryItems
            
        default:
            break
        }
        
        guard let requestUrl = urlComps.url else {
            throw CError(message: "URLComponents url isn't constructed")
        }
        guard var request = URLRequest(url: requestUrl) else {
            throw CError(message: "failed create request from url: \(requestUrl.absoluteString)")
        }
        switch requestType {
        case .GET:
            request.httpMethod = "GET"
            
        case .POST:
            //TODO
            break
        }
        
        let result = try await URLSession.shared.data(for: request)
        return result
    }
    
}
