//
//  TechnikMenuPresenter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 09.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

class TechnikMenuPresenter {

    var viewController: TechnikMenuViewControllerInput!

    var interactor: TechnikMenuInteractorInput!

    var router: TechnikMenuRouter!

}

extension TechnikMenuPresenter: TechnikMenuViewControllerOutput {

}

extension TechnikMenuPresenter: TechnikMenuInteractorOutput {

}

extension TechnikMenuPresenter: TechnikMenuRouterOutput {

}
