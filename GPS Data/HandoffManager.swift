//
//  HandoffManager.swift
//  GPS Data
//
//  Created by Maciek on 02.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

import Foundation

class HandoffManager: Equatable {
    class var sharedInstance: HandoffManager {
        struct Static {
            static let instance: HandoffManager = HandoffManager()
        }
        return Static.instance
    }
    
    var delegate:UIResponder? {
        didSet {
            if let delegte = delegate {
                if let name = name {
                    set(name, url: url, userInfo: userInfo, activityType: activityType)
                }
            }
        }
    }
    var url:NSURL?
    var name:String?
    var userInfo:NSDictionary?
    var activityType:String?
    
    func set(name:String) {
        set(name, url:nil)
    }
    func set(name:String, url: NSURL?) {
        set(name, url:url, userInfo:nil)
    }
    func set(name:String, url:NSURL?, userInfo:NSDictionary?){
        let bundle = NSBundle(forClass: HandoffManager.self)
        set(name, url: url, userInfo: userInfo, activityType: bundle.bundleIdentifier)
    }
    func set(name:String, url:NSURL?, userInfo:NSDictionary?, activityType:String?){
        self.url = url
        self.name = name
        self.userInfo = userInfo
        self.activityType = activityType
        if let delegate = delegate {
            var activityTypeValue:String
            if (activityType != nil) {
                activityTypeValue = activityType!
            } else {
                activityTypeValue = "pl.maciejgad.gpsdata"
            }
            let activity = NSUserActivity(activityType: activityTypeValue)
            activity.title = name
            if let url = url {
                activity.webpageURL = url
            }
            if let userInfo = userInfo {
                activity.userInfo = userInfo
            }
            delegate.userActivity = activity
            delegate.userActivity?.becomeCurrent()
            self.name = nil
            self.url = nil
            self.activityType = nil
        }
    }
}

func == (lhs: HandoffManager, rhs: HandoffManager) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}