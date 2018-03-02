//
//  ViewController.swift
//  ELSwiftJsonParser
//
//  Created by Elenion on 2018/3/1.
//  Copyright © 2018年 Elenion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class AnObject: NSObject, JsonDictionaryDecodable {
    
    var string: String?
    var int: Int?
    var bool: Bool?
    var double: Double?
    var date: Date?
    var object: AnObject?
    var objectArray: [AnObject] = []
    var arrayOfString: [String] = []
    
    enum AType {
        case foo
        case bar
        static func from(int: Int) -> AType? {
            switch int {
            case 0:
                return .foo
            case 1:
                return .bar
            default:
                return nil
            }
        }
        
        func toInt() -> Int {
            switch self {
            case .foo:
                return 0
            case .bar:
                return 1
            }
        }
    }
    
    var aType: AType?
    var randomlyParse: String?
    
    required init(from dictionary: [String : Any]) {
        super.init()
        // String
        string = dictionary.string("string")
        // Int
        int = dictionary.int("int")
        // Bool
        bool = dictionary.bool("boolValue")
        // Double
        double = dictionary.double("double")
        // Date
        date = dictionary.date("dateString")
        // Purse object from Dictionary
        object = dictionary.object("object", type: AnObject.self)
        // Purse array of object from array of Dictionary
        objectArray = dictionary.objectArray("objectArray", type: AnObject.self)
        // Array of string
        arrayOfString = dictionary.array("arrayOfString", type: String.self)
        // Purse Enum from Int
        aType = AType.from(int: dictionary.int("aType") ?? -1)
        // Purse as specified
        randomlyParse = dictionary.array("anyDictionaryArray", type: [String: Any].self).first?.dictionary("anyInnerDictionary")?.string("randomParse")
    }
    
    required override init() {
        super.init()
    }
}

extension AnObject: JsonDictionaryEncodable {
    
    func toDictionary() -> [String : Any] {
        var dictionary: [String: Any]  = [:]
        dictionary["string"] = string ?? ""
        dictionary["int"] = int ?? -1
        if let boolValue = bool {
            dictionary["boolValue"] = boolValue
        }
        dictionary["double"] = double ?? 0.0
        dictionary["date"] = (date?.timeIntervalSince1970 ?? 0.0) * 1000
        dictionary["object"] = object?.toDictionary() ?? [:]
        dictionary["objectArray"] = objectArray.map({ (object) -> [String: Any] in
            return object.toDictionary()
        })
        dictionary["arrayOfString"] = arrayOfString
        dictionary["aType"] = aType?.toInt() ?? -1
        return dictionary
    }
}
