import UIKit

protocol QuestionRouterInput {
    func dismissView()
}

class QuestionRouter {

    var viewController: UIViewController?

    static func setupModule(questionProvider: QuestionProvider, questionService: QuestionService) -> UIViewController {
        let viewController = QuestionViewController()
        let interactor = QuestionInteractor(questionProvider: questionProvider, questionService: questionService)
        let presenter = QuestionPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = QuestionRouter()

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension QuestionRouter: QuestionRouterInput {

    func dismissView() {
        viewController?.navigationController?.popViewController(animated: true)
    }

}
