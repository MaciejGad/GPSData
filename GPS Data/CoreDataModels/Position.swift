//
//  Position.swift
//  GPS Data
//
//  Created by Maciek on 01.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

import Foundation
import CoreData

@objc(Position)
class Position: NSManagedObject {

    @NSManaged var longitude: NSNumber
    @NSManaged var latitude: NSNumber
    @NSManaged var altitude: NSNumber
    @NSManaged var accuracyOfAltitude: NSNumber
    @NSManaged var accuracyOfLatitude: NSNumber
    @NSManaged var accuracyOfLongitude: NSNumber
    @NSManaged var time: NSDate

}
