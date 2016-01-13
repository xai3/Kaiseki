//
//  Property.swift
//  Kaiseki
//
//  Created by asai.yuki on 2015/12/27.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public class Property<Value: ValueType>: PropertyType {
    public typealias ValueChanged = (Property<Value>, Value) -> Void
    
    public var value: Value {
        didSet {
            valueChanged?(self, value)
        }
    }
    
    var key: String?
    var keyCase: Case?
    var filledWithNull: Bool
    var valueChanged: ValueChanged?
    
    public init(_ value: Value = Value.defaultValue(), key: String? = nil, keyCase: Case? = nil, filledWithNull: Bool = false, valueChanged: ValueChanged? = nil) {
        self.value = value
        self.key = key
        self.keyCase = keyCase
        self.filledWithNull = filledWithNull
        self.valueChanged = valueChanged
    }
    
    public func fromJSON(json: AnyObject) {
        if json is NSNull {
            if let value = Value.fromJSON(nil) where Value.isOptional {
                self.value = value
            }
            return
        }
        
        if let value = Value.fromJSON(json) {
            self.value = value
        }
    }
    
    public func toJSON() -> AnyObject? {
        if let json = value.toJSON() {
            return json
        }
        
        if filledWithNull && Value.isOptional {
            return NSNull()
        }
        
        return nil
    }
}
