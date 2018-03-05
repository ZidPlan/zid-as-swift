//
//  ZidSwiftTests.swift
//  ZidSwiftTests
//
//  Created by Ryan Latta on 6/20/16.
//  Copyright © 2016 ZidPlan. All rights reserved.
//

import XCTest
import ZidSwift

class ZidSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreatesZidWithLength() {
        let data:NSData = ZID.create(8)
        XCTAssert(data.length == 1)
    }
    
    func testCreatesStringFromZid() {
        let data:NSData = ZID.create(8)
        let string = ZID.toString(data)
        XCTAssert(string.characters.count == 2)
    }

}
