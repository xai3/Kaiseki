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
    public static var isOptional: Bool {
        return false
    }
}


extension Bool: ValueType {
    public static func valueFromJSON(json: AnyObject?) -> Bool? {
        return json as? Bool
    }
}

extension Int: ValueType {
    public static func valueFromJSON(json: AnyObject?) -> Int? {
        return json as? Int
    }
}

extension Float: ValueType {
    public static func valueFromJSON(json: AnyObject?) -> Float? {
        return json as? Float
    }
}

extension Double: ValueType {
    public static func valueFromJSON(json: AnyObject?) -> Double? {
        return json as? Double
    }
}

extension String: ValueType {
    public static func valueFromJSON(json: AnyObject?) -> String? {
        return json as? String
    }
}

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
