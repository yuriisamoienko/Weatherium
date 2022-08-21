//
//  EasyCodable.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation

/*
 EasyCodable allows easily encode & decode (serialize & deserialize) class & struct instances.
 
 It allows create instances from redundant jsons (which constains more keys then needed) !!! It's very useful with http responses
*/

import Foundation

protocol EasyCodable: Codable {
    associatedtype InstanceType
    
    // default empty constructor is required. Fill it with empty/zero/invalid values
    init()
}

extension Array: EasyCodable where Element: EasyCodable {
    
    static func decode(from arr: [AnyDictionary]) throws -> Self {
        var result: Self = []
        for item in arr {
            let data = try Element(from: item)
            result.append(data)
        }
        return result
    }
}

extension Dictionary: EasyCodable where Key: EasyCodable, Value: EasyCodable {}
extension String: EasyCodable {}

typealias AnyDictionary = [AnyHashable: Any]

extension EasyCodable {
    typealias InstanceType = Self
    
    func encode() throws -> Data {
        var result: Data
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            result = data
        } catch {
            throw CError(message: "\(String(describing: type(of: self))) failed to encode with error: \(error.localizedDescription)")
        }
        return result
    }
    
    func encodeAsString() throws -> String? {
        var result: String?
        let data = try self.encode()
        if let str = String(data: data, encoding: .utf8) {
            result = str
        }
        return result
    }
    
    static func decode(from json: String?) throws -> Self {
        guard let json = json else {
            throw CError(message: "json is nil")
        }
        return try Self(data: json)
    }
    
    init(data json: String) throws {
        let data = Data(json.utf8)
        self = try Self(data: data)
    }
    
    static func decode(from data: Data?) throws -> Self {
        guard let data = data else {
            throw CError(message: "data is nil")
        }
        let result = try Self(data: data)
        return result
    }
    
    init(from dict: AnyDictionary) throws {
        try self.init(from: dict, isReflectionPerformed: false)
    }
    
    init(from dict: AnyDictionary, isReflectionPerformed: Bool) throws {
        let data = try dict.toData()
        do {
            try self.init(data: data, isReflectionPerformed: true) //because custom reflection will be done here in case of failure
        } catch {
            if isReflectionPerformed == false {
                guard let stringDict = dict as? [String: Any]
                else {
                    throw CError(message: "input dictionary isn't [String: Any]")
                }
                do {
                    try self.init(byReflectionFrom: stringDict)
                    return
                } catch {
                    throw error
                }
            } else {
                throw error
            }
        }
    }
    
    init(data: Data) throws {
        try self.init(data: data, isReflectionPerformed: false)
    }
    
    private init(data: Data, isReflectionPerformed: Bool) throws {
        do {
            self = try JSONDecoder().decode(InstanceType, from: data)
        } catch {
            let onErrror: (Error) -> Void = { error in
                print("\(String(describing: type(of: Self.self))) failed to decode data: \(data) with error: \(error.localizedDescription)")
            }
            if isReflectionPerformed == false {
                do {
                    try self.init(byReflectionFrom: data)
                    return
                } catch {
                    onErrror(error)
                    throw error
                }
            }
            onErrror(error)
            throw error
        }
    }
    
    func convertToDictionary() throws -> [String: Any] {
        let selfData: Data = try self.encode()
        let result = try [String: Any](fromJsonData: selfData)
        return result
    }
    
    // MARK: Private Functions
    
    init(byReflectionFrom data: Data) throws {
        let valuesDict = try [String: Any](fromJsonData: data)
        self = try Self(byReflectionFrom: valuesDict)
    }
    
    init(byReflectionFrom dict: [String: Any]) throws {
        var resultDict = try Self().convertToDictionary()
        try resultDict.replaceExistingValues(from: dict)
        
        do {
            try self.init(from: resultDict, isReflectionPerformed: true)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
