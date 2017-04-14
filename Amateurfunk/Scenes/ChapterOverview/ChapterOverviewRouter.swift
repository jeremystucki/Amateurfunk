//
//  ChapterOverviewRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 14.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

class ChapterOverviewRouter {

    var view: UIViewController?

    static func setupModule(withInteractor interactor: ChapterInteractor) -> ChapterOverviewViewController {
        let viewController = ChapterOverviewViewController()
        let presenter = ChapterOverviewPresenter()
        let router = ChapterOverviewRouter()

        viewController.output = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }

}
