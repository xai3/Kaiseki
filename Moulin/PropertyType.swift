//
//  PropertyType.swift
//  Moulin
//
//  Created by Asai.Yuki on 2015/12/28.
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
