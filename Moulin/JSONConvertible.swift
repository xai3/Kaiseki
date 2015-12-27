//
//  JSONConvertible.swift
//  Moulin
//
//  Created by asai.yuki on 2015/12/27.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public protocol JSONConvertible {
    func fromJSON(json: AnyObject)
    func toJSON() -> AnyObject
}
