//
//  QuestionPresenter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 14.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

class QuestionPresenter {

    var view: QuestionViewControllerInput?
    var router: QuestionRouterInput?
    var interactor: QuestionInteractorInput?

}

extension QuestionPresenter: QuestionInteractorOutput {

    func fetchedNextQuestion(_ question: Question) {

    }

    func failedToFetchNextQuestion() {

    }

}

extension QuestionPresenter: QuestionViewControllerOutput {

    func viewInitialized() {
        interactor?.fetchNextQuestion()
    }

}
