//
//  QuizRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QuizRouterInput {

}

class QuizRouter {

    var viewController: UIViewController?

    static func setupModule(questionService: QuestionService, chapterService: ChapterService) -> UIViewController {
        let viewController = QuizViewController()
        let interactor = QuizInteractor(questionService: questionService, chapterService: chapterService)
        let presenter = QuizPresenter()
        let router = QuizRouter()

        router.viewController = viewController

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }

}

extension QuizRouter: QuizRouterInput {

}
