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

    class MockUIResponder: UIResponder {
        var mockUserActivity:MockNSUserActivity?
        var validateUserActivity:((userActivity:NSUserActivity?) -> Void)?
        override var userActivity: NSUserActivity? {
            set{
                if let validateUserActivity = validateUserActivity {
                    validateUserActivity(userActivity: newValue)
                }
                if let newValue = newValue {
                    let mockUserActivity = MockNSUserActivity(activityType: newValue.activityType)
                    mockUserActivity.title = newValue.title
                    mockUserActivity.webpageURL = newValue.webpageURL
                    mockUserActivity.userInfo = newValue.userInfo
                    self.mockUserActivity = mockUserActivity
                }
            }
            get {
               return mockUserActivity
            }
        }
    }
    
    class MockNSUserActivity: NSUserActivity {
        var timesBecameCurrent = 0
        override func becomeCurrent() {
            timesBecameCurrent += 1
        }
    }
    
    func createValidateFor(name:String?, url:NSURL?, userInfo:NSDictionary?, activityType:String?) -> ((userActivity:NSUserActivity?) -> Void) {
        return {
            userActivity in
            XCTAssertNotNil(userActivity, "user activity should not be nil")
            if let userActivity = userActivity {
                if let name = name {
                    XCTAssertNotNil(userActivity.title, "user activity title should not be nil")
                    if let title = userActivity.title {
                        XCTAssertEqual(title, name , "user activity title should be " + name)
                    }
                }
                if let url = url {
                     XCTAssertNotNil(userActivity.webpageURL, "user activity webpageURL should not be nil")
                    if let webpageURL = userActivity.webpageURL {
                        XCTAssertEqual(webpageURL, url , "user activity title should be " + url.absoluteString!)
                    }
                }
                if let userInfo = userInfo {
                    XCTAssertNotNil(userActivity.userInfo, "activity user info should not be nil")
                    if let activityUserInfo = userActivity.userInfo {
                        XCTAssertEqual(userInfo.count, activityUserInfo.count, "User infos should have the same size")
                        if(userInfo.count == activityUserInfo.count) {
                            for (key, value) in userInfo {
                                let userKey = key as NSObject
                                let userValue = value as NSObject
                                let activityValue: NSObject? = activityUserInfo[userKey] as? NSObject
                                XCTAssertNotNil(activityValue, "value for key \(userKey) is nil")
                                if let activityValue = activityValue {
                                    XCTAssertEqual(userValue, activityValue, "value for key \(userKey) differs, test: \(userValue), activity:\(activityValue)")
                                }
                            }
                        }
                    }
                }
                if let activityType = activityType {
                    XCTAssertEqual(userActivity.activityType, activityType, "User activity type should be \(activityType) not \(userActivity.activityType)")
                }
            }
        }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSingleton() {
        let manager: HandoffManager = HandoffManager.sharedInstance
        XCTAssertNotNil(manager, "Should not be nil")
        XCTAssertEqual(manager, HandoffManager.sharedInstance, "shared instance should return the same object")
    }
    
    func testSetName() {
        let manager = HandoffManager.sharedInstance
        let mockResponder = MockUIResponder()
        let name = "Test name"
        mockResponder.validateUserActivity = createValidateFor(name, url: nil, userInfo:nil, activityType:nil)
        manager.delegate = mockResponder
        manager.set(name)
    }

    func testSetNameBeforDelegate() {
        let manager = HandoffManager.sharedInstance
        let mockResponder = MockUIResponder()
        let name = "Test name"
        mockResponder.validateUserActivity = createValidateFor(name, url: nil, userInfo:nil, activityType:nil)
        manager.set(name)
        manager.delegate = mockResponder
        mockResponder.validateUserActivity?(userActivity: mockResponder.userActivity)
    }
    
    func testSetUrl() {
        let manager = HandoffManager.sharedInstance
        let mockResponder = MockUIResponder()
        let name = "Test name"
        let url = NSURL(string: "http://google.pl")
        mockResponder.validateUserActivity = createValidateFor(name, url: url, userInfo:nil, activityType:nil)
        manager.delegate = mockResponder
        manager.set(name, url: url)
    }
    
    func testSetUrlBeforDelegate() {
        let manager = HandoffManager.sharedInstance
        let mockResponder = MockUIResponder()
        let name = "Test name"
        let url = NSURL(string: "http://google.pl")
        mockResponder.validateUserActivity = createValidateFor(name, url: url, userInfo:nil, activityType:nil)
        manager.set(name, url: url)
        manager.delegate = mockResponder
        mockResponder.validateUserActivity?(userActivity: mockResponder.userActivity)
    }
    
    func testSetUserInfo() {
        let manager = HandoffManager.sharedInstance
        let mockResponder = MockUIResponder()
        let name = "Test name"
        let userInfo = ["test": "dziala"]
        mockResponder.validateUserActivity = createValidateFor(name, url: nil, userInfo:userInfo, activityType:nil)
        manager.delegate = mockResponder
        manager.set(name, url: nil, userInfo:userInfo)
       
    }
    
    func testSetActivityType() {
        let manager = HandoffManager.sharedInstance
        let mockResponder = MockUIResponder()
        let name = "Test name"
        let type = "pl.test.type"
        mockResponder.validateUserActivity = createValidateFor(name, url: nil, userInfo:nil, activityType:type)
        manager.delegate = mockResponder
        manager.set(name, url: nil, userInfo: nil, activityType: type)
    }
    
    func testSetAll() {
        let manager = HandoffManager.sharedInstance
        let mockResponder = MockUIResponder()
        let name = "Test name"
        let userInfo = ["test": "dziala"]
        let url = NSURL(string: "http://google.pl")
        let type = "pl.test.type"
        mockResponder.validateUserActivity = createValidateFor(name, url: url, userInfo:userInfo, activityType:type)
        manager.delegate = mockResponder
        manager.set(name, url: url, userInfo: userInfo, activityType: type)
    }
    
    func testWeakDelegate() {
        let manager = HandoffManager.sharedInstance
        var mockResponder: MockUIResponder? = MockUIResponder()
        manager.delegate = mockResponder
        XCTAssertNotNil(manager.delegate, "manager delegate should not be nil")
        mockResponder = nil
        XCTAssertNil(manager.delegate, "manager delegate should be nil")
    }
}
