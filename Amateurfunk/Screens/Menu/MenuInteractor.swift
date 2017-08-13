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

    private let section: Section
    private let services: MenuServices

    init(section: Section, services: MenuServices) {
        self.section = section
        self.services = services
    }

}

extension MenuInteractor: MenuInteractorInput {

    func fetchNumberOfMarkedQuestions() {
        do {
            let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
            let numberOfMarkedQuestions = try services.questionService.getNumberOfMarkedQuestions(forChapters: chapters)
            presenter?.fetchedNumberOfMarkedQuestions(numberOfMarkedQuestions: numberOfMarkedQuestions)
        } catch {
            presenter?.failedToFetchNumberOfMarkedQuestions()
        }
    }

}
