//
//  MenuInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol MenuInteractorInput {
    func fetchNumberOfMarkedQuestions()
}

protocol MenuInteractorOutput {
    func fetchedNumberOfMarkedQuestions(numberOfMarkedQuestions: Int)
    func failedToFetchNumberOfMarkedQuestions()
}

class MenuInteractor {

    var presenter: MenuInteractorOutput?

    fileprivate let section: Section
    fileprivate let questionService: QuestionService

    init(section: Section, questionService: QuestionService) {
        self.section = section
        self.questionService = questionService
    }

}

extension MenuInteractor: MenuInteractorInput {

    func fetchNumberOfMarkedQuestions() {
        do {
            let numberOfMarkedQuestions = try questionService.getNumberOfMarkedQuestions(fromSection: section)
            presenter?.fetchedNumberOfMarkedQuestions(numberOfMarkedQuestions: numberOfMarkedQuestions)
        } catch {
            presenter?.failedToFetchNumberOfMarkedQuestions()
        }
    }

}
