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
        let json: [String: AnyObject] = ["id": 1, "name": "yuki", "friend" : ["id": 2, "name": "asai"]]
        
        class User: Entity {
            let id = Property<Int>()
            let name = Property<String>()
            let friend = Property<User>()
        }
        let user = User()
        user.fromJSON(json)
        
        XCTAssertEqual(user.id.value, 1)
        XCTAssertEqual(user.name.value, "yuki")
        XCTAssertEqual(user.friend.value?.id.value, 2)
        XCTAssertEqual(user.friend.value?.name.value, "asai")
    }
    
}
