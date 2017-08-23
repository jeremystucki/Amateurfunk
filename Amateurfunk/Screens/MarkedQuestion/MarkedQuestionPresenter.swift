//
//  MarkedQuestionPresenter.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 23.08.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

class MarkedQuestionPresenter {

    var viewController: MarkedQuestionViewControllerInput?
    var interactor: MarkedQuestionInteractorInput?
    var router: MarkedQuestionRouterInput?

    let question: Question
    let questionView: QuestionViewControllerInput

    init(question: Question) {
        let view = QuestionViewController(question: question)

        self.question = question
        self.questionView = view

        view.presenter = self
    }

}

extension MarkedQuestionPresenter: MarkedQuestionViewControllerOutput {

    func viewDidLoad() {
        viewController?.displayQuestion(questionView.viewController)
    }

}

extension MarkedQuestionPresenter: MarkedQuestionInteractorOutput {

}

extension MarkedQuestionPresenter: QuestionViewControllerOutput {

    func viewDidLayoutSubviews() {
        questionView.highlightCorrectAnswer()
    }

}
