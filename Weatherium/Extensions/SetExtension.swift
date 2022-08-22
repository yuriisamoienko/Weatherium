//
//  SetExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 21.08.2022.
//

import Foundation

extension Set {
    
    func contains(allFrom array: Array<Element>) -> Bool {
        var result = true
        for item in array {
            if self.contains(item) == false {
                result = false
                break
            }
        }
        return result
    }
    
}
