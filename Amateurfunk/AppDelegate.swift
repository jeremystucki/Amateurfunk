//
//  AppDelegate.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 09.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let tabController = UITabBarController()
        tabController.setViewControllers([TechnikMenuViewController()], animated: false)

        window = UIWindow(frame: UIScreen.main.bounds)

        window!.rootViewController = tabController
        window!.rootViewController?.view.backgroundColor = .red

        window!.makeKeyAndVisible()
    }

}
