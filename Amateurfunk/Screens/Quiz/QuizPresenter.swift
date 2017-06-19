//
//  QuizPresenter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

class QuizPresenter {

    var viewController: QuizViewControllerInput?
    var interactor: QuizInteractorInput?
    var router: QuizRouterInput?

}

extension QuizPresenter: QuizViewControllerOutput {

    func viewDidLoad() {
        interactor?.fetchNextQuestion()
    }

    func didSelectAnswer(_ answer: Answer) {
        interactor?.didSelectAnswer(answer)
    }

    func didSelectNextQuestion() {
        interactor?.fetchNextQuestion()
    }

}

extension QuizPresenter: QuizInteractorOutput {

    func fetchedNextQuestion(_ question: Question) {
        viewController?.displayQuestion(question)
    }

    func failedToFetchNextQuestion() {
        // Do nothing
    }

}
