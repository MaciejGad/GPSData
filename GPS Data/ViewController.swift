//
//  ViewController.swift
//  GPS Data
//
//  Created by Maciek on 01.01.2015.
//  Copyright (c) 2015 Maciej Gad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startUserActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startUserActivity() {
        let activity = NSUserActivity(activityType: "pl.maciejgad.gpsdata")
        activity.title = "GPS Data"
        activity.webpageURL = NSURL(string: "http://maciejgad.pl")
        
        userActivity = activity
        userActivity?.becomeCurrent()
    }
    
//    override func updateUserActivityState(activity: NSUserActivity) {
//        activity.addUserInfoEntriesFromDictionary([ActivityItemsKey: items])
//        super.updateUserActivityState(activity)
//    }
    
    func stopUserActivity() {
        userActivity?.invalidate()
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        
    }
}

