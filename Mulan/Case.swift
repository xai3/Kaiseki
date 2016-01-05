//
//  Case.swift
//  Mulan
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

public enum Case {
    case Original
    case Snake
    
    // TODO:
    //    case Camel
    //    case Pascal
    
    static var defaultCase: Case {
        return .Snake
    }
    
    func convert(string: String) -> String {
        switch self {
        case .Original:
            return string
        case .Snake:
            return snakeCase(string)
        }
    }
    
    private func snakeCase(string: String) -> String {
        return ["[A-Z]{1}[a-z0-9]+", "[A-Z]{2,}"]
            .reduce(string) {
                return $0.stringByReplacingOccurrencesOfString($1, withString: "_$0", options: .RegularExpressionSearch, range: nil)
            }
            .lowercaseString
            .stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "_"))
    }
}
