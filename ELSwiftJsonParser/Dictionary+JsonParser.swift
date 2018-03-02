//
//  Dictionary+JsonParser.swift
//  ELSwiftJsonParser
//
//  Created by Elenion on 2018/3/1.
//  Copyright © 2018年 Elenion. All rights reserved.
//

import Foundation

/// Convert model from dictionary
protocol JsonDictionaryDecodable {
    init(from dictionary: [String: Any])
    init()
}

/// Convert model to dictionary
protocol JsonDictionaryEncodable {
    /// Creating dictionary from model
    ///
    /// - Returns: dictionary
    func toDictionary() -> [String: Any]
}

extension Dictionary where Key == String, Value == Any {
    /// Get String object from dictionary
    ///
    /// - Parameter key: The key of object
    /// - Returns: String
    func string(_ key: String) -> String? {
        let object = self[key]
        if object == nil {
            return nil
        }
        if let object = object as? String {
            return object
        }
        if let object = object as? CustomStringConvertible {
            return object.description
        }
        return nil
    }
    
    /// Get Int object from dictionary
    ///
    /// - Parameter key: The key of object
    /// - Returns: String
    func int(_ key: String) -> Int? {
        let object = self[key]
        if object == nil {
            return nil
        }
        if let object = object as? Int {
            return object
        }
        if let object = object as? String {
            return Int(object)
        }
        if let object = object as? Double {
            return Int(object)
        }
        if let object = object as? Float {
            return Int(object)
        }
        if let object = object as? Bool {
            return object ? 1 : 0
        }
        return nil
    }
    
    /// Get Double object from dictionary
    ///
    /// - Parameter key: The key of object
    /// - Returns: String
    func double(_ key: String) -> Double? {
        let object = self[key]
        if object == nil {
            return nil
        }
        if let object = object as? Double {
            return object
        }
        if let object = object as? String {
            return Double(object)
        }
        if let object = object as? Float {
            return Double(object)
        }
        if let object = object as? Int {
            return Double(object)
        }
        if let object = object as? Bool {
            return object ? 1 : 0
        }
        return nil
    }
    
    /// Get Bool object from dictionary
    ///
    /// - Parameter key: The key of object
    /// - Returns: String
    func bool(_ key: String) -> Bool? {
        let object = self[key]
        if object == nil {
            return nil
        }
        if let object = object as? Bool {
            return object
        }
        if let object = object as? Double {
            return object == 0
        }
        if let object = object as? Float {
            return object == 0
        }
        if let object = object as? Int {
            return object == 0
        }
        if let object = object as? String {
            return object == "1" || object == "YES" || object == "true" || object == "Y" || object == "Yes" || object == "True" || object == "yes" || object == "TRUE"
        }
        return nil
    }
    
    /// Get object from dictionary and convert it to type
    ///
    /// - Parameters:
    ///   - key: The key of object
    ///   - type: The type which object will be convert to
    /// - Returns: The object
    func object<T>(_ key: String, type: T.Type) -> T? where T: JsonDictionaryDecodable {
        let object = self[key]
        if object == nil {
            return nil
        }
        if let object = object as? [String: Any] {
            return T.init(from: object)
        }
        return nil
    }
    
    /// Get object from array and convert it to array of type
    ///
    /// - Parameters:
    ///   - key: The key of array
    ///   - type: The type which object will be convert to
    /// - Returns: An array of type object
    func objectArray<T>(_ key: String, type: T.Type) -> [T] where T: JsonDictionaryDecodable {
        let object = self[key]
        if object == nil {
            return []
        }
        if let object = object as? [[String: Any]] {
            return object.map({ (dic) -> T in
                T.init(from: dic)
            })
        }
        return []
    }
    
    /// Get object from array to array of type
    ///
    /// - Parameters:
    ///   - key: The key of array
    ///   - type: The type of object
    /// - Returns: An array of type object
    func array<T>(_ key: String, type: T.Type) -> [T] {
        let object = self[key]
        if object == nil {
            return []
        }
        if let object = object as? [T] {
            return object
        }
        return []
    }
    
    func date(_ key: String) -> Date? {
        guard let dateTime = self[key] as? Int else {
            return nil
        }
        return Date(timeIntervalSince1970: Double(dateTime/1000))
    }
    
    func dictionary(_ key: String) -> [String: Any]? {
        guard let dictionary = self[key] as? Dictionary else {
            return nil
        }
        return dictionary
    }
}
