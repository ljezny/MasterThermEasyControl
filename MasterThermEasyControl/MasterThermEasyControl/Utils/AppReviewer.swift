//
//  AppReviewer.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 21/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

import Foundation
import StoreKit


let runIncrementerSetting = "numberOfRuns"  // UserDefauls dictionary key where we store number of runs
let minimumRunCount = 2                     // Minimum number of runs that we should have until we ask for review

func incrementAppRuns() {                   // counter for number of runs for the app. You can call this from App Delegate
    
    let usD = UserDefaults()
    let runs = getRunCounts() + 1
    usD.setValuesForKeys([runIncrementerSetting: runs])
    usD.synchronize()
    
}

func getRunCounts () -> Int {               // Reads number of runs from UserDefaults and returns it.
    
    let usD = UserDefaults()
    let savedRuns = usD.value(forKey: runIncrementerSetting)
    
    var runs = 0
    if (savedRuns != nil) {
        
        runs = savedRuns as! Int
    }
    
    print("Run Counts are \(runs)")
    return runs
    
}

func showReview() {
    
    let runs = getRunCounts()
    print("Show Review")
    
    if (runs > minimumRunCount) {
        SKStoreReviewController.requestReview()
    } 
    
}
