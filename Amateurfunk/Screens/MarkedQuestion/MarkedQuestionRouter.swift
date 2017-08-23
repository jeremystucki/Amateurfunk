//
//  MarkedQuestionRouter.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 23.08.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol MarkedQuestionRouterInput {

}

class MarkedQuestionRouter {

    var viewController: UIViewController?

    static func setupModule(question: Question, questionService: QuestionService) -> UIViewController {
        let viewController = MarkedQuestionViewController()
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
