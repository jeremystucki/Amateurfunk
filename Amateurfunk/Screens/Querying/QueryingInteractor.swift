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

}

extension QueryingInteractor: QueryingInteractorInput {

    func fetchNextQuestion() {
        // TODO: Implement

        let question = Question(query: "Test?", answers: [TextAnswer(answer: "1", correct: false), TextAnswer(answer: "2", correct: true), TextAnswer(answer: "3", correct: false)])
        presenter?.fetchedNextQuestion(question)
    }

    func didSelectAnswer(_ answer: Answer) {
        // TODO: Implement
    }

}
