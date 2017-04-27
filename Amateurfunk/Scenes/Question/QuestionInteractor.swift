//
//  QuestionInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 17.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

protocol QuestionInteractorInput {
    func fetchNextQuestion()
}

protocol QuestionInteractorOutput {
    func fetchedNextQuestion(_ question: Question)
    func failedToFetchNextQuestion()
}

class QuestionInteractor {

    var output: QuestionInteractorOutput?

    fileprivate let questionService: QuestionService

    init(questionService: QuestionService) {
        self.questionService = questionService
    }

}

extension QuestionInteractor: QuestionInteractorInput {

    func fetchNextQuestion() {
        do {
            let question = try questionService.getNextQuestion()
            output?.fetchedNextQuestion(question)
        } catch {
            output?.failedToFetchNextQuestion()
        }
    }

}
