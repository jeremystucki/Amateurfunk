import UIKit

class QuestionRouter {

    static func setupModule(questionProvider: QuestionProvider, questionService: QuestionService) -> UIViewController {
        let viewController = QuestionViewController()
        let interactor = QuestionInteractor(questionProvider: questionProvider, questionService: questionService)
        let presenter = QuestionPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        return viewController
    }

}
