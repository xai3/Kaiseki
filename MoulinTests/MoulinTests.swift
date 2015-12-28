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
    let string = Property<String>()
    let stringNull = Property<String>()
    let stringInvalid = Property<String>()
    
    let object = Property<Object>()
    let objectNull = Property<Object>()
    
    let arrayBool = PropertyArray<Bool>()
    let arrayObject = PropertyArray<Object>()
    let arrayEmpty = PropertyArray<Int>()
    let arrayNull = PropertyArray<Int>()
    
    let customKeyInt = Property<Int>(key: "customKeyIntTests")
    let customKeyString = Property<String>(key: "customKeyStringTests")
    let customKeyArray = PropertyArray<Bool>(key: "customKeyArrayTests")
    
    // Default value
    let boolDefault = Property<Bool>(true)
    let intDefault = Property<Int>(100)
    let floatDefault = Property<Float>(Float(200))
    let doubleDefault = Property<Double>(300)
    let stringDefault = Property<String>("default")
}
