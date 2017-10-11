import UIKit

typealias MarkedQuestionsServices = (chapterService: ChapterService, questionService: QuestionService)

protocol MarkedQuestionsRouterInput {
    func showQuestion(_ question: Question)
}

class MarkedQuestionsRouter {

    var viewController: UIViewController?
    var services: MarkedQuestionsServices
    var section: Section

    init(section: Section, services: MarkedQuestionsServices) {
        self.services = services
        self.section = section
    }

    static func setupModule(section: Section, services: MarkedQuestionsServices) -> UIViewController {
        let viewController = MarkedQuestionsViewController()
        let interactor = MarkedQuestionsInteractor(section: section, services: services)
        let presenter = MarkedQuestionsPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = MarkedQuestionsRouter(section: section, services: services)

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension MarkedQuestionsRouter: MarkedQuestionsRouterInput {

    func showQuestion(_ question: Question) {
        do {
            let provider = try MarkedQuestionProvider(section: section, services: services, startAt: question)
            let view = QuestionRouter.setupModule(questionProvider: provider, questionService: services.questionService)

            viewController?.navigationController?.pushViewController(view, animated: true)
        } catch {
            // TODO
        }
    }

}
