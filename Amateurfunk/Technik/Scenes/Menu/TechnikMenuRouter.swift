//
//  TechnikMenuRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 09.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol TechnikMenuRouterOutput {

}

class TechnikMenuRouter {

    let viewController: UIViewController

    init() {
        let viewController = TechnikMenuViewController()
        let interactor = TechnikMenuInteractor()
        let presenter = TechnikMenuPresenter()

        interactor.presenter = presenter
        viewController.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        self.viewController = viewController

        presenter.router = self
    }

}
