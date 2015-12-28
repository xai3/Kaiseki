//
//  PropertyArray.swift
//  Moulin
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public class PropertyArray<T: ValueType>: PropertyType {
    public var value: [T]?
    
    var key: String?
    var keyCase: Case?
    
    public init(_ value: [T]? = nil, key: String? = nil, keyCase: Case? = nil) {
        self.value = value
        self.key = key
        self.keyCase = keyCase
    }
    
    public func fromJSON(json: AnyObject) {
        if json is NSNull {
            self.value = nil
            return
        }
        
        if json is [T] {
            self.value = json as? [T]
            return
        }
        
        guard let arr = json as? [AnyObject] else {
            self.value = nil
            return
        }
        
        self.value = arr.flatMap { json -> T? in
            let value = T()
            if let convertible = value as? JSONConvertible {
                convertible.fromJSON(json)
                return value
            }
            return nil
        }
        
    }
    
    public func toJSON() -> AnyObject {
        // TODO: Imp
        return Int()
    }
}
