import UIKit

typealias ExamServices = (chapterService: ChapterService, questionService: QuestionService)

protocol ExamRouterInput {
    func startExam()
}

class ExamRouter {

    var viewController: UIViewController?

    private let section: Section
    private let services: ExamServices

    init(section: Section, services: ExamServices) {
        self.section = section
        self.services = services
    }

    static func setupModule(section: Section, services: ExamServices) -> UIViewController {
        let viewController = ExamViewController()
        let interactor = ExamInteractor()
        let presenter = ExamPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = ExamRouter(section: section, services: services)

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension ExamRouter: ExamRouterInput {

    func startExam() {
        do {
            let provider = try ExamQuestionProvider(section: section, services: services)
            let view = QuestionRouter.setupModule(questionProvider: provider, questionService: services.questionService)

            viewController?.navigationController?.pushViewController(view, animated: true)
        } catch {
            // TODO
        }
    }

}
