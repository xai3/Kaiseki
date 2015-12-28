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
            "undefined": "undefined"]
        
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
    
    class Object: Entity {
        let boolTrue = Property<Bool>()
        let boolFalse = Property<Bool>()
        let boolNull = Property<Bool>()
        let int = Property<Int>()
        let intNull = Property<Int>()
        let intInvalid = Property<Int>()
        let float = Property<Float>()
        let floatNull = Property<Float>()
        let floatInvalid = Property<Float>()
        let double = Property<Double>()
        let doubleNull = Property<Double>()
        let doubleInvalid = Property<Double>()
        
        let object = Property<Object>()
        let objectNull = Property<Object>()
        
        let arrayBool = PropertyArray<Bool>()
        let arrayObject = PropertyArray<Object>()
        let arrayEmpty = PropertyArray<Int>()
        let arrayNull = PropertyArray<Int>()
        
        let customKeyInt = Property<Int>(key: "customKeyIntTests")
        let customKeyString = Property<String>(key: "customKeyStringTests")
        let customKeyArray = PropertyArray<Bool>(key: "customKeyArrayTests")
    }
    
}