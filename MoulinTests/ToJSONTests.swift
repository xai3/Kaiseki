//
//  ToJSONTests.swift
//  Moulin
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

import XCTest
@testable import Moulin

class ToJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBasicValueType() {
        let object = Object()
        object.boolTrue.value = true
        object.boolFalse.value = false
        object.int.value = 1
        object.float.value = 10
        object.double.value = 100
        
        let json = object.toJSON() as? [String: AnyObject]
        XCTAssertNotNil(json)
        XCTAssertEqual(json!["boolTrue"] as? Bool, true)
        XCTAssertEqual(json!["boolFalse"] as? Bool, false)
        XCTAssertEqual(json!["int"] as? Int, 1)
        XCTAssertEqual(json!["float"] as? Float, 10)
        XCTAssertEqual(json!["double"] as? Double, 100)
    }
    
    func testArray() {
        let object = Object()
        object.boolTrue.value = true
        object.arrayBool.value = [true, false, true]
        object.arrayObject.value = [1, 2].map {
            let object = Object()
            object.int.value = $0
            return object
        }
        
        let json = object.toJSON() as? [String: AnyObject]
        XCTAssertEqual((json!["arrayBool"] as? [Bool])!, [true, false, true])
        XCTAssertEqual((json!["arrayObject"] as? [[String: AnyObject]])!.flatMap { $0["int"] as? Int }, [1, 2])
    }
    
}
