import UIKit

typealias MarkedQuestionsServices = (chapterService: ChapterService, questionService: QuestionService)

protocol MarkedQuestionsRouterInput {
    func showQuestion(_ question: Question)
}

class MarkedQuestionsRouter {

    var viewController: UIViewController?
    var questionService: QuestionService

    init(questionService: QuestionService) {
        self.questionService = questionService
    }

    static func setupModule(section: Section, services: MarkedQuestionsServices) -> UIViewController {
        let viewController = MarkedQuestionsViewController()
        let interactor = MarkedQuestionsInteractor(section: section, services: services)
        let presenter = MarkedQuestionsPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = MarkedQuestionsRouter(questionService: services.questionService)

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension MarkedQuestionsRouter: MarkedQuestionsRouterInput {

    func showQuestion(_ question: Question) {
        let view = MarkedQuestionRouter.setupModule(question: question, questionService: questionService)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }

}