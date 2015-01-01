//
//  CoreDataTests.swift
//  GPS Data
//
//  Created by Maciek on 01.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

import UIKit
import XCTest

class CoreDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //[MagicalRecord setupCoreDataStackWithInMemoryStore
//        MagicalRecord.setDefaultModelFromClass(Position.self)
        MagicalRecord.setupCoreDataStackWithInMemoryStore()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreationOfEntity() {
        // This is an example of a functional test case.
        let p = Position.MR_createEntity() as Position
        p.altitude = 441;
        
        XCTAssertNotNil(p, "Position must not be nil")
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
