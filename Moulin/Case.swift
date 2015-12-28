//
//  Case.swift
//  Moulin
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public enum Case {
    case Snake
    case Camel
    
    static var defaultCase: Case {
        return .Snake
    }
    
    func convert(string: String) -> String {
        // TODO: Imp
        return string
    }
}
