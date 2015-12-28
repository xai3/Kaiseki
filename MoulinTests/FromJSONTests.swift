//
//  FromJSONTests.swift
//  Moulin
//
//  Created by Asai.Yuki on 2015/12/28.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import XCTest
@testable import Moulin

class FromJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBasicValueType() {
        let json: [String: AnyObject] = [
            "boolTrue": true,
            "boolFalse": false,
            "boolNull": NSNull(),
            "int": 1,
            "intNull": NSNull(),
            "intInvalid": "1",
            "float": 10,
            "floatNull": NSNull(),
            "floatInvalid": "10",
            "double": 100,
            "doubleNull": NSNull(),
            "doubleInvalid": "10",
            "string": "test",
            "stringNull": NSNull(),
            "stringInvalid": 1,
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
            "objectNull": NSNull(),
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.object.value?.int.value, 1)
        XCTAssertNil(object.objectNull.value)
    }
    
    func testArray() {
        let json: [String: AnyObject] = [
            "arrayBool": [true, false, true],
            "arrayObject": [["int": 1], ["int": 2]],
            "arrayEmpty": [],
            "arrayNull": NSNull(),
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.arrayBool.value!, [true, false, true])
        XCTAssertEqual((object.arrayObject.value?.flatMap { $0.int.value })!, [1, 2])
        XCTAssertEqual(object.arrayEmpty.value!, [])
        XCTAssertNil(object.arrayNull.value)
    }
    
    func testCustomKey() {
        let json: [String: AnyObject] = [
            "customKeyIntTests": 1,
            "customKeyStringTests": "custom",
            "customKeyArrayTests": [true, false]
        ]
        
        let object = Object(json: json)
        XCTAssertEqual(object.customKeyInt.value, 1)
        XCTAssertEqual(object.customKeyString.value, "custom")
        XCTAssertEqual(object.customKeyArray.value!, [true, false])
    }
    
    func testDefaultValue() {
        let json: [String: AnyObject] = [:]
        
        let object = Object(json: json)
        XCTAssertEqual(object.boolDefault.value, true)
        XCTAssertEqual(object.intDefault.value, 100)
        XCTAssertEqual(object.floatDefault.value, 200)
        XCTAssertEqual(object.doubleDefault.value, 300)
        XCTAssertEqual(object.stringDefault.value, "default")
    }
    
}