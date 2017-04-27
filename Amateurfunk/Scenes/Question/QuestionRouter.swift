//
//  QuestionRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 17.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QuestionRouterInput {

}

class QuestionRouter {

    var view: UIViewController?

    static func setupModule(withChapterService questionService: QuestionService) -> UIViewController {
        let viewController = QuestionViewController()
        let presenter = QuestionPresenter()
        let router = QuestionRouter()
        let interactor = QuestionInteractor(questionService: questionService)

        interactor.output = presenter
        viewController.output = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        return viewController
    }

}

extension QuestionRouter: QuestionRouterInput {

}
