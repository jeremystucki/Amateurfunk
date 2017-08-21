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
    func dismissView()
}

class MarkedQuestionsRouter {

    var viewController: UIViewController?

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

    func dismissView() {
        viewController?.dismiss(animated: true)
    }

}
