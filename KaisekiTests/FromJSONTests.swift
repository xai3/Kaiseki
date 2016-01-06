//
//  FromJSONTests.swift
//  Kaiseki
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import XCTest
@testable import Kaiseki

class FromJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBasicValueType() {
        let json: [String: AnyObject] = [
            "bool_true": true,
            "bool_false": false,
            "bool_null": NSNull(),
            "int": 1,
            "int_null": NSNull(),
            "int_invalid": "1",
            "float": 10,
            "float_null": NSNull(),
            "float_invalid": "10",
            "double": 100,
            "double_null": NSNull(),
            "double_invalid": "10",
            "string": "test",
            "string_null": NSNull(),
            "string_invalid": 1,
            "undefined": "undefined"
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.boolTrue.value, true)
        XCTAssertEqual(object.boolFalse.value, false)
        XCTAssertNil(object.boolNull.value)
        XCTAssertEqual(object.int.value, 1)
        XCTAssertNil(object.intNull.value)
        XCTAssertNil(object.intInvalid.value)
        XCTAssertEqual(object.float.value, 10.0)
        XCTAssertNil(object.floatNull.value)
        XCTAssertNil(object.floatInvalid.value)
        XCTAssertEqual(object.double.value, 100.0)
        XCTAssertNil(object.doubleNull.value)
        XCTAssertNil(object.doubleInvalid.value)
        XCTAssertEqual(object.string.value, "test")
        XCTAssertNil(object.stringNull.value)
        XCTAssertNil(object.stringInvalid.value)
    }
    
    func testNestedEntity() {
        let json: [String: AnyObject] = [
            "object": ["int": 1,],
            "object_null": NSNull(),
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.object.value!.int.value, 1)
        XCTAssertNil(object.objectNull.value)
    }
    
    func testArray() {
        let json: [String: AnyObject] = [
            "array_bool": [true, false, true],
            "array_object": [["int": 1], ["int": 2]],
            "array_empty": [],
            "array_invalid": ["a", "b", "c"],
            "array_null": NSNull(),
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.arrayBool.value, [true, false, true])
        XCTAssertEqual((object.arrayObject.value.flatMap { $0.int.value }), [1, 2])
        XCTAssertEqual(object.arrayEmpty.value, [])
        XCTAssertEqual(object.arrayInvalid.value, [])
        XCTAssertNil(object.arrayNull.value)
    }
    
    func testCustomKey() {
        let json: [String: AnyObject] = [
            "custom_key_int_tests": 1,
            "custom_key_string_tests": "custom",
            "custom_key_array_tests": [true, false]
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.customKeyInt.value, 1)
        XCTAssertEqual(object.customKeyString.value, "custom")
        XCTAssertEqual(object.customKeyArray.value, [true, false])
    }
    
    func testDefaultValue() {
        let json: [String: AnyObject] = [
            "bool_default": NSNull(),
            "int_default": NSNull(),
            "float_default": NSNull(),
            "double_default": NSNull(),
            "string_default": NSNull(),
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.boolDefault.value, true)
        XCTAssertEqual(object.intDefault.value, 100)
        XCTAssertEqual(object.floatDefault.value, 200)
        XCTAssertEqual(object.doubleDefault.value, 300)
        XCTAssertEqual(object.stringDefault.value, "default")
    }
    
    func testValueChanged() {
        var called1 = false
        var called2 = false
        
        let object = Object()
        object.boolTrue.valueChanged = { property, value in
            called1 = true
            XCTAssertEqual(value, true)
        }
        object.arrayBool.valueChanged = { property, value in
            called2 = true
            XCTAssertEqual(value, [true, false, true])
        }
        
        object.boolTrue.value = true
        object.arrayBool.value = [true, false, true]
        
        XCTAssertTrue(called1)
        XCTAssertTrue(called2)
    }
    
}