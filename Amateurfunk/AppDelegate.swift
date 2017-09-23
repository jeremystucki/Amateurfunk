import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var context: NSManagedObjectContext!

//    var sectionFactory: ManagedObjectFactory<Section>!
//    var chapterFactory: ManagedObjectFactory<Chapter>!
//    var questionFactory: ManagedObjectFactory<Question>!
//    var textAnswerFactory: ManagedObjectFactory<TextAnswer>!
    
    private func getSection(name: String) -> Section {
        let query = Section.createFetchRequest()
        query.predicate = NSPredicate(format: "name == %@", name)
        
        return try! context.fetch(query).first!
    }
    
    private func setupSections() throws {
        let factory = ManagedObjectFactory<Section>(context: context)

        let technikSection = factory.create()
        technikSection.name = "Technik"
        
        let vorschriftenSection = factory.create()
        vorschriftenSection.name = "Vorschriften"
        
        try context.save()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let container = NSPersistentContainer(name: "Amateurfunk")
        container.loadPersistentStores(completionHandler: { _, _ in })
        
        context = container.viewContext

        let dataloaderService = CoreDataDataloaderService(context: context)
        let chapterService = CoreDataChapterService(context: context)
        let questionService = CoreDataQuestionService(context: context)

        if UserDefaults.standard.object(forKey: "data_version") == nil {
            do {
                try setupSections()
                try dataloaderService.loadData()
                UserDefaults.standard.set(1, forKey: "data_version")
            } catch {
                fatalError("Could not load data")
            }
        }
        
        let technik = getSection(name: "Technik")
        let vorschriften = getSection(name: "Vorschriften")

        let services = (chapterService as ChapterService, questionService as QuestionService)

        let technikViewController = MenuRouter.setupModule(section: technik, services: services)
        let vorschriftenViewController = MenuRouter.setupModule(section: vorschriften, services: services)
        let settingsViewController = SetttingsRouter.setupModule(dataloaderService: dataloaderService)

        technikViewController.tabBarItem = UITabBarItem(title: "Technik",
                                                        image: UIImage(named: "technik"),
                                                        selectedImage: UIImage(named: "technik_selected"))

        vorschriftenViewController.tabBarItem = UITabBarItem(title: "Vorschriften",
                                                             image: UIImage(named: "vorschriften"),
                                                             selectedImage: UIImage(named: "vorschriften_selected"))

        settingsViewController.tabBarItem = UITabBarItem(title: "Einstellungen",
                                                         image: UIImage(named: "gear"),
                                                         selectedImage: UIImage(named: "gear_selected"))

        let nav1 = UINavigationController(rootViewController: technikViewController)
        let nav2 = UINavigationController(rootViewController: vorschriftenViewController)
        let nav3 = UINavigationController(rootViewController: settingsViewController)

        if #available(iOS 11.0, *) {
            nav1.navigationBar.prefersLargeTitles = true
            nav2.navigationBar.prefersLargeTitles = true
            nav3.navigationBar.prefersLargeTitles = true
        }

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nav1, nav2, nav3]

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .groupTableViewBackground
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()

        return true
    }

//    func removeAllSections(context: NSManagedObjectContext) {
//        let query = Section.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: query)
//
//        do {
//            try context.execute(deleteRequest)
//        } catch { }
//    }

//    func getSectionFromFile(filename: String, sectionTitle: String) -> Section {
//        let section = sectionFactory.create()
//        section.name = sectionTitle
//        section.chapters = getChaptersFromFile(filename: filename)
//
//        return section
//    }
//
//    func getChaptersFromFile(filename: String) -> Set<Chapter> {
//        let data = NSData(contentsOf: (Bundle.main.resourceURL!.appendingPathComponent(filename)))!
//
//        guard let json = try? JSONSerialization.jsonObject(with: data as Data) as? [[String: Any]] else {
//            return Set<Chapter>()
//        }
//
//        var chapters = [String: Chapter]()
//
//        for element in json! {
//            guard let query = element["question"] as? String else {
//                continue
//            }
//
//            guard let correctAnswer = element["correct_answer"] as? Int else {
//                continue
//            }
//
//            guard let answers = element["answers"] as? [String] else {
//                continue
//            }
//
//            guard let chapterName = element["chapter"] as? String else {
//                continue
//            }
//
//            if chapters[chapterName] == nil {
//                let chapter = chapterFactory.create()
//                chapter.title = chapterName
//
//                chapters[chapterName] = chapter
//            }
//
//            let question = questionFactory.create()
//            question.query = query
//            question.answers = Set<Answer>()
//
//            for (index, answer) in answers.enumerated() {
//                let answerObject = textAnswerFactory.create()
//
//                answerObject.answer = answer
//                answerObject.correct = (correctAnswer == index)
//
//                question.answers.insert(answerObject)
//            }
//
//            chapters[chapterName]!.questions.insert(question)
//        }
//
//        return Set(chapters.map({ $0.value }))
//    }

}
