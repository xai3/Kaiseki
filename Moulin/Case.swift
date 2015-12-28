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
    case Pascal
    
    static var defaultCase: Case {
        return .Snake
    }
    
    func convert(string: String) -> String {
        switch self {
        case .Snake:
            return snakeCase(string)
        case .Camel:
            return camelCase(string)
        case .Pascal:
            return pascalCase(string)
        }
    }
    
    private func snakeCase(string: String) -> String {
        // TODO: Imp
        return string
    }
    
    private func camelCase(string: String) -> String {
        // TODO: Imp
        return string
    }
    
    private func pascalCase(string: String) -> String {
        // TODO: Imp
        return string
    }
}
