import UIKit

typealias FlashcardsServices = (chapterService: ChapterService, questionService: QuestionService)

protocol FlashcardsRouterInput {
    func dismissView()
}

class FlashcardsRouter {

    var viewController: UIViewController?

    static func setupModule(section: Section, services: FlashcardsServices) -> UIViewController {
        let viewController = FlashcardsViewController()
        let interactor = FlashcardsInteractor(section: section, services: services)
        let presenter = FlashcardsPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = FlashcardsRouter()

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension FlashcardsRouter: FlashcardsRouterInput {

    func dismissView() {
        viewController?.dismiss(animated: true)
    }

}
