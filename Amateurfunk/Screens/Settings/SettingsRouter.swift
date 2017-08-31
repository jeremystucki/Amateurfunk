import UIKit

typealias SetttingsServices = (chapterService: ChapterService, questionService: QuestionService)

protocol SetttingsRouterInput {

}

class SetttingsRouter {

    var viewController: UIViewController?

    private let services: SetttingsServices

    init(services: SetttingsServices) {
        self.services = services
    }

    static func setupModule(services: SetttingsServices) -> UIViewController {
        let viewController = SetttingsViewController()
        let interactor = SetttingsInteractor(services: services)
        let presenter = SetttingsPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = SetttingsRouter(services: services)

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension SetttingsRouter: SetttingsRouterInput {

}
