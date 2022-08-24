//
//  DictionaryExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation

extension Dictionary {
    
    // MARK: Public Functions
    
    //MOD
    init(fromJsonData data: Data) throws {
        guard let value = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Self else {
            throw CError(message: "failed convert data json to dictionary")
        }
        self.init()
        self += value
    }
    
    // serialize dictionary to Data format
    func toData() throws -> Data {
        let result = try JSONSerialization.data(
            withJSONObject: self,
            options: []
        )
        return result
    }
    
    func toJsonString() -> String? {
        var result: String?
        if let theJSONData = try? toData() {
            let theJSONText = String(data: theJSONData, encoding: .utf8)
            result = theJSONText
        }
        return result
    }
    
    
    static func += (left: inout [Key: Value], right: [Key: Value]) {
        for (k, v) in right {
            left[k] = v
        }
    }
    
}

extension Dictionary where Key == String {
    
    // MARK: Public Functions
    
    //MOD new
    // replaces keys values in self with values from input dict of equial keys
    // dict can be redundant
    mutating func replaceExistingValues(from dict: [String: Value]) throws {
        let keys = Array(self.keys)
        
        guard Set(dict.keys).contains(allFrom: keys) == true else {
            let error = "keys (\(keys)) are missed in dictionary (\(dict.toJsonString() ?? "")"
            throw CError(message: error)
        }
        
        for key in keys {
            let dictValue = dict[key]
            if var keyDict = self[key] as? Dictionary {
                if let dictValueDictionary = dictValue as? Dictionary {
                    try keyDict.replaceExistingValues(from: dictValueDictionary)
                } else {
                    let errorMessage = "key (\(key)) is expected to be dictionary, in input (\(dict.toJsonString() ?? "")"
                    print(errorMessage)
                    throw CError(message: errorMessage)
                }
            } else {
                if dictValue is Dictionary {
                    throw CError(message: "key (\(key)) isn't expected to be dictionary, in input (\(dict.toJsonString() ?? "")")
                }
                self[key] = dictValue
            }
        }
        print("done")
    }
    
}
