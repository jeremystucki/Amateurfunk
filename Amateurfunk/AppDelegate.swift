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

        let container = NSPersistentContainer(name: "QuestionsModel")
        container.loadPersistentStores(completionHandler: { _, _ in })

        let context = container.viewContext

        let section = ManagedObjectFactory<Section>(context: context).create()
        section.name = "Technik"

        let interactor = ChapterInteractor(section: section, context: context)
        let viewController = ChapterOverviewRouter.setupModule(withInteractor: interactor)

        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
    }

}
