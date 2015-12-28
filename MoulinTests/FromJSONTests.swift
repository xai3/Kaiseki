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
        
        let object = Object()
        object.fromJSON(json)
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
        
        let object = Object()
        object.fromJSON(json)
        XCTAssertEqual(object.object.value?.int.value, 1)
        XCTAssertNil(object.objectNull.value)
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
    }
    
}