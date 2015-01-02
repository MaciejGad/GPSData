//
//  HandoffTests.swift
//  GPS Data
//
//  Created by Maciek on 02.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

import UIKit
import XCTest

class HandoffTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSingleton() {
        let manager: HandoffManager = HandoffManager.sharedInstance
        XCTAssertNotNil(manager, "Should not be nil")
        XCTAssertEqual(manager, HandoffManager.sharedInstance, "shared instance should return the same object")
    }
    
    func testSetURL() {
        // This is an example of a functional test case.
        let manager = HandoffManager.sharedInstance
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
