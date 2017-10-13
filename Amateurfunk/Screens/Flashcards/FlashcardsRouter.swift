import UIKit

typealias FlashcardsServices = (chapterService: ChapterService, questionService: QuestionService)

protocol FlashcardsRouterInput {
    func showQuestionsForStreak(_ streak: Int)
}

class FlashcardsRouter {

    var viewController: UIViewController?

    private let section: Section
    private let services: FlashcardsServices

    init(section: Section, services: FlashcardsServices) {
        self.section = section
        self.services = services
    }

    static func setupModule(section: Section, services: FlashcardsServices) -> UIViewController {
        let viewController = FlashcardsViewController()
        let interactor = FlashcardsInteractor(section: section, services: services)
        let presenter = FlashcardsPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = FlashcardsRouter(section: section, services: services)

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension FlashcardsRouter: FlashcardsRouterInput {

    func showQuestionsForStreak(_ streak: Int) {
        let provider = FlashcardsQuestionProvider(section: section, services: services, streak: streak)
        let view = QuestionRouter.setupModule(questionProvider: provider, questionService: services.questionService)

        viewController?.navigationController?.pushViewController(view, animated: true)
    }

}
