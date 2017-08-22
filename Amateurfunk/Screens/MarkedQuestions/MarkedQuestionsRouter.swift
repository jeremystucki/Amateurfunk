//
//  MarkedQuestionsRouter.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 21.08.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

typealias MarkedQuestionsServices = (chapterService: ChapterService, questionService: QuestionService)

protocol MarkedQuestionsRouterInput {
    func showQuestion(_ question: Question)
}

class MarkedQuestionsRouter {

    var viewController: UIViewController?
    var questionViewController: QuestionViewController?

    static func setupModule(section: Section, services: MarkedQuestionsServices) -> UIViewController {
        let viewController = MarkedQuestionsViewController()
        let interactor = MarkedQuestionsInteractor(section: section, services: services)
        let presenter = MarkedQuestionsPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = MarkedQuestionsRouter()

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension MarkedQuestionsRouter: MarkedQuestionsRouterInput {

    func showQuestion(_ question: Question) {
        questionViewController = QuestionViewController(question: question, presenter: self)
        viewController?.navigationController?.pushViewController(questionViewController!, animated: true)
    }

}

extension MarkedQuestionsRouter: QuestionViewControllerOutput {

    func viewDidLayoutSubviews() {
        questionViewController?.highlightCorrectAnswer()
    }

}
