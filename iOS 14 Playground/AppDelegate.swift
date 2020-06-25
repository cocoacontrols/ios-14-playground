//
//  AppDelegate.swift
//  iOS 14 Playground
//
//  Created by Aaron Brethorst on 6/24/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let rootController = RootController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: rootController)
        window.rootViewController = nav

        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}

