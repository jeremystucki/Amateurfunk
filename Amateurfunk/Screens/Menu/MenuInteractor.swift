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
    fileprivate let chapterService: ChapterService
    fileprivate let questionService: QuestionService

    init(section: Section, chapterService: ChapterService, questionService: QuestionService) {
        self.section = section
        self.chapterService = chapterService
        self.questionService = questionService
    }

}

extension MenuInteractor: MenuInteractorInput {

    func fetchNumberOfMarkedQuestions() {
        do {
            let chapters = try chapterService.getSeletedChapters(fromSection: section)
            let numberOfMarkedQuestions = try questionService.getNumberOfMarkedQuestions(forChapters: chapters)
            presenter?.fetchedNumberOfMarkedQuestions(numberOfMarkedQuestions: numberOfMarkedQuestions)
        } catch {
            presenter?.failedToFetchNumberOfMarkedQuestions()
        }
    }

}
