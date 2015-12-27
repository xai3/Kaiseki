//
//  Property.swift
//  Moulin
//
//  Created by asai.yuki on 2015/12/27.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

protocol PropertyType: JSONConvertible {
    var key: String? { get }
    var stringCase: StringCase? { get }
    
    func keyWith(key: String) -> String
}

extension PropertyType {
    func keyWith(name: String) -> String {
        if let key = self.key {
            return key
        }
        let stringCase = self.stringCase ?? StringCase.defaultCase
        return stringCase.convert(name)
    }
}

public class Property<T: ValueType>: PropertyType {
    public var value: T?
    
    var key: String?
    var stringCase: StringCase?
    
    public init(key: String? = nil, stringCase: StringCase? = nil) {
        self.key = key
        self.stringCase = stringCase
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

public enum StringCase {
    case Snake
    case Camel
    
    static var defaultCase: StringCase {
        return .Snake
    }
    
    func convert(string: String) -> String {
        // TODO: Imp
        return string
    }
}

public protocol ValueType {
    init()
}

extension Int: ValueType { }
extension Float: ValueType { }
extension Double: ValueType { }
extension String: ValueType { }

