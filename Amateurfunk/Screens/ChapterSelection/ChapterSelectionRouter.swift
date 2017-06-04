//
//  ChapterSelectionRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 29.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol ChapterSelectionRouterInput {
    func dismissView()
}

class ChapterSelectionRouter {

    var viewController: UIViewController?

    static func setupModule(chapterService: ChapterService, questionService: QuestionService) -> UIViewController {
        let viewController = ChapterSelectionViewController()
        let interactor = ChapterSelectionInteractor(chapterService: chapterService, questionService: questionService)
        let presenter = ChapterSelectionPresenter()
        let router = ChapterSelectionRouter()

        router.viewController = viewController

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }

}

extension ChapterSelectionRouter: ChapterSelectionRouterInput {

    func dismissView() {
        viewController?.dismiss(animated: true, completion: nil)
    }

}
