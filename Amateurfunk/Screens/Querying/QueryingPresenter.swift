//
//  QueryingPresenter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

class QueryingPresenter {

    var viewController: QueryingViewControllerInput?
    var interactor: QueryingInteractorInput?
    var router: QueryingRouterInput?

}

extension QueryingPresenter: QueryingViewControllerOutput {

    func viewDidLoad() {
        // TODO
    }

}

extension QueryingPresenter: QueryingInteractorOutput {

}