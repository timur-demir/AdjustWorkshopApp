//
//  AppDelegate.swift
//  AdjustWorkshopApp
//
//  Created by Timur Demir on 25.07.23.
//

import UIKit
import Adjust

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AdjustDelegate {

    var window: UIWindow?
    
    func initAdjust(){
        
        print("initAdjust is called!")
        
        let yourAppToken = "9e96dmss2ry8"
        let environment = ADJEnvironmentSandbox as String
        let adjustConfig = ADJConfig(
            appToken: yourAppToken,
            environment: environment)
        adjustConfig?.logLevel = ADJLogLevelVerbose
        adjustConfig?.delegate = self

        Adjust.appDidLaunch(adjustConfig)
        
        print("Adjust's appDidLaunch called!")
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initAdjust()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication){
        // ATT pop-up should be called here!
        
        
        // Show ATT dialog.
        Adjust.requestTrackingAuthorization { status in
            switch status {
                case 0:
                    // ATTrackingManagerAuthorizationStatusNotDetermined case
                    print("ATT: ATTrackingManagerAuthorizationStatusNotDetermined")
                    //self.initAdjust()
                    break
                case 1:
                    // ATTrackingManagerAuthorizationStatusRestricted case
                    print("ATT: ATTrackingManagerAuthorizationStatusRestricted")
                    //self.initAdjust()
                    break
                case 2:
                    // ATTrackingManagerAuthorizationStatusDenied case
                    print("ATT: ATTrackingManagerAuthorizationStatusDenied")
                    //self.initAdjust()
                    break
                case 3:
                    // ATTrackingManagerAuthorizationStatusAuthorized case
                    print("ATT: ATTrackingManagerAuthorizationStatusAuthorized")
                    //self.initAdjust()
                    break
                default:
                    //self.initAdjust()
                    break
            }
        }
        
    
    }
    
    
    
    func adjustAttributionChanged(_ attribution: ADJAttribution?) {
        
    }
    
    

}

