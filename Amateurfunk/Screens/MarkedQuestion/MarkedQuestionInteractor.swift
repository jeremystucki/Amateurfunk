//
//  MarkedQuestionInteractor.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 23.08.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol MarkedQuestionInteractorInput {
}

protocol MarkedQuestionInteractorOutput {
}

class MarkedQuestionInteractor {

    var presenter: MarkedQuestionInteractorOutput?

    private let questionService: QuestionService

    init(questionService: QuestionService) {
        self.questionService = questionService
    }

}

extension MarkedQuestionInteractor: MarkedQuestionInteractorInput {

}
