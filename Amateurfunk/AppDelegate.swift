//
//  AppDelegate.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 27.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .groupTableViewBackground

        let questionService = TestQuestionService()
        let chapterService = TestChapterService()

        let viewController = MenuRouter.setupModule(title: "Technik", chapterService: chapterService, questionService: questionService)

        let navigationController = UINavigationController(rootViewController: viewController)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController]

        window!.rootViewController = tabBarController

        window!.makeKeyAndVisible()

        return true
    }

}
