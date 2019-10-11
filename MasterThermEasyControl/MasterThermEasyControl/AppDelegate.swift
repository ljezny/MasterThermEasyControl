//
//  AppDelegate.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import CocoaLumberjack
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let mainViewController = MainViewController()

    var fileLoger: DDFileLogger?
    
    var logFileDataArray: [NSData] {
        get {
            let logFilePaths = fileLoger!.logFileManager.sortedLogFilePaths
            var logFileDataArray = [NSData]()
            for logFilePath in logFilePaths ?? [] {
                let fileURL = NSURL(fileURLWithPath: logFilePath)
                if let logFileData = try? NSData(contentsOf: fileURL as URL, options: NSData.ReadingOptions.mappedIfSafe) {
                    // Insert at front to reverse the order, so that oldest logs appear first.
                    logFileDataArray.insert(logFileData, at: 0)
                }
            }
            return logFileDataArray
        }
    }

    private func initLogger() -> DDFileLogger {
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
         
        let logger: DDFileLogger = DDFileLogger() // File Logger
        logger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        logger.logFileManager.maximumNumberOfLogFiles = 3
        DDLog.add(logger)
        
        return logger
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MSAppCenter.start("72f0b1f5-7156-4bb6-bfaa-dd2f0fd849c1", withServices:[
            MSAnalytics.self,
            MSCrashes.self
            ])
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
       
        self.fileLoger = self.initLogger()
        
        if let window = self.window{
            window.rootViewController = mainViewController
            window.makeKeyAndVisible()
        }
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
        
        incrementAppRuns()
        
        DDLogInfo("MasterTherm Easy Control app started.")
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        mainViewController.relogin()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

