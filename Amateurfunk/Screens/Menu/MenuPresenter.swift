//
//  MenuPresenter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 28.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

class MenuPresenter {

    var viewController: MenuViewControllerInput?
    var interactor: MenuInteractorInput?
    var router: MenuRouterInput?

}

extension MenuPresenter: MenuViewControllerOutput {

    func viewDidLoad() {
        interactor?.fetchNumberOfMarkedQuestions()
    }

    func didSelectChapterSelection() {
        router?.showChapterSelection()
    }

    func didSelectQuerying() {
        router?.showQuerying()
    }

    func didSelectFlashCards() {

    }

    func didSelectMarkedQuestions() {

    }

    func didSelectTestMode() {

    }

}

extension MenuPresenter: MenuInteractorOutput {

    func fetchedNumberOfMarkedQuestions(numberOfMarkedQuestions: Int) {
        if numberOfMarkedQuestions == 0 {
            return
        }

        viewController?.displayMarkedQuestions(numberOfMarkedQuestions: numberOfMarkedQuestions)
    }

    func failedToFetchNumberOfMarkedQuestions() {
        // Do nothing
    }

}
