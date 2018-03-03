
Pod::Spec.new do |s|

  s.name         = "ELSwiftJsonParser"
  s.version      = "1.0.5"
  s.summary      = "A light-weight tool helps to transfrom Json dictionary into model as well as transfrom model into Json dictionary."
  s.description  = <<-DESC

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
        string = dictionary.string("string")
        int = dictionary.int("int")
        bool = dictionary.bool("boolValue")
        double = dictionary.double("double")
        date = dictionary.date("dateString")
        object = dictionary.object("object", type: AnObject.self)
        objectArray = dictionary.objectArray("objectArray", type: AnObject.self)
        arrayOfString = dictionary.array("arrayOfString", type: String.self)
        aType = AType.from(int: dictionary.int("aType") ?? -1)
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
                   DESC
  s.homepage     = "https://github.com/Elenionl/ELSwiftJsonParser"
  s.license      = { :type => 'Apache 2.0', :file => 'LICENSE.md' }
  s.author             = { "Hanping Xu" => "stellanxu@gmail.com" }
  s.social_media_url   = "https://github.com/Elenionl"
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/Elenionl/ELSwiftJsonParser.git", :tag => "#{s.version}" }
  s.source_files  = "ELSwiftJsonParser/*"
  s.requires_arc = true
  s.frameworks = 'Foundation'
  s.swift_version = "4.0"
end
# pod spec lint ELSwiftJsonParser.podspec
# pod trunk push ELSwiftJsonParser.podspec