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
    var router: ChapterOverviewRouter?
    var interactor: ChapterInteractorInput?

}

extension ChapterOverviewPresenter: ChapterInteractorOutput {

    func fetchedChapters(_ chapters: [Chapter]) {
        view?.displayChapters(chapters)
    }

    func failedToFetchChapters() {

    }

    func addedChapter(_ chapter: Chapter) {

    }

    func failedToAddChapter(_ chapter: Chapter) {

    }

}

extension ChapterOverviewPresenter: ChapterOverviewViewControllerOutput {

    func viewInitialized() {
        interactor?.fetchChapters()
    }

}
