//
//  ValueType.swift
//  Kaiseki
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

public protocol ValueType {
    static func defaultValue() -> Self
    
    static func fromJSON(json: AnyObject?) -> Self?
    func toJSON() -> AnyObject?
    
    // For Optional<Wrapped>
    static var isOptional: Bool { get }
}

extension ValueType {
    public static func fromJSON(json: AnyObject?) -> Self? {
        return json as? Self
    }
    
    public func toJSON() -> AnyObject? {
        return self as? AnyObject
    }
    
    public static var isOptional: Bool {
        return false
    }
}

extension Bool: ValueType {
    public static func defaultValue() -> Bool { return false }
}

extension Int: ValueType {
    public static func defaultValue() -> Int { return 0 }
}

extension Float: ValueType {
    public static func defaultValue() -> Float { return 0 }
}

extension Double: ValueType {
    public static func defaultValue() -> Double { return 0 }
}

extension String: ValueType {
    public static func defaultValue() -> String { return "" }
}

extension Optional: ValueType { // TODO: where Wrapped: ValueType
    public static func defaultValue() -> Wrapped? {
        return nil
    }
    
    public static func fromJSON(json: AnyObject?) -> Wrapped?? {
        guard let valueType = Wrapped.self as? ValueType.Type,
            let value = valueType.fromJSON(json),
            let wrapped = value as? Wrapped else {
                return .Some(.None)
        }
        return .Some(.Some(wrapped))
    }
    
    public func toJSON() -> AnyObject? {
        switch self {
        case .Some(let wrapped):
            guard let value = wrapped as? ValueType else {
                return nil
            }
            return value.toJSON()
        case .None:
            return nil
        }
    }
    
    public static var isOptional: Bool {
        return true
    }
}

extension Array: ValueType { // TODO: where Element: ValueType
    public static func defaultValue() -> [Element] {
        return []
    }
    
    public static func fromJSON(json: AnyObject?) -> [Element]? {
        guard let arr = json as? [AnyObject] else {
            return nil
        }
        
        guard let valueType = Element.self as? ValueType.Type else {
            return nil
        }
        
        return arr.flatMap { valueType.fromJSON($0) as? Element }
    }
    
    public func toJSON() -> AnyObject? {
        return flatMap { element -> AnyObject? in
            guard let value = element as? ValueType else {
                return nil
            }
            return value.toJSON()
        }
    }
}

// MARK: For enum

extension ValueType where Self: RawRepresentable {
    public static func fromJSON(json: AnyObject?) -> Self? {
        guard let value = json as? Self.RawValue else {
            return nil
        }
        return self.init(rawValue: value)
    }
    
    public func toJSON() -> AnyObject? {
        return rawValue as? AnyObject
    }
}
