import UIKit

protocol MarkedQuestionRouterInput {

}

class MarkedQuestionRouter {

    var viewController: UIViewController?

    static func setupModule(question: Question, questionService: QuestionService) -> UIViewController {
        let viewController = QuizViewController(question: question)
        let interactor = MarkedQuestionInteractor(questionService: questionService)
        let presenter = MarkedQuestionPresenter(question: question)

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = MarkedQuestionRouter()

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension MarkedQuestionRouter: MarkedQuestionRouterInput {

}
