//
//  AppDelegate.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 18/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        RootRouter.presentEntryController(in: window!)
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        RootRouter.presentGuardController(in: window!)
    }
}

