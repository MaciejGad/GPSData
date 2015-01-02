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
    
    func setURL(url: NSURL) {
        
    }
}

func == (lhs: HandoffManager, rhs: HandoffManager) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}