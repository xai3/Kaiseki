//
//  ValueType.swift
//  Moulin
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public protocol ValueType {
    init()
    
    static func valueFromJSON(json: AnyObject?) -> Self?
    
    // For Optional<Wrapped>
    static var isOptional: Bool { get }
}

extension ValueType {
    public static func valueFromJSON(json: AnyObject?) -> Self? {
        return json as? Self
    }
    
    public static var isOptional: Bool {
        return false
    }
}


extension Bool: ValueType { }
extension Int: ValueType { }
extension Float: ValueType { }
extension Double: ValueType { }
extension String: ValueType { }

extension Optional: ValueType {
    public static func valueFromJSON(json: AnyObject?) -> Wrapped?? {
        guard let valueType = Wrapped.self as? ValueType.Type,
            let value = valueType.valueFromJSON(json),
            let wrapped = value as? Wrapped else {
                return .Some(.None)
        }
        return .Some(.Some(wrapped))
    }
    
    public static var isOptional: Bool {
        return true
    }
}

extension Array: ValueType {
    public static func valueFromJSON(json: AnyObject?) -> [Element]? {
        guard let arr = json as? [AnyObject] else {
            return nil
        }
        
        guard let valueType = Element.self as? ValueType.Type else {
            return nil
        }
        
        return arr.flatMap { valueType.valueFromJSON($0) as? Element }
    }
}
