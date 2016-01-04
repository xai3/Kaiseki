//
//  MoulinTests.swift
//  MoulinTests
//
//  Created by asai.yuki on 2015/12/27.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import XCTest
@testable import Moulin

class MoulinTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
    }
    
}

class Object: Entity {
    let boolTrue = Property<Bool>()
    let boolFalse = Property<Bool>()
    let boolNull = Property<Bool?>(false)
    let int = Property<Int>()
    let intNull = Property<Int?>(999)
    let intInvalid = Property<Int?>()
    let float = Property<Float>()
    let floatNull = Property<Float?>(Float(999))
    let floatInvalid = Property<Float?>()
    let double = Property<Double>()
    let doubleNull = Property<Double?>(999)
    let doubleInvalid = Property<Double?>()
    let string = Property<String>()
    let stringNull = Property<String?>("999")
    let stringInvalid = Property<String?>()
    
    let object = Property<Object?>()
    let objectNull = Property<Object?>()
    
    let arrayBool = Property<[Bool]>()
    let arrayObject = Property<[Object]>()
    let arrayEmpty = Property<[Int]>()
    let arrayInvalid = Property<[Int]>()
    let arrayNull = Property<[Int]?>([1, 2, 3])
    
    let customKeyInt = Property<Int>(key: "custom_key_int_tests")
    let customKeyString = Property<String>(key: "custom_key_string_tests")
    let customKeyArray = Property<[Bool]>(key: "custom_key_array_tests")
    
    // Default value
    let boolDefault = Property<Bool>(true)
    let intDefault = Property<Int>(100)
    let floatDefault = Property<Float>(Float(200))
    let doubleDefault = Property<Double>(300)
    let stringDefault = Property<String>("default")
}
