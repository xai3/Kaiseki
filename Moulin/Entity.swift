//
//  Entity.swift
//  Moulin
//
//  Created by asai.yuki on 2015/12/27.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public class Entity: JSONConvertible, ValueType {
    typealias ReflectedProperty = (label: String, property: PropertyType)
    
    required public init() { }
    
    convenience init(json: AnyObject) {
        self.init()
        fromJSON(json)
    }
    
    private lazy var reflectedProperties: [ReflectedProperty] = {
        return Mirror(reflecting: self).children.filter { $1 is PropertyType }.flatMap { ($0!, $1 as! PropertyType) }
    }()
    
    
    public static func valueFromJSON(json: AnyObject?) -> Self? {
        return valueFromJSONHelper(json)
    }
    
    private static func valueFromJSONHelper<T>(json: AnyObject?) -> T? {
        guard let unwrappedJson = json else {
            return nil
        }
        let entity = self.init()
        entity.fromJSON(unwrappedJson)
        return entity as? T
    }
    
    public func valueToJSON() -> AnyObject? {
        return toJSON()
    }
   
    public func fromJSON(json: AnyObject) {
        guard let dic = json as? [String: AnyObject] else {
            // TODO: Imp not dictionary case
            return
        }
        reflectedProperties.forEach {
            let key = $1.keyWith($0)
            if let value = dic[key] {
                $1.fromJSON(value)
            }
        }
    }
    
    public func toJSON() -> AnyObject? {
        return reflectedProperties.reduce([String: AnyObject]()) { (var json: [String: AnyObject], reflectedProperty: ReflectedProperty) -> [String: AnyObject] in
            let key = reflectedProperty.property.keyWith(reflectedProperty.label)
            json[key] = reflectedProperty.property.toJSON()
            return json
        }
    }
}
