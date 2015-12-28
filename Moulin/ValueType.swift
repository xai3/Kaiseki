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
}

extension Int: ValueType { }
extension Float: ValueType { }
extension Double: ValueType { }
extension String: ValueType { }
