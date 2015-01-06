//
//  HttpTests.swift
//  GPS Data
//
//  Created by Maciek on 05.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

import UIKit
import XCTest

class HttpTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testSingleton() {
        let manager: HttpManager = HttpManager.sharedInstance
        XCTAssertNotNil(manager, "Should not be nil")
        XCTAssertEqual(manager, HttpManager.sharedInstance, "shared instance should return the same object")
    }
}
