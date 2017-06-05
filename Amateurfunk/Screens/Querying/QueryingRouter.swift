//
//  QueryingRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QueryingRouterInput {

}

class QueryingRouter {

    var viewController: UIViewController?

    static func setupModule() -> UIViewController {
        let viewController = QueryingViewController()
        let interactor = QueryingInteractor()
        let presenter = QueryingPresenter()
        let router = QueryingRouter()

        router.viewController = viewController

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }

}

extension QueryingRouter: QueryingRouterInput {

}
