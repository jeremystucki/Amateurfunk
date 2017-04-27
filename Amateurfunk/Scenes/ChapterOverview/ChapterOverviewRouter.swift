//
//  ChapterOverviewRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 14.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol ChapterOverviewRouterInput {
    func displayQuestions(forChapters chapters: [Chapter])
}

class ChapterOverviewRouter {

    var view: UIViewController?

    static func setupModule(withChapterService chapterService: ChapterService) -> UIViewController {
        let viewController = ChapterOverviewViewController()
        let presenter = ChapterOverviewPresenter()
        let router = ChapterOverviewRouter()
        let interactor = ChapterOverviewInteractor(chapterService: chapterService)

        interactor.output = presenter
        viewController.output = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        return viewController
    }

}

extension ChapterOverviewRouter: ChapterOverviewRouterInput {

    func displayQuestions(forChapters chapters: [Chapter]) {

    }

}
