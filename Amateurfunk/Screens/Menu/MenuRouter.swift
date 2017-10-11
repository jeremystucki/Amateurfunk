import UIKit

typealias MenuServices = (chapterService: ChapterService, questionService: QuestionService)

protocol MenuRouterInput {
    func showChapterSelection()

    func showQuiz()
    func showMarkedQuestions()
}

class MenuRouter {

    var viewController: UIViewController?

    private let section: Section
    private let services: MenuServices

    init(section: Section, services: MenuServices) {
        self.section = section
        self.services = services
    }

    static func setupModule(section: Section, services: MenuServices) -> UIViewController {
        let viewController = MenuViewController(title: section.name)
        let interactor = MenuInteractor(section: section, services: services)
        let presenter = MenuPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = MenuRouter(section: section, services: services)

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension MenuRouter: MenuRouterInput {

    func showChapterSelection() {
        let view = ChapterSelectionRouter.setupModule(section: section, services: services)
        let navigationController = UINavigationController(rootViewController: view)

        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }

        viewController?.present(navigationController, animated: true)
    }

    func showQuiz() {
        let provider = QuizQuestionProvider(section: section, services: services)
        let view = QuestionRouter.setupModule(questionProvider: provider, questionService: services.questionService)

        viewController?.navigationController?.pushViewController(view, animated: true)
    }

    func showMarkedQuestions() {
        let view = MarkedQuestionsRouter.setupModule(section: section, services: services)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }

}
