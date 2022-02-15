//
//  AppDelegate.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 29/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
     
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // Override point for customization after application launch.
      
       let window = UIWindow(frame: UIScreen.main.bounds)
       let controller = StartViewController()
       window.rootViewController = UINavigationController(rootViewController: controller)
       window.makeKeyAndVisible()
       self.window = window
      
       return true
    }



}

