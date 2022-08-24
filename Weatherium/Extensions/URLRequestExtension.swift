//
//  URLRequestExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation

extension URLRequest {
    
    // MARK: Public Functions
    
    // allows init with optional URL value
    init?(url: URL?) {
        guard let url = url
        else {
            return nil
        }
        self.init(url: url)
    }
    
}
