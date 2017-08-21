//
//  MarkedQuestionsPresenter.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 21.08.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

class MarkedQuestionsPresenter {

    var viewController: MarkedQuestionsViewControllerInput?
    var interactor: MarkedQuestionsInteractorInput?
    var router: MarkedQuestionsRouterInput?

}

extension MarkedQuestionsPresenter: MarkedQuestionsViewControllerOutput {

    func viewWillAppear() {
        interactor?.fetchMarkedQuestions()
    }

}

extension MarkedQuestionsPresenter: MarkedQuestionsInteractorOutput {

    func fetchedMarkedQuestions(_ questions: [Question]) {
        viewController?.displayQuestions(questions)
    }

    func failedToFetchMarkedQuestions() {
        // TODO: Implement
    }

}
