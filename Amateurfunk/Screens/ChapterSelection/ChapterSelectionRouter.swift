//
//  ChapterSelectionRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 29.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

typealias ChapterSelectionServices = (chapterService: ChapterService, questionService: QuestionService)

protocol ChapterSelectionRouterInput {
    func dismissView()
}

class ChapterSelectionRouter {

    var viewController: UIViewController?

    static func setupModule(section: Section, services: ChapterSelectionServices) -> UIViewController {
        let viewController = ChapterSelectionViewController()
        let interactor = ChapterSelectionInteractor(section: section, services: services)
        let presenter = ChapterSelectionPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = ChapterSelectionRouter()

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension ChapterSelectionRouter: ChapterSelectionRouterInput {

    func dismissView() {
        viewController?.dismiss(animated: true)
    }

}
