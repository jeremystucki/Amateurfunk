//
//  QueryingInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QueryingInteractorInput {
    func fetchNextQuestion()
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
        // TODO

        let question = Question(query: "Test?", answers: [TextAnswer(answer: "1"), TextAnswer(answer: "2"), TextAnswer(answer: "3")])
        presenter?.fetchedNextQuestion(question)
    }

}
