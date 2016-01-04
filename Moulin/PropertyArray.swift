//
//  PropertyArray.swift
//  Moulin
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public class PropertyArray<T: ValueType>: PropertyType {
    public typealias Element = T
    public typealias Value = [Element]
    public typealias ValueChanged = (PropertyArray<Element>, Value?) -> Void
    
    public var value: Value? {
        didSet {
            valueChanged?(self, value)
        }
    }
    
    var key: String?
    var keyCase: Case?
    var valueChanged: ValueChanged?
    
    public init(_ value: Value? = nil, key: String? = nil, keyCase: Case? = nil, valueChanged: ValueChanged? = nil) {
        self.value = value
        self.key = key
        self.keyCase = keyCase
        self.valueChanged = valueChanged
    }
    
    public func fromJSON(json: AnyObject) {
        if json is NSNull {
            self.value = nil
            return
        }
        
        if json is [T] {
            self.value = json as? Value
            return
        }
        
        guard let arr = json as? [AnyObject] else {
            self.value = nil
            return
        }
        
        self.value = arr.flatMap { json -> Element? in
            let value = T()
            if let convertible = value as? JSONConvertible {
                convertible.fromJSON(json)
                return value
            }
            return nil
        }
        
    }
    
    public func toJSON() -> AnyObject? {
        return self.value?.flatMap { value -> AnyObject? in
            if let convertible = value as? JSONConvertible {
                return convertible.toJSON()
            }
            return value as? AnyObject
        }
    }
}
