//
//  CaseTests.swift
//  Mulan
//
//  Created by asai.yuki on 2015/12/29.
//  Copyright © 2015年 yukiasai. All rights reserved.
//

import Foundation

import XCTest
@testable import Mulan

class CaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOriginal() {
        XCTAssertEqual(Case.Original.convert("intValue"), "intValue")
        XCTAssertEqual(Case.Original.convert("int_value"), "int_value")
    }
    
    func testSnakeCase() {
        XCTAssertEqual(Case.Snake.convert("intValue"), "int_value")
        XCTAssertEqual(Case.Snake.convert("intValueMax"), "int_value_max")
        XCTAssertEqual(Case.Snake.convert("fromJSON"), "from_json")
        XCTAssertEqual(Case.Snake.convert("JSONString"), "json_string")
    }
}