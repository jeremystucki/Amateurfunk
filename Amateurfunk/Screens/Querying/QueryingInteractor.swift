//
//  QueryingInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QueryingInteractorInput {
    func fetchNextQuestion()

    func didSelectAnswer(_ answer: Answer)
}

protocol QueryingInteractorOutput {
    func fetchedNextQuestion(_ question: Question)
    func failedToFetchNextQuestion()
}

class QueryingInteractor {

    var presenter: QueryingInteractorOutput?

    fileprivate let questionService: QuestionService

    init(questionService: QuestionService) {
        self.questionService = questionService
    }

}

extension QueryingInteractor: QueryingInteractorInput {

    func fetchNextQuestion() {
        do {
            let question = try questionService.getQuestionForQuerying()
            presenter?.fetchedNextQuestion(question)
        } catch {
            presenter?.failedToFetchNextQuestion()
        }
    }

    // TODO: Review
    func didSelectAnswer(_ answer: Answer) {
        do {
            try questionService.registerChosenAnswer(answer)
        } catch { }
    }

}
