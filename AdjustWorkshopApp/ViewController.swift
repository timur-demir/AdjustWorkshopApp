//
//  ViewController.swift
//  AdjustWorkshopApp
//
//  Created by Timur Demir on 25.07.23.
//

import UIKit
import Adjust

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        
        // SOME SWIFT EXAMPLES (commented for now by using /* */)
        
        /*
        // Simple Hello World program in Swift
        print("Hello, World!")
        
        
        // Variables and Constants
        var age = 25 // Variable (can be changed)
        let name = "John" // Constant (immutable)
        
        // Data Types and Type Inference
        var score: Int = 100 // Explicitly declaring the data type
        var percentage = 95.5 // Swift infers this as a Double
        var message: String = "Your score is: " // String data type
        
        // Arrays
        var fruits = ["Apple", "Orange", "Banana"]
        fruits.append("Mango") // Adding an element to the array
        print(fruits[0]) // Accessing the first element (index starts from 0)
        
        // Conditionals
        var temperature = 25

        if temperature > 30 {
            print("It's hot outside!")
        } else if temperature > 20 {
            print("It's warm.")
        } else {
            print("It's chilly.")
        }
        
        
        // Loops
        for number in 1...5 {
            print("Number: \(number)")
        }

        var counter = 0
        while counter < 5 {
            print("Counter: \(counter)")
            counter += 1
        }
        
        for fruit in fruits{
            print("Fruit: \(fruit) \n")
        }
        
        
        // Functions
        func greet(person: String) -> String {
            return "Hello, \(person)!"
        }

        let greeting = greet(person: "Adjust Team")
        print(greeting)
        
        
        // Optionals
        var optionalName: String? = "John"
        // Use optional binding to safely unwrap the optional
        if let name = optionalName {
            print("Hello, \(name)")
        } else {
            print("Hello, stranger")
        }
        */
        
    }
    
    
    @IBAction func btnClicked(_ sender: Any) {
        
        // Print a text when the button is clicked
        print("Button is clicked!")

        // Event Token
        let event = ADJEvent(eventToken: "5x7gg8")
        
        // Setting revenue
        event?.setRevenue(10, currency: "EUR")
        
        // Callback Parameters
        event?.addCallbackParameter("workshop_parameter", value: "some_value")
        
        // Partner Parameters
        event?.addPartnerParameter("product_id", value: "12345")
        
        // Sending event request
        Adjust.trackEvent(event)
        
        // Print a text after event request is sent
        print("Adjust's trackEvent is called!")
        
        
        
        // Not related with event tracking, only for receiving attribution data
        print("Attribution Data")
        
        let attribution = Adjust.attribution()
        let tracker_name = (attribution?.trackerName)!
        let tracker_token = attribution?.trackerToken!
        
        print("Attribution Data - Tracker Name: " + tracker_name)
        print("Attribution Data - Tracker Token: " + tracker_token!)
        
    }
    

    @IBAction func secondBtnClicked(_ sender: Any) {
        
        print("second button is clicked")
        
        if UserDefaults.standard.bool(forKey: "isDeferredDeeplinkWaiting"){
            if (UserDefaults.standard.string(forKey: "deferredDeeplinkURL") != "" || UserDefaults.standard.string(forKey: "deferredDeeplinkURL") != nil) {
                      
                let deferredDeeplink = URL(string: UserDefaults.standard.string(forKey: "deferredDeeplinkURL")!)
                      
                // since we will use the deeplink set isDeferredDeeplinkWaiting as false
                UserDefaults.standard.set(false, forKey: "isDeferredDeeplinkWaiting")
                      
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.handleDeeplink(deferredDeeplink!)
                      
            }
        }else{
            // create the alert
            let alert = UIAlertController(title: "No Link to Open", message: "There is no different deeplink content.", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }

        
    }
}

