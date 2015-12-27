//
//  Entity.swift
//  Moulin
//
//  Created by asai.yuki on 2015/12/27.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

class Entity: JSONConvertible {
    required init() { }
    
    func fromJSON(json: AnyObject) {
        guard let dic = json as? [String: AnyObject] else {
            // TODO: Imp not dictionary case
            return
        }
        Mirror(reflecting: self).children.filter { $1 is PropertyType }.flatMap { ($0, $1 as! PropertyType) }.forEach {
            let key = $1.keyWith($0!)
            if let value = dic[key] {
                $1.fromJSON(value)
            }
        }
    }
    
    func toJSON() -> AnyObject {
        // TODO: Imp
        return Int()
    }
}

extension Entity: ValueType { }
