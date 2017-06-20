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
        let container = NSPersistentContainer(name: "Amateurfunk")
        container.loadPersistentStores(completionHandler: { _, _ in })

        let context = container.viewContext

        let request = Section.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try context.execute(deleteRequest)
        } catch { }

        // ==== ==== ====

        let data = NSData(contentsOf: (Bundle.main.resourceURL!.appendingPathComponent("testdata.json")))!

        guard let json = try? JSONSerialization.jsonObject(with: data as Data) as? [[String: Any]] else {
            return false
        }

        let sectionFactory = ManagedObjectFactory<Section>(context: context)
        let section = sectionFactory.create()
        section.name = "Bakom"

        let chapterFactory = ManagedObjectFactory<Chapter>(context: context)
        let chapter = chapterFactory.create()
        chapter.title = "Alle Kapitel"
        chapter.section = section

        // ==== ==== ====

        let questionFactory = ManagedObjectFactory<Question>(context: context)
        let textAnswerFactory = ManagedObjectFactory<TextAnswer>(context: context)

        for element in json! {
            guard let query = element["question"] as? String else {
                continue
            }

            guard let correctAnswer = element["correct_answer"] as? Int else {
                continue
            }

            guard let answers = element["answers"] as? [String] else {
                continue
            }

            let question = questionFactory.create()
            question.query = query

            question.answers = Set<Answer>()

            for (index, answer) in answers.enumerated() {
                let answerObject = textAnswerFactory.create()

                answerObject.answer = answer
                answerObject.correct = (correctAnswer == index)

                question.answers.insert(answerObject)
            }

            chapter.questions.insert(question)
        }

        do {
            try context.save()
        } catch { }

        let questionService = CoreDataQuestionService(context: context)
        let chapterService = CoreDataChapterService(context: context, chapters: [chapter])

        let viewController = MenuRouter.setupModule(title: "Bakom", chapterService: chapterService, questionService: questionService)

        let navigationController = UINavigationController(rootViewController: viewController)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController]

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .groupTableViewBackground
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()

        return true
    }

}
