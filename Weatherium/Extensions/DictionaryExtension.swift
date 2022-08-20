//
//  DictionaryExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation

extension Dictionary {
    
    // serialize dictionary to Data format
    func toData() throws -> Data {
        let result = try JSONSerialization.data(
            withJSONObject: self,
            options: []
        )
        return result
    }
    
}
