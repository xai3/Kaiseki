//
//  Property.swift
//  Moulin
//
//  Created by asai.yuki on 2015/12/27.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public class Property<T: ValueType>: PropertyType {
    public var value: T?
    
    var key: String?
    var keyCase: Case?
    
    public init(key: String? = nil, keyCase: Case? = nil) {
        self.key = key
        self.keyCase = keyCase
    }
    
    public func fromJSON(json: AnyObject) {
        if let value = json as? T {
            self.value = value
            return
        }
        
        let value = T()
        if let jsonConvertible = value as? JSONConvertible {
            jsonConvertible.fromJSON(json)
        }
        self.value = value
    }
    
    public func toJSON() -> AnyObject {
        // TODO: Imp
        return Int()
    }
}
