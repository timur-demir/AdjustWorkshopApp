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
    

    
    // App Scheme
       func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
           // add your code below to handle deep link
           // (e.g., open deep link content)
           // incomingURL object contains the deep link
           
           handleDeeplink(url)
           
           // call the below method to send deep link to Adjust backend
           Adjust.appWillOpen(url)
           return true
       }
    
    
    
    // Universal Link
        func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
            if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
                let url = userActivity.webpageURL
                
                // add your code below to handle deep link
                // (e.g., open deep link content)
                
                handleDeeplink(url!)

                // call the below method to send deep link to Adjust backend
                Adjust.appWillOpen(url!)
            }
            return true
        }

    
    func handleDeeplink (_ url: URL){
        print("handleDeeplink is called!")
        
        let appscheme = "adjustworkshop"
        let universallink = "ks37.adj.st"
        
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL \(url.absoluteString)")
            return
        }

        if (components.scheme == appscheme){
            print("10oct23 it is an app scheme")
            print("10oct23 URL: \(url)")
            
            guard let receivedPath = components.host else {return}
            
            handlePath(receivedPath)
            
        }else if (components.scheme == "https" && components.host == universallink){
            print("10oct23 it is an Universal Link")
            print("10oct23 URL: \(url)")
            
            // define our path variable
            var receivedPAth: String
                
            // check if there is a path, and remove the slash in the beginning of the path by using dropFirst()
            if (components.path != ""){
                receivedPAth = String(components.path.dropFirst())
            }else{
                return
            }
            
            // send path to handlePath function
            handlePath(receivedPAth)
            
        }else{
            return
        }
        
    }
    
    func handlePath(_ path: String){
        print("handlePath is called!")
        
        switch path{
            case "secondpage":
                print("incoming path is secondpage")
                
                let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let homePage = mainStoryboard.instantiateViewController(withIdentifier: "secondview") as! SecondViewController
                            homePage.modalPresentationStyle = .popover
                            self.window?.rootViewController?.present(homePage, animated: true, completion: nil)
            
            case "test":
                print("incoming path is test")
            
            case "page":
                print("incoming path is page")
                let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let homePage = mainStoryboard.instantiateViewController(withIdentifier: "secondview") as! SecondViewController
                            homePage.modalPresentationStyle = .popover
                            self.window?.rootViewController?.present(homePage, animated: true, completion: nil)
            
            default:
                return
        }
    }
    
    
    
    func adjustDeeplinkResponse(_ deeplink: URL?) -> Bool {
        // add your code below to handle deep link
        // (e.g., show onboarding screens, then open deep link content)
        // deeplink object contains the deep link

        let IncomingDeferredDeeplink = deeplink?.absoluteString
        
        UserDefaults.standard.setValue(true, forKey: "isDeferredDeeplinkWaiting")
        UserDefaults.standard.setValue(IncomingDeferredDeeplink, forKey: "deferredDeeplinkURL")

        return false
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

