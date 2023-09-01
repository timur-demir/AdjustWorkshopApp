//
//  AppDelegate.swift
//  AdjustWorkshopApp
//
//  Created by Timur Demir on 25.07.23.
//

import UIKit
import Adjust

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func initAdjust(){
        
        print("initAdjust is called!")
        
        let yourAppToken = "9e96dmss2ry8"
        let environment = ADJEnvironmentSandbox as String
        let adjustConfig = ADJConfig(
            appToken: yourAppToken,
            environment: environment)
        adjustConfig?.logLevel = ADJLogLevelVerbose
        
        Adjust.appDidLaunch(adjustConfig)
        
        print("Adjust's appDidLaunch called!")
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initAdjust()
        
        return true
    }


}

