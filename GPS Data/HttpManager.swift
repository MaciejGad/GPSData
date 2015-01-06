//
//  HttpManager.swift
//  GPS Data
//
//  Created by Maciek on 05.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

import Foundation

class HttpManager: Equatable {
    class var sharedInstance: HttpManager {
        struct Static {
            static let instance: HttpManager = HttpManager()
        }
        return Static.instance
    }
}

func == (lhs: HttpManager, rhs: HttpManager) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}