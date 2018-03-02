# ELSwiftJsonParser

[![Apps Using](https://img.shields.io/cocoapods/at/ELSwiftJsonParser.svg?label=Apps%20Using%20ELSwiftJsonParser&colorB=28B9FE)](http://cocoapods.org/pods/ELSwiftJsonParser)
[![Downloads](https://img.shields.io/cocoapods/dt/ELSwiftJsonParser.svg?label=Total%20Downloads&colorB=28B9FE)](http://cocoapods.org/pods/ELSwiftJsonParser)
[![CocoaPods](https://img.shields.io/cocoapods/v/ELSwiftJsonParser.svg?style=flat)](https://cocoapods.org/pods/ELSwiftJsonParser)
[![CocoaPods](https://img.shields.io/cocoapods/l/ELSwiftJsonParser.svg?style=flat)](https://cocoapods.org/pods/ELSwiftJsonParser)
[![iOS 9.0](https://img.shields.io/badge/iOS-8.0-blue.svg)](https://github.com/Elenionl/ELSwiftJsonParser)


A light-weight but effective tool for converting between Json Dictionary and Swift object.

## Install

```
pod 'ELSwiftJsonParser'
```

```
pod install
```

## Use

Model object which can be convert from Dictionary should confirm Protocol JsonDictionaryDecodable.
``` Swift
/// Convert model from dictionary
protocol JsonDictionaryDecodable {
    /// Creating model from dictionary
    ///
    /// - Parameter dictionary: Source dictionary
    /// - Returns: Model
    static func from(dictionary: [String: Any]) -> Self
}
```
A sample

```Swift

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
```

Model object which can be convert to Dictionary should confirm Protocol: JsonDictionaryEncodable.

  
``` Swift
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
```

## Author

@Elenionl, stallanxu@gmail.com

## License

English: ELSwiftJsonParser is available under the Apache 2.0 license, see the LICENSE file for more information.
