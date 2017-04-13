//
//  AppDelegate.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 09.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)

        window!.rootViewController = UIViewController()
        window!.makeKeyAndVisible()
    }

}
