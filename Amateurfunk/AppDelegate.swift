import UIKit
import CoreData

var context: NSManagedObjectContext! // Fuck it I can't be bothered to deal with core data (TODO)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let container = NSPersistentContainer(name: "Amateurfunk")
        container.loadPersistentStores(completionHandler: { _, _ in })

        context = container.viewContext

        if UserDefaults.standard.object(forKey: "dataLoaded") == nil {
            let resourceURL = Bundle.main.resourceURL!
            let technikResource = resourceURL.appendingPathComponent("bakom_technik.json")
            let vorschriftenResource = resourceURL.appendingPathComponent("bakom_vorschriften.json")

            let dataloader = CoreDataDataLoader(context: context)

            do {
                try dataloader.removeAllSections()

                try dataloader.loadSectionFromFile(technikResource)
                try dataloader.loadSectionFromFile(vorschriftenResource)

                UserDefaults.standard.set(true, forKey: "dataLoaded")
            } catch {
                // TODO
            }
        }

        let chapterService = CoreDataChapterService(context: context)
        let questionService = CoreDataQuestionService(context: context)

        let services = (chapterService as ChapterService, questionService as QuestionService)

        var technikSection: Section! // TODO
        var vorschriftenSection: Section! // TODO

        do {
            technikSection = try getSection(name: "Technik")
            vorschriftenSection = try getSection(name: "Vorschriften")
        } catch {
            // TODO
        }

        let technikViewController = MenuRouter.setupModule(section: technikSection, services: services)
        let vorschriftenViewController = MenuRouter.setupModule(section: vorschriftenSection, services: services)
        let settingsViewController = SetttingsRouter.setupModule(services: services)

        technikViewController.tabBarItem = UITabBarItem(title: "Technik",
                                                        image: UIImage(named: "technik_unselected"),
                                                        selectedImage: UIImage(named: "technik_selected"))

        vorschriftenViewController.tabBarItem = UITabBarItem(title: "Vorschriften",
                                                             image: UIImage(named: "vorschriften_unselected"),
                                                             selectedImage: UIImage(named: "vorschriften_selected"))

        settingsViewController.tabBarItem = UITabBarItem(title: "Einstellungen",
                                                         image: UIImage(named: "settings_unselected"),
                                                         selectedImage: UIImage(named: "settings_selected"))

        let nav1 = UINavigationController(rootViewController: technikViewController)
        let nav2 = UINavigationController(rootViewController: vorschriftenViewController)
        let nav3 = UINavigationController(rootViewController: settingsViewController)

        if #available(iOS 11.0, *) {
            nav1.navigationBar.prefersLargeTitles = true
            nav2.navigationBar.prefersLargeTitles = true
            nav3.navigationBar.prefersLargeTitles = true
        }

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nav1, nav2, nav3] // TODO: WTF

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .groupTableViewBackground
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()

        return true
    }

    private func getSection(name: String) throws -> Section {
        let query = Section.createFetchRequest()
        query.predicate = NSPredicate(format: "name == %@", name)

        return try context.fetch(query)[0]
    }

}
