//
//  ToJSONTests.swift
//  Kaiseki
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

import XCTest
@testable import Kaiseki

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
        object.boolNull.value = nil
        object.int.value = 1
        object.intNull.value = nil
        object.float.value = 10
        object.floatNull.value = nil
        object.double.value = 100
        object.doubleNull.value = nil
        
        let json = object.toJSON() as? [String: AnyObject]
        XCTAssertNotNil(json)
        XCTAssertEqual(json!["bool_true"] as? Bool, true)
        XCTAssertEqual(json!["bool_false"] as? Bool, false)
        XCTAssertNil(json!["bool_null"])
        XCTAssertEqual(json!["int"] as? Int, 1)
        XCTAssertNil(json!["int_null"])
        XCTAssertEqual(json!["float"] as? Float, 10)
        XCTAssertNil(json!["float_null"])
        XCTAssertEqual(json!["double"] as? Double, 100)
        XCTAssertNil(json!["double_null"])
    }
    
    func testNestedEntity() {
        let object = Object()
        object.object.value = {
            let object = Object()
            object.int.value = 1
            return object
        }()
        object.objectNull.value = nil
        
        guard let json = object.toJSON() as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual((json["object"] as? [String: AnyObject])?["int"] as? Int, 1)
        XCTAssertNil(json["object_null"])
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
        XCTAssertEqual((json!["array_bool"] as? [Bool])!, [true, false, true])
        XCTAssertEqual((json!["array_object"] as? [[String: AnyObject]])!.flatMap { $0["int"] as? Int }, [1, 2])
    }
    
    func testCustomKey() {
        let object = Object()
        object.customKeyInt.value = 1
        object.customKeyString.value = "custom"
        object.customKeyArray.value = [true, false, true]
        
        guard let json = object.toJSON() as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(json["custom_key_int_tests"] as? Int, 1)
        XCTAssertEqual(json["custom_key_string_tests"] as? String, "custom")
        XCTAssertEqual((json["custom_key_array_tests"] as? [Bool])!, [true, false, true])
    }
    
    func testDefaultValue() {
        let object = Object()
        
        guard let json = object.toJSON() as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertEqual(json["bool_default"] as? Bool, true)
        XCTAssertEqual(json["int_default"] as? Int, 100)
        XCTAssertEqual(json["float_default"] as? Float, 200)
        XCTAssertEqual(json["double_default"] as? Double, 300)
        XCTAssertEqual(json["string_default"] as? String, "default")
    }
    
    func testFilledWithNull() {
        let object = Object()
        object.intNull.value = nil
        object.filledWithNull.value = nil
        object.filledWithNullNonOpt.value = 0
        
        guard let json = object.toJSON() as? [String: AnyObject] else {
            XCTFail()
            return
        }
        XCTAssertNil(json["int_null"])
        XCTAssertNotNil(json["filled_with_null"] as? NSNull)
        XCTAssertNil(json["filled_with_null_non_opt"] as? NSNull)
    }
    
}
