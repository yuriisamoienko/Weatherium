//
//  CError.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation

// custom error with cide and message
struct CError: LocalizedError {

    let message: String
    let code: Int

    init(code: Int = 0, message: String) {
        self.message = message
        self.code = code
    }
    
    // MARK: LocalizedError
    
    var errorDescription: String? { return message }
    var failureReason: String? { return message }
    
}
