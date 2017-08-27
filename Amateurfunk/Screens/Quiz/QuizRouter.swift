import UIKit

typealias QuizServices = (chapterService: ChapterService, questionService: QuestionService)

protocol QuizRouterInput {

}

class QuizRouter {

    var viewController: UIViewController?

    static func setupModule(section: Section, services: QuizServices) -> UIViewController {
        let viewController = QuizViewController(title: "Abfragen")
        let interactor = QuizInteractor(section: section, services: services)
        let presenter = QuizPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = QuizRouter()

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension QuizRouter: QuizRouterInput {

}
