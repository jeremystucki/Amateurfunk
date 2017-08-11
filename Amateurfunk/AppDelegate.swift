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

    var context: NSManagedObjectContext!

    var sectionFactory: ManagedObjectFactory<Section>!
    var chapterFactory: ManagedObjectFactory<Chapter>!
    var questionFactory: ManagedObjectFactory<Question>!
    var textAnswerFactory: ManagedObjectFactory<TextAnswer>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let container = NSPersistentContainer(name: "Amateurfunk")
        container.loadPersistentStores(completionHandler: { _, _ in })

        context = container.viewContext

        removeAllSections(context: context)

        sectionFactory = ManagedObjectFactory<Section>(context: context)
        chapterFactory = ManagedObjectFactory<Chapter>(context: context)
        questionFactory = ManagedObjectFactory<Question>(context: context)
        textAnswerFactory = ManagedObjectFactory<TextAnswer>(context: context)

        let technik = getSectionFromFile(filename: "bakom_technik.json", sectionTitle: "Technik")
        let vorschriften = getSectionFromFile(filename: "bakom_vorschriften.json", sectionTitle: "Vorschriften")

        do {
            try context.save()
        } catch { }

        let questionService = CoreDataQuestionService(context: context)
        let chapterService = CoreDataChapterService(context: context)

        let technikViewController = MenuRouter.setupModule(section: technik,
                                                           chapterService: chapterService,
                                                           questionService: questionService)

        let vorschriftenViewController = MenuRouter.setupModule(section: vorschriften,
                                                                chapterService: chapterService,
                                                                questionService: questionService)

        technikViewController.tabBarItem = UITabBarItem(title: "Technik",
                                                        image: UIImage(named: "technik"),
                                                        selectedImage: UIImage(named: "technik_selected"))

        vorschriftenViewController.tabBarItem = UITabBarItem(title: "Vorschriften",
                                                             image: UIImage(named: "vorschriften"),
                                                             selectedImage: UIImage(named: "vorschriften_selected"))

        let nav1 = UINavigationController(rootViewController: technikViewController)
        let nav2 = UINavigationController(rootViewController: vorschriftenViewController)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nav1, nav2]

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .groupTableViewBackground
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()

        return true
    }

    func removeAllSections(context: NSManagedObjectContext) {
        let query = Section.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: query)

        do {
            try context.execute(deleteRequest)
        } catch { }
    }

    func getSectionFromFile(filename: String, sectionTitle: String) -> Section {
        let section = sectionFactory.create()
        section.name = sectionTitle
        section.chapters = getChaptersFromFile(filename: filename)

        return section
    }

    func getChaptersFromFile(filename: String) -> Set<Chapter> {
        let data = NSData(contentsOf: (Bundle.main.resourceURL!.appendingPathComponent(filename)))!

        guard let json = try? JSONSerialization.jsonObject(with: data as Data) as? [[String: Any]] else {
            return Set<Chapter>()
        }

        var chapters = [String: Chapter]()

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

            guard let chapterName = element["chapter"] as? String else {
                continue
            }

            if chapters[chapterName] == nil {
                let chapter = chapterFactory.create()
                chapter.title = chapterName

                chapters[chapterName] = chapter
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

            chapters[chapterName]!.questions.insert(question)
        }

        return Set(chapters.map({ $0.value }))
    }

}
