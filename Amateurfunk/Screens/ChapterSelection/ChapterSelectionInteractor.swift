//
//  ChapterSelectionInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol ChapterSelectionInteractorInput {
    func fetchChapters()
    func fetchSelectedChapters()

    func updateSelectedChapters(selectedChapters: [Chapter])
}

protocol ChapterSelectionInteractorOutput {
    func fetchedChapters(_ chapters: [Chapter])
    func failedToFetchChapters()

    func fetchedSelectedChapters(_ selectedChapters: [Chapter])
    func failedToFetchSelectedChapters()

    func updatedSelectedChapters()
    func failedToUpdateSelectedChapters()
}

class ChapterSelectionInteractor {

    var presenter: ChapterSelectionInteractorOutput?

    fileprivate let section: Section
    fileprivate let chapterService: ChapterService
    fileprivate let questionService: QuestionService

    init(section: Section, chapterService: ChapterService, questionService: QuestionService) {
        self.section = section
        self.chapterService = chapterService
        self.questionService = questionService
    }

}

extension ChapterSelectionInteractor: ChapterSelectionInteractorInput {

    func fetchChapters() {
        do {
            let chapters = try chapterService.getAllChapters(fromSection: section)
            presenter?.fetchedChapters(chapters.sorted(by: { return $0.title.localizedStandardCompare($1.title) == .orderedAscending }))
        } catch {
            presenter?.failedToFetchChapters()
        }
    }

    func fetchSelectedChapters() {
        do {
            let selectedChapters = try chapterService.getSeletedChapters(fromSection: section)
            presenter?.fetchedSelectedChapters(selectedChapters)
        } catch {
            presenter?.failedToFetchSelectedChapters()
        }
    }

    func updateSelectedChapters(selectedChapters: [Chapter]) {
        do {
            try chapterService.setSelectedChapters(selectedChapters, forSection: section)
            presenter?.updatedSelectedChapters()
        } catch {
            presenter?.failedToUpdateSelectedChapters()
        }
    }

}
