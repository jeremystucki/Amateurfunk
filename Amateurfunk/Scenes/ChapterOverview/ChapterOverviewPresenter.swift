//
//  ChapterOverviewPresenter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 14.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

class ChapterOverviewPresenter {

    var view: ChapterOverviewViewControllerInput?
    var router: ChapterOverviewRouterInput?
    var interactor: ChapterOverviewInteractorInput?

}

extension ChapterOverviewPresenter: ChapterOverviewInteractorOutput {

    func fetchedChapters(_ chapters: [Chapter]) {
        view?.displayChapters(chapters)
    }

    func failedToFetchChapters() {
        // TODO: Display error
    }

}

extension ChapterOverviewPresenter: ChapterOverviewViewControllerOutput {

    func viewInitialized() {
        interactor?.fetchChapters()
    }

    func didSelectChapters(_ chapters: [Chapter]) {
        router?.displayQuestions(forChapters: chapters)
    }

}
