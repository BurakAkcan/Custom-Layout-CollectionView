//
//  AppDelegate.swift
//  Basic-Flow-Layout
//
//  Created by Burak AKCAN on 1.11.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let myVC = ViewController()
        window?.rootViewController = myVC
        window?.makeKeyAndVisible()
        return true
    }
}

